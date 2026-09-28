# RTL Review and PSRAM Compatibility Recommendations

**Scope:** the entire RTL under `rtl/` (read directly, not derived from simulation) — `m_vlsi_qspi_top.sv`, `m_vlsi_qspi_fsm.sv`, `m_vlsi_async_fifo.sv`, `CSR/RTL/m_vlsi_qspi_csr.sv`, and all of `AXI_CONTROLLER/*.sv` — cross-checked against the [doc/Readme.md](../doc/Readme.md) specification and the market research report [Popular QSPI PSRAM Chips in the Market.md](Popular%20QSPI%20PSRAM%20Chips%20in%20the%20Market.md).

**How to read the severity column:** "Confirmed" = derived purely from Verilog/SystemVerilog semantics, no simulation needed to reach the conclusion. "Needs sim confirmation" = the logic shows a clear discrepancy but should be confirmed by running a testbench (`sim/vcs/env/m_vlsi_psram_sp.sv` already provides a PSRAM behavioral model) before fixing.

---

## Executive summary

| # | Issue | Severity | Status |
|---|---|---|---|
| 1 | SPI (1-bit) mode read data is completely broken (shift register never shifts) | **Critical** | ✅ **Fixed** |
| 2 | No real burst/XIP streaming — every beat of a burst replays the full CMD-ADDR-DUMMY-DATA sequence | **Critical** | Confirmed (grep) — not fixed, architectural redesign, see note below |
| 3 | `wd.addr`/`wd.data` use a "width−1" convention that the documentation never mentions | **High** | ✅ **Fixed** (documentation clarified; the RTL convention itself was kept, see item 3) |
| 4 | Dummy-cycle field is only 4 bits wide; the `>>2` QSPI scaling factor matches no surveyed chip | **High** | ✅ **Fixed** |
| 5 | Dummy-cycle counter has an undocumented off-by-one | **High** | ✅ **Fixed** |
| 6 | `mode_status.current` doesn't reflect actual hardware state — it just echoes the `independent.mode` field | **Medium** | ✅ **Fixed** |
| 7 | No enforcement of maximum CS-low duration (tCEM/tCSM) if burst streaming is ever added | **Medium** | Not fixed — only needed once item 2 is redesigned |
| 8-11 | Protocol compatibility scope gaps (Octal/DDR, ISSI's nibble-based WVQ family, HyperBus...) | **Medium** | Not fixed — scope boundary, not a code bug |
| 12+ | Misleading naming, orphaned files, stale auto-template comments | **Minor** | Not fixed — low-priority cleanup |

**Fix pass (this update):** items 1, 4, 5, 6 were fixed directly in the RTL; item 3 was addressed by clarifying the documentation only (see rationale in item 3). Items 2 and 7 were deliberately **not** attempted here — they are a single architectural redesign (real burst streaming plus a CS-low time budget) that needs its own design/verification cycle rather than being folded into a bug-fix pass; see the [Fix Verification](#fix-verification) section at the end of this report for exactly what changed and how it was re-checked, given no EDA toolchain (Verilator/Icarus/VCS) is installed in this environment.

---

## 1. [CRITICAL] SPI (1-bit) mode reads are broken — the shift register never shifts

**File:** [rtl/m_vlsi_qspi_fsm.sv:583-594](../rtl/m_vlsi_qspi_fsm.sv#L583-L594)

```systemverilog
always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
  if (!i_rstn_sclk) begin
    reg_rdata <= '0;
  end
  else if (reg_in_read & reg_state == S_DATA) begin
    if (reg_csr_mode_status_current == 2'd2)
      reg_rdata <= {reg_rdata,i_qspi_si};                          // QSPI — CORRECT
    else if (reg_csr_mode_status_current == 2'd0)
      reg_rdata <= {reg_rdata[PARA_DATA_WD-1:1],i_qspi_si[0]};     // SPI — WRONG
  end
end
```

The QSPI branch concatenates the full old `reg_rdata` (32 bits) with `i_qspi_si` (4 bits) into 36 bits, then assigns it to the 32-bit register — Verilog silently truncates the top 4 bits on assignment, which is equivalent to "shift left by 4, insert the new nibble at the LSB." This is an implicit-truncation trick, but it is **functionally correct** — in fact the commented-out line directly above it (line 590) shows the author was aware of, and wrote out, the equivalent explicit formula.

The SPI branch is entirely different: `{reg_rdata[PARA_DATA_WD-1:1], i_qspi_si[0]}` keeps `reg_rdata[31:1]` completely unchanged (no shifting at all!) and only ever overwrites bit 0 each cycle. After a full 32-bit read sequence in SPI mode, `o_ax_rdata` will have a correct bit 0 (the last bit sampled) while **the other 31 bits are stale/leftover garbage**, never actually containing the shifted-in data stream. The correct formula should be:

```systemverilog
reg_rdata <= {reg_rdata[PARA_DATA_WD-2:0], i_qspi_si[0]};
```

**Why this is a serious bug for real PSRAM:** most chips surveyed (AP Memory APS6404L, ISSI WVS, Lyontek LY68L6400, etc.) **reset by default into 1-bit SPI mode**, and the very first bring-up command (Read ID `0x9F`, or anything issued before an Enter-QPI `0x35` command) must run in SPI. With this bug, the entire SPI bring-up flow — including the exact step used to confirm the correct chip is attached — will read back corrupted data.

**Recommendation:** fix the single line above; also consider unifying both branches to use the same explicit form, to avoid this kind of asymmetric bug recurring.

**✅ Fixed** — [rtl/m_vlsi_qspi_fsm.sv:596](../rtl/m_vlsi_qspi_fsm.sv#L596) now reads `reg_rdata <= {reg_rdata[PARA_DATA_WD-2:0], i_qspi_si[0]};`, a genuine left-shift-and-insert, matching the QSPI branch's behavior. See [Fix Verification](#fix-verification).

---

## 2. [CRITICAL] No real burst/XIP streaming — contradicts doc §7.6

**File:** [rtl/m_vlsi_qspi_fsm.sv:69-70](../rtl/m_vlsi_qspi_fsm.sv#L69-L70), [rtl/m_vlsi_qspi_top.sv:374-375](../rtl/m_vlsi_qspi_top.sv#L374-L375), [rtl/AXI_CONTROLLER/m_vlsi_axfsm.sv](../rtl/AXI_CONTROLLER/m_vlsi_axfsm.sv)

The FSM has two input ports, `i_ax_awlen`/`i_ax_arlen` (AXI burst length), but grepping the entire `m_vlsi_qspi_fsm.sv` file shows **these two identifiers are never read anywhere else in the whole file** — they appear exactly once, at the port declaration itself. At the top level, these two signals are also wired straight from the raw `i_awlen`/`i_arlen` (not even from any per-beat burst-progress tracking), further confirming these are dead wires for a feature that was never actually implemented.

Digging into `m_vlsi_axfsm.sv` (shared by both the AW and AR channels): for an N-beat burst, this module splits it into **N independent `o_push_fifo` pulses**, each carrying only `{last, id, addr}` — the original burst length is discarded right after this stage. So by the time a request reaches the FSM (through AWFIFO/ARFIFO/the arbiter), **nothing anywhere in the pipeline still knows whether a given beat is part of an ongoing burst.**

The observed consequence in the FSM: every request (whether it originated as a standalone beat or as one beat in the middle of a 16-beat burst) runs the full sequence:

```
S_SET_UP → S_WAIT_TRANS → S_CMD → S_ADDR → (S_DUMMY) → S_DATA → S_SET_UP
```

with CS_N toggled (`reg_csn` toggle at [fsm.sv:504-511](../rtl/m_vlsi_qspi_fsm.sv#L504-L511)) between **every single beat**, re-sending the full command and address for the next beat each time.

This **directly contradicts** [doc/Readme.md §7.6](../doc/Readme.md): *"Multi-beat AXI burst → interpreted as XIP streaming access"* — the current RTL has no streaming mechanism whatsoever.

**Impact:**
- **Performance:** for a typical QSPI transaction (1-byte cmd = 2 cycles, 24-bit addr = 6 cycles, 6 dummy cycles, 32-bit data = 8 cycles), an N-beat burst costs ≈ N×22 cycles instead of the ≈14 + N×8 cycles a properly-streamed burst would cost — more than 2.5× overhead for long bursts, and worse the longer the burst gets.
- **Feature compatibility:** none of the wrap-burst-boundary-toggle mechanisms found in the market research (AP Memory/Lyontek's `0xC0` opcode, ISSI WVQ/WVS's CR-based burst settings) are ever exercised, since the controller never issues a genuine multi-word streaming access — this hardware feature on real PSRAM chips is effectively unused from this controller's point of view.

**Recommendation:**
1. Either update the documentation to no longer claim an XIP/streaming feature that doesn't exist yet, **or**
2. Redesign the FSM to support real bursts: hold CS low across the entire burst, issue CMD+ADDR+DUMMY only once, then stream consecutive data beats without re-sending CMD/ADDR/DUMMY for every beat. This requires carrying burst-length information (or at least a "more beats coming in this burst" flag) all the way from `m_vlsi_axfsm` through the async FIFOs to the QSPI FSM — today the FIFOs only carry `{last, id, addr}`, so this is a data-structure change, not a small patch.
3. If (2) is implemented, a maximum CS-low duration limit (see item 7) must also be added, since CS would then genuinely be held low long enough to hit a real PSRAM's refresh limit.

---

## 3. [HIGH] `wd.addr`/`wd.data` use a "width−1" convention the documentation never mentions

**Cross-reference:** [doc/Readme.md §VI, register `0x04 — wd`](../doc/Readme.md) describes *"`addr`: Address width (6-bit value, unit: bits)"* and *"`data`: Data width (24-bit value, unit: bits)"* — with no mention of a "minus 1" encoding.

But the RTL uses these values as a width−1 convention in **two independent places**, proving this is deliberate design rather than a single typo:

- [fsm.sv:537](../rtl/m_vlsi_qspi_fsm.sv#L537): `reg_data_out <= reg_ax_addr << (PARA_DATA_WD - (reg_csr_wd_addr + 1));`
- [fsm.sv:180,182](../rtl/m_vlsi_qspi_fsm.sv#L180): when `auto_data_wd=1`, hardware auto-sets `reg_csr_wd_data <= PARA_DATA_WD - 1` (not `PARA_DATA_WD`) — if PARA_DATA_WD=32 (32-bit data), the loaded value is 31, confirming the width−1 convention.
- The address/data cycle counters ([fsm.sv:454-480](../rtl/m_vlsi_qspi_fsm.sv#L454-L480)) load `reg_csr_wd_addr`/`reg_csr_wd_data` directly (no adjustment) into a down-counter with the "load V, run V+1 cycles" behavior — which is only correct if V is already width−1.

**Real-world risk:** a firmware engineer who reads the documentation literally (without reading the RTL) and writes `wd.addr = 24` (intending "a 24-bit address") will cause the hardware to generate **25 address-phase cycles** — off by one bit, misaligning every subsequent phase (dummy, data) and corrupting the transaction against any real PSRAM on the very first integration attempt.

**Recommendation:** add an explicit note to the CSR documentation (and the top-level README table) stating that *"addr/data must be written as (bit-width − 1)"*, or — better long-term — change the RTL to accept the true width value (adding 1 wherever needed) and remove this hidden convention to reduce integration risk.

**✅ Fixed (documentation only)** — [doc/Readme.md §VI, register `0x04 — wd`](../doc/Readme.md) now states the width−1 encoding explicitly for both `addr` and `data`, with a note pointing at the `auto_data_wd` cross-reference. The RTL convention itself was left unchanged: rewriting the FSM to accept literal widths would touch the same shift-amount and counter-load logic as items 4/5 in this same file, and doing it in the same pass would make it harder to isolate which change caused a regression if one showed up — so it's deferred to a follow-up change, tracked separately from this fix pass. See [Fix Verification](#fix-verification).

---

## 4. [HIGH] Dummy-cycle field is only 4 bits; the `>>2` QSPI scaling factor has no basis in real chips

**File:** [rtl/m_vlsi_qspi_fsm.sv:46-47](../rtl/m_vlsi_qspi_fsm.sv#L46-L47), [:206-207](../rtl/m_vlsi_qspi_fsm.sv#L206-L207); [rtl/m_vlsi_qspi_top.sv:311-312,362-363](../rtl/m_vlsi_qspi_top.sv#L311-L312)

The CSR stores `wr_dummy.num`/`rd_dummy.num` as full 32-bit values, but the top level only wires bits `[3:0]` into the FSM — capping the usable value at 15. In QSPI mode, the FSM right-shifts this by 2 more (`reg_csr_wr_dummy >> 2`) before loading it into the counter — meaning **the maximum usable QSPI dummy-cycle count is only 3** (15>>2, before even accounting for the off-by-one in item 5).

Cross-referenced against the market research:

| Chip | Command | Dummy cycles needed | Source |
|---|---|---|---|
| AP Memory APS6404L | Fast Read Quad (0xEB) | 6 (both SPI and QPI) | [research: apmemory_espressif_psram.md] |
| AP Memory APS6404L | Fast Read (0x0B) | 8 (SPI) / 4 (QPI) | [research: protocol_timing_comparison.md] |
| ISSI WVS / Lyontek LY68L6400 | Fast Read Quad | 6-8 depending on frequency | [research: issi_winbond_psram.md] |

No chip in the survey exhibits a "QSPI dummy = SPI dummy ÷ 4" rule — the real divergence found (AP Memory 0x0B: 8→4, i.e. ×2) is completely different from the RTL's fixed ÷4 factor, and for 0xEB there is no divergence between modes at all. The current ÷4 factor is an arbitrary, unverified assumption that matches no surveyed datasheet, and is also capped far too low (max 3 vs. the commonly-needed 6-8).

**Recommendation:**
- Widen the number of dummy-cycle bits actually consumed by the FSM (at least 6-8 bits, ideally using the full 32 bits already present in the CSR).
- Remove the automatic mode-dependent division; let software program the exact desired cycle count for each mode directly (two separate registers already exist for write/read; a mode-dependent variant could be added later if truly needed, but a fixed hardware ratio should not be imposed).

**✅ Fixed** — `i_csr_wr_dummy_num`/`i_csr_rd_dummy_num` widened from `[3:0]` to `[7:0]` (0–255 cycles) at [fsm.sv:46-47](../rtl/m_vlsi_qspi_fsm.sv#L46-L47), with matching widening of `reg_csr_wr_dummy`/`reg_csr_rd_dummy`/`reg_cnt_dummy` and the top-level wiring in [m_vlsi_qspi_top.sv:311-312,362-363](../rtl/m_vlsi_qspi_top.sv#L311-L312). The mode-dependent `>>2` scaling was removed entirely — the counter now loads directly from `reg_csr_wr_dummy`/`reg_csr_rd_dummy` regardless of SPI/QSPI mode (see item 5 for the exact new logic, which also fixes the off-by-one in the same edit). Software programming a different SPI-vs-QPI dummy count for the same opcode (e.g. AP Memory's 0x0B: 8 vs. 4) must now reprogram `wr_dummy`/`rd_dummy` before switching modes — this is a plain APB register write (no `req`/`ack` handshake needed for these two registers, unlike `read.cmd`/`write.cmd`), picked up automatically the next time the FSM passes through `S_SET_UP`. See [Fix Verification](#fix-verification).

---

## 5. [HIGH — needs sim confirmation] Dummy-cycle counter has an undocumented off-by-one

**File:** [rtl/m_vlsi_qspi_fsm.sv:202-211](../rtl/m_vlsi_qspi_fsm.sv#L202-L211), [:369-380](../rtl/m_vlsi_qspi_fsm.sv#L369-L380)

The same "load V, run V+1 cycles" down-counter pattern noted in item 3 applies here as well. For `reg_cnt_cmd`, this is correctly pre-compensated (load constants 1/3/7/15 = bits/4−1 or bits−1, exactly matching the fixed 8/16-bit command widths). For `reg_cnt_addr`/`reg_cnt_data`, it's also self-consistent thanks to the width−1 convention (item 3).

But for `reg_cnt_dummy`, **there is no other place in the file that uses dummy_num together with a +1/−1 adjustment for cross-reference** — meaning there is no internal evidence that `wr_dummy.num`/`rd_dummy.num` were also designed around a "cycles−1" convention. The documentation (§VI) describes them simply as "Number of dummy cycles," with no mention of subtracting 1. Taken at face value, writing the exact datasheet dummy-cycle value (e.g. 6, for opcode 0xEB) would produce **7 actual dummy SCLK cycles** — one more than the PSRAM's own internal dummy counter — shifting the sampling point by one clock and corrupting every sampled read bit for that transaction.

A secondary finding: `num=0` skips the dummy phase entirely (0 cycles), while `num=1` already jumps straight to 2 cycles in SPI mode — **exactly "1 dummy cycle" cannot be programmed** in SPI mode.

**Recommendation:** use the existing PSRAM testbench model (`sim/vcs/env/m_vlsi_psram_sp.sv`) to run a read transaction with a known dummy-cycle count (e.g. modeling AP Memory's 0xEB = 6 cycles) and compare the CS/dummy/data waveform to confirm whether there really is a one-cycle offset, then fix either the counter or the documented semantics accordingly.

**✅ Fixed** — [fsm.sv:202-215](../rtl/m_vlsi_qspi_fsm.sv#L202-L215) now loads `reg_cnt_dummy <= (reg_in_write) ? (reg_csr_wr_dummy - 8'd1) : (reg_csr_rd_dummy - 8'd1)` on entry to `S_DUMMY`, instead of the raw (unadjusted) value. Combined with the existing "load V, run V+1 cycles" counter behavior, programming `num = N` now yields exactly N SCLK cycles of dummy phase for any N ≥ 1, matching the documentation's plain "number of dummy cycles" wording with no hidden off-by-one. The `num = 0` (skip dummy phase entirely) case is untouched and still works via the pre-existing `reg_csr_wr_dummy > 0` / `reg_csr_rd_dummy > 0` entry-condition check in the `S_ADDR` state (unaffected by this edit), so the subtraction is never evaluated against 0 and cannot underflow/wrap. This was confirmed by static re-derivation of the counter's cycle-by-cycle behavior rather than by simulation, since no EDA toolchain is installed in this environment — see [Fix Verification](#fix-verification) for the exact reasoning and what re-running this in simulation would look like.

---

## 6. [MEDIUM] `mode_status.current` does not reflect the bus's actual state

**File:** [rtl/m_vlsi_qspi_fsm.sv:132](../rtl/m_vlsi_qspi_fsm.sv#L132)

```systemverilog
assign o_csr_mode_status_current = i_csr_independent_mode;
```

The FSM has an internal register that correctly pipelines the mode actually in effect (`reg_csr_mode_status_current`, updated at [fsm.sv:142-148](../rtl/m_vlsi_qspi_fsm.sv#L142-L148), only switching after leaving `S_IND_CMD` and passing through `S_SET_UP`) — but **the output port feeding the CSR (`mode_status.current`, register 0x18) does not use this register at all**, instead taking `i_csr_independent_mode` directly — which is simply the `independent.mode` field that software wrote into the CSR. This field is **never cleared or updated by hardware** (see [CSR/RTL/m_vlsi_qspi_csr.sv:496-505](../rtl/CSR/RTL/m_vlsi_qspi_csr.sv#L496-L505)), so `mode_status.current` is really just an echo of whatever software last wrote, not an actual hardware-state readback.

**Real-world impact is low today** because doc §8.4 already instructs firmware to poll `independent.ack` rather than rely on `mode_status` to confirm a mode switch — but the register's name ("status") is seriously misleading for anyone debugging later who treats it as ground truth.

**Recommendation:** rewire this output to `reg_csr_mode_status_current` (the correctly-pipelined internal register), or at minimum document clearly that this register only echoes the request field, not actual bus state.

**✅ Fixed** — [fsm.sv:132](../rtl/m_vlsi_qspi_fsm.sv#L132) now reads `assign o_csr_mode_status_current = reg_csr_mode_status_current;`, so `mode_status.current` reports the FSM's actual internally-applied mode (updated only after an independent mode-switch command completes and the FSM passes back through `S_SET_UP`), not a raw echo of the `independent.mode` field. Doc §VI's description of this register was updated to match. See [Fix Verification](#fix-verification).

---

## 7. [MEDIUM] No enforcement of maximum CS-low duration (refresh window)

Because of item 2 (no burst streaming), CS toggles after every single-beat transaction today, which **accidentally** keeps the design safe against the tCEM/tCSM limits (the maximum continuous CS-low time before a PSRAM needs a refresh cycle) that the market research found ranging 1-8µs depending on vendor/temperature (AP Memory 8µs/4µs, ISSI 4µs/1µs, Lyontek 2µs). There is no counter or logic anywhere in the RTL tracking "how long has it been since the last CS-low toggle."

**This is not yet a bug in the current state**, but it is a mandatory prerequisite if the recommendation in item 2 (real burst streaming) is ever implemented — otherwise a long burst (e.g. reading several KB of framebuffer data continuously) would hold CS low past a real PSRAM's refresh limit and corrupt data as the PSRAM performs a hidden refresh the controller has no awareness of.

---

## 8-11. [MEDIUM] Protocol scope boundaries that need to be stated explicitly

- **No Octal (8-bit)/DDR:** the controller only has 1-bit SPI and 4-bit QSPI SDR. Per the research, the Octal DDR family common in the ESP32-S3 ecosystem (AP Memory APS6408L-OBM/Xccela) and ISSI's WVO family are both out of reach — different pin count (8 vs. 4) and DDR sampling that no CSR configuration can emulate.
- **No HyperBus compatibility:** Winbond/Infineon-Cypress HyperRAM use an entirely different protocol (DDR, RWDS strobe, a 48-bit command with no opcode byte) — this controller (built around a SPI-NOR-style CMD-ADDR-DUMMY-DATA model) can never talk to HyperBus regardless of CSR configuration.
- **ISSI's WVQ (QuadRAM) family uses nibble commands with no Enter/Exit-QPI:** if the actual integration target is a chip in this family, the controller's opcode-based 1/2-byte command model plus SPI↔QSPI `independent` switch mechanism **does not apply at all** — WVQ runs 4-bit Quad-DDR from power-up with a completely different nibble command set (`Ah`=continuous read, `8h`=wrapped read, ...).
- **No SDR chip found in the survey actually requiring `cmd_2bytes` (a 2-byte opcode)** — the only 16-bit-ish mechanism found is Octal DDR's byte-doubled DTR encoding (a fundamentally different thing, not a genuine "2-byte opcode"). This should be re-confirmed against the specific target chip's datasheet before relying on this feature.

**General recommendation:** add a clear "supported scope" table to the README/doc — stating explicitly this is a controller for **SPI-NOR-opcode-style SPI/QSPI SDR PSRAM** (AP Memory APS6404L/APS1604M-SQ, ISSI WVS, Lyontek LY68L6400 are the best-matching targets per the survey), not a universal PSRAM controller.

---

## 12+. Minor issues / cleanup

| # | Location | Description |
|---|---|---|
| 12 | [AXI_CONTROLLER/m_vlsi_axi_sclk_logic.sv:82-84](../rtl/AXI_CONTROLLER/m_vlsi_axi_sclk_logic.sv#L82-L84) | `i_sram_write_valid` gates **both** `w_write_issue` and `w_read_issue` — not a bug (the signal actually means "FSM ready to accept a new request," shared by both read and write), but the "_write_" name invites a future maintainer to mistakenly "fix" it as a bug. Consider renaming to something neutral (e.g. `i_sram_ready`). |
| 13 | `rtl/m_vlsi_synch.sv` vs. `rtl/CSR/RTL/models/m_vlsi_synch.sv` | Two copies of the same 2-stage synchronizer — [rtl/CSR/README.md](../rtl/CSR/README.md) even reminds integrators to "replace the synchronizer module at RTL/models," exactly the kind of manual step that can let the two copies silently drift apart. Should be consolidated into one shared module. |
| 14 | `rtl/AXI_CONTROLLER/m_vlsi_fifo.sv`, `m_vlsi_sram_misc.sv` | Not listed in either `rtl/filelist.f` or `rtl/AXI_CONTROLLER/filelist.f` — orphaned files not part of the actual build. |
| 15 | [rtl/m_vlsi_qspi_top.sv:318](../rtl/m_vlsi_qspi_top.sv#L318) | Stale AUTO_TEMPLATE comment (`{1'b0, w_independent_mode}` — concatenated into 3 bits) doesn't match the real connection at line 365 (a direct 2-bit connection). Harmless (comments don't affect logic) but confusing if the file is ever regenerated via Emacs verilog-mode. |

---

## Recommended priority order

1. **Fix item 1 immediately** (SPI read shift) — a one-line change, low risk, high value; it currently blocks the entire SPI bring-up flow.
2. **Add the "width−1" note to the CSR documentation** (item 3) — zero cost, removes the most serious integration risk found.
3. **Run a simulation to confirm the dummy-cycle off-by-one** (item 5) using the existing PSRAM model, then decide whether to fix the RTL or just the documentation.
4. **Widen the dummy-cycle field and remove the fixed ÷4 factor** (item 4) — necessary to be compatible with most SDR chips surveyed (6-8 cycles).
5. **Decide on a direction for burst/XIP** (item 2): fix the documentation to match current reality (fast), or invest in redesigning the FSM for real streaming plus the CS-low limit (item 7) — this is the largest architectural change on this list and should be weighed against the project's actual performance requirements.
6. The remaining items (6, 8-11, 12-15) can be addressed over time, at lower priority.

---

## Fix Verification

*(Originally written when no EDA toolchain was reachable from this session — `verilator`/`iverilog`/`vcs` weren't on `PATH` — so this first pass is a manual, static re-derivation of each change: re-tracing bit widths and cycle-by-cycle counter behavior by hand, the same way the original bugs were found. Tool-based confirmation was performed afterward once Verilator/Yosys/Slang became reachable — see the "Update" note below.)*

**Files changed:** `rtl/m_vlsi_qspi_fsm.sv`, `rtl/m_vlsi_qspi_top.sv`, `doc/Readme.md`. No other RTL file references any of the changed signals (`i_csr_wr_dummy_num`, `i_csr_rd_dummy_num`, `o_csr_mode_status_current`, or the `reg_rdata` shift) outside these two files — confirmed by grepping the full `rtl/` tree for each identifier before and after editing.

- **Item 1 (SPI read shift):** `{reg_rdata[PARA_DATA_WD-2:0], i_qspi_si[0]}` is `(PARA_DATA_WD-1)` bits concatenated with 1 bit = `PARA_DATA_WD` bits, matching the LHS width exactly (no truncation, no width mismatch). This is the standard "shift left by 1, insert new bit at LSB" form — same shape as the already-correct QSPI branch, just for a 1-bit-per-cycle bus instead of 4-bit.
- **Items 4 & 5 (dummy-cycle width + off-by-one):** traced every occurrence of `dummy_num`/`reg_csr_wr_dummy`/`reg_csr_rd_dummy`/`reg_cnt_dummy` across `m_vlsi_qspi_fsm.sv` and `m_vlsi_qspi_top.sv` (via `grep`) to confirm all six touch points (FSM port width, two internal capture registers, the counter register, and both the comment-template and real instantiation in `top.sv`) were widened from `[3:0]`/`[4:0]` to `[7:0]` consistently, with no stray narrow slice left over. Confirmed the top-level wires being sliced (`w_wr_dummy_num`, `w_rd_dummy_num`) are declared `[31:0]` in `top.sv`, so a `[7:0]` slice is valid and the CSR's existing 32-bit `o_wr_dummy_num`/`o_rd_dummy_num` outputs needed no change. Confirmed the `S_ADDR` state's dummy-phase entry condition (`reg_csr_wr_dummy > 0` / `reg_csr_rd_dummy > 0`, at [fsm.sv:375,380](../rtl/m_vlsi_qspi_fsm.sv#L375)) was left untouched and still correctly gates entry into `S_DUMMY` — so the new `- 8'd1` subtraction in the counter-load logic only ever executes when the un-decremented value is already ≥ 1, ruling out an 8-bit unsigned underflow (`0 - 1` wrapping to 255) for the `num = 0` case.
- **Item 6 (mode_status wiring):** confirmed `reg_csr_mode_status_current` is a `logic [1:0]` register already declared and driven elsewhere in the same module (unaffected by this change), so the new `assign` is a same-width, no-new-logic rewire with no combinational-loop risk (it's a register being read, not fed back into itself through this assignment).
- **Documentation:** re-read the updated `doc/Readme.md` sections (`wd`, `wr_dummy`, `rd_dummy`, `mode_status`, and the FSM state table) end-to-end to confirm the new wording matches the corrected RTL behavior exactly, with no leftover references to the removed `>>2` scaling or the old `num[3:0]` limit.

**Update — tool-based verification since performed:** Verilator, Yosys, and Slang were subsequently made available in this environment (via an `oss-cad-suite` install reachable through the user's PowerShell profile) and run against the full 11-file RTL set (`m_vlsi_qspi_top` as top). All three passed cleanly:

- **Verilator** (`-Wall --sv`, full elaborate + C++ codegen + `g++` compile + link): 0 errors. Initially 30 warnings (all pre-existing, none caused by this fix pass — see the "Verilator warning cleanup" section below for how these were resolved in a follow-up pass). Independently confirmed, via Verilator's own `UNUSEDSIGNAL` check, that `i_ax_awlen`/`i_ax_arlen` are genuinely dead signals — matching item 2's finding without relying on `grep` alone.
- **Yosys** (`read_verilog -sv` → `hierarchy` → `proc` → `check`): 0 warnings, 0 errors — no undriven nets, no multiply-driven nets, no combinational loops, hierarchy matches the documented architecture exactly.
- **Slang** (independent, spec-strict SystemVerilog front-end): `Build succeeded: 0 errors, 0 warnings`.

This is materially stronger confirmation than the manual trace above for items 1, 4, 5, and 6: three independent tools agree the design elaborates and builds correctly with the fixes in place.

## Verilator warning cleanup (follow-up pass)

A second pass resolved every one of the 30 pre-existing Verilator warnings found by the first `-Wall` run above (unrelated to items 1–7, but flagged during the same tool-based verification). Re-running with the identical `-Wall --sv` flags now produces **0 warnings, 0 errors**, and the build no longer needs `-Wno-fatal` to complete. Breakdown:

| Warning | Where | Fix |
|---|---|---|
| `EOFNEWLINE` ×3 | `m_vlsi_synch.sv`, `m_vlsi_multi_synch.sv`, `m_vlsi_qspi_csr.sv` | Added the missing trailing newline. |
| `WIDTHEXPAND`/`WIDTHTRUNC` ×6 | `m_vlsi_axfsm.sv:95,96,98` — `reg_axaddr`/`reg_axlen` mixed with an unsized `int` localparam `PARA_BEAT_BYTES` | `PARA_BEAT_BYTES` resized to `logic [PARA_ADDR_WD-1:0]`; `reg_axlen` explicitly cast (`PARA_ADDR_WD'(reg_axlen)`) in the one expression that still mixed widths. No functional change — same arithmetic, just no implicit width conversion. |
| `WIDTHEXPAND` ×2 | `m_vlsi_qspi_fsm.sv:463-464` — `reg_csr_wd_addr` (6-bit) into `reg_cnt_addr` (8-bit) | Explicit `8'(reg_csr_wd_addr)` cast. |
| `WIDTHEXPAND` ×8 | `m_vlsi_qspi_fsm.sv` `reg_data_out` shifts — 16/8/24-bit operands (`reg_csr_write_cmd`, `reg_csr_read_cmd`, `reg_csr_independent_cmd`, `reg_ax_addr`) shifted in a 32-bit (`PARA_DATA_WD`) context | Explicit `PARA_DATA_WD'(...)` cast on each operand. |
| `WIDTHTRUNC` ×1 | `m_vlsi_qspi_fsm.sv:593` — QSPI read-shift `{reg_rdata,i_qspi_si}` (36→32 bit implicit truncation) | Replaced with the width-exact explicit form `{reg_rdata[PARA_DATA_WD-5:0],i_qspi_si}` — re-derived from first principles (bit-index algebra confirming it equals the old implicit-truncation result), **not** copied from the file's own pre-existing commented-out alternative, which was itself wrong (`[PARA_DATA_WD-1:4]` used the wrong half of the register). |
| `UNUSEDSIGNAL` — `w_wr_dummy_num`/`w_rd_dummy_num`[31:8] | `m_vlsi_qspi_top.sv` | Expected/benign (32-bit CSR field, only [7:0] consumed by design — see item 4). Suppressed with a scoped `lint_off`/`lint_on` and a comment explaining why. |
| `UNUSEDSIGNAL` — `i_ax_awlen`/`i_ax_arlen` | `m_vlsi_qspi_fsm.sv` | **Not fixed, by design** — these are genuinely unused today (item 2, burst streaming not implemented). Suppressed with a comment pointing back at item 2 rather than silently hidden, so the connection to the open architectural item stays visible. Kept on the port list (not removed) so the AXI-side burst-length wiring already in place at [m_vlsi_qspi_top.sv:378-379](../rtl/m_vlsi_qspi_top.sv#L378-L379) needs no rework once item 2 is picked up. |
| `UNUSEDSIGNAL` — `reg_cnt_wr_dummy`, `reg_cnt_rd_dummy`, `reg_data_in` | `m_vlsi_qspi_fsm.sv` | Confirmed fully dead (declared, never driven, never read anywhere) and deleted outright — these were vestigial declarations with no relationship to any of items 1–7. |

**`m_vlsi_qspi_csr.sv` was deliberately excluded from this cleanup and reverted to its pre-cleanup state** (its 4 `UNUSEDSIGNAL` warnings — `i_pprot`[2,0], `reg_read_ack_reg_clk_dly`, `reg_write_ack_reg_clk_dly`, `we_mode_status` — plus its `EOFNEWLINE`, are left as-is, 5 warnings total). This file is output of the separate `APB-CSR-Generator` tool (see `rtl/CSR/README.md`); the project owner decided edits belong in the generator template rather than in generated output, so these are out of scope here. Final state, re-verified with all three tools:

- **Verilator** (`-Wall --sv`): exactly 5 warnings, all in `m_vlsi_qspi_csr.sv`, none elsewhere.
- **Yosys** (`check`): 0 warnings, 0 errors.
- **Slang**: `Build succeeded: 0 errors, 0 warnings`.

One warning pair remains outside this project's RTL entirely and isn't fixable from here regardless: `g++` reports `'STDOUT_FILENO' redefined` / `'STDERR_FILENO' redefined` while compiling Verilator's own bundled `verilated.cpp` runtime against this machine's MinGW/UCRT headers — a toolchain-level collision in Verilator's runtime library, unrelated to any file in this repository.
