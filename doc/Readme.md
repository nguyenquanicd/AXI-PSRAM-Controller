# QSPI/SPI PSRAM Controller — Specification

**Revision:** 1.0  
**Date:** 2026-06  
**Author:** Ethan, Link  
**Page:** VLSI Technology  

---

## I. Overview

The QSPI PSRAM Controller is a hardware IP developed by **VLSI Technology** that bridges an AXI4 memory-mapped bus to an external PSRAM device over a QSPI (Quad SPI) or standard SPI interface. The IP accepts AXI4 read and write transactions from a host, translates them into the command-address-dummy-data phase sequence required by QSPI/SPI PSRAMs, and drives the I/O pads accordingly. A separate APB CSR interface allows software to configure command values, address/data widths, dummy cycles, and operating mode at run time.

Key capabilities:

- AXI4 full slave interface (AW, W, B, AR, R channels)
- APB slave interface for control and status registers
- QSPI (4-bit I/O) and SPI (1-bit I/O) protocol support
- Burst address generation for FIXED, INCR, and WRAP AXI bursts
- Software-controlled independent commands (e.g., mode switching)
- Dynamic reconfiguration of read/write commands and data widths
- XIP (Execute-In-Place) support via AXI burst semantics

---

## II. Block Diagram

> *[Insert top-level block diagram here]*

The controller comprises five major blocks:

### 1. AXI Controller

The AXI Controller accepts AXI4 read and write transactions, expands burst addresses, and buffers requests and responses. It uses **asynchronous FIFOs** so that the AXI bus clock (`ACLK`) and the internal QSPI clock (`SCLK`) remain fully decoupled.

| Sub-module | Role |
|---|---|
| `m_vlsi_axfsm` ×2  | AW/AR handshake; per-beat burst address generation (FIXED / INCR / WRAP) |
| `m_vlsi_axi_bus_logic` | Packs AXI channel payloads into FIFO write data; unpacks read/write responses from FIFO read data |
| `m_vlsi_axi_sclk_logic` | QSPI-side logic: arbitrates pending reads and writes, pops the async FIFOs, drives the target address/data/control, and pushes responses back into the return FIFOs |
| `m_vlsi_arbiter` | Round-robin arbiter between read and write requests |
| `m_vlsi_async_fifo` ×5 | Clock-domain-crossing FIFOs: AWFIFO, WFIFO, ARFIFO, BFIFO, RFIFO |

### 2. CSR (Control & Status Registers)

The CSR block (`m_vlsi_qspi_csr`) exposes an APB slave interface for software configuration. It is **asynchronous**: the APB bus operates on `PCLK` while the register file and control outputs reside in the `SCLK` (QSPI) domain. A built-in 4-phase handshake synchronises writes and reads across the two clock domains.

### 3. QSPI FSM

The QSPI FSM (`m_vlsi_qspi_fsm`) is the transaction engine. It consumes requests from the AXI controller via the async-FIFO boundary, uses CSR configuration for command values, width, and dummy-cycle counts, and executes the command–address–dummy–data phases on the QSPI pads. The FSM supports both SPI (1‑bit) and QSPI (4‑bit) modes, selected through the CSR `independent_mode` field.

### 4. Bus Logic (AXI‑side)

`m_vlsi_axi_bus_logic` is the companion module that operates in the `ACLK` domain. It receives per‑beat address/data from the AXFSMs, packs them into the write‑side FIFO interfaces, and concurrently unpacks read response data and write response status from the return FIFOs onto the AXI R and B channels.

### 5. SCLK Logic (QSPI‑side)

`m_vlsi_axi_sclk_logic` is the counterpart in the `SCLK` domain. It monitors the async FIFO empty/full flags, asserts read and write requests to the arbiter, pops address and data from the FIFOs when a request is granted, drives the target‑side interface (`sram_addr`, `sram_wdata`, `sram_we`, `sram_oe`), and writes completion responses into the BFIFO and RFIFO.

---

## III. Clocks and Resets

| Signal | Domain | Description |
|---|---|---|
| `i_aclk` / `i_aresetn` | AXI bus | AXI4 interface clock and active‑low reset |
| `i_pclk` / `i_presetn` | APB bus | APB CSR interface clock and active‑low reset |
| `i_qspi_clk` / `i_qspi_rstn` | QSPI / IP | Internal QSPI FSM and I/O clock and active‑low reset |

All three clock domains are **asynchronous** to one another. The allowed frequency range for each clock is:

| Clock | Min frequency | Max frequency |
|---|---|---|
| `i_aclk` | *TBD* | *TBD* |
| `i_pclk` | *TBD* | *TBD* |
| `i_qspi_clk` | *TBD* | *TBD* |

---

## IV. Clock Domain Crossing (CDC)

### 1. CSR — APB to QSPI Domain

The CSR module uses an asynchronous design with a 4‑phase handshake. APB writes are captured in the `PCLK` domain and synchronised to `SCLK` before updating the register file.

**Constraints required:**

```
set_max_delay -from [get_clocks PCLK] -to [get_clocks SCLK] <1.5 × period_of_SCLK>
set_max_delay -from [get_clocks SCLK] -to [get_clocks PCLK] <1.5 × period_of_PCLK>
```

### 2. AXI Controller — ACLK to SCLK Domain

The AXI controller employs five asynchronous FIFOs (`m_vlsi_async_fifo`) with Gray‑encoded pointers and 2‑stage synchronisers to cross between `ACLK` and `SCLK`.

**Constraints required:**

```
set_max_delay -from [get_clocks ACLK] -to [get_clocks SCLK] <1.5 × period_of_SCLK>
set_max_delay -from [get_clocks SCLK] -to [get_clocks ACLK] <1.5 × period_of_ACLK>
```

> **Note:** When the above CDC constraints are met, all known CDC issues are safely handled by the design.

---

## V. Configuration Registers

The CSR block implements eight 32‑bit registers accessed through the APB interface. Refer to the register map in `doc/CSR_QSPI.xlsx` for the authoritative bit layout. A summary is provided below.

| Offset | Name | Key Fields | Access | Description |
|---|---|---|---|---|
| `0x00` | `ctrl` | `cmd_2bytes` [2], `xip_en` [1], `en` [0] | RW | Control register: command byte count, XIP enable, IP enable |
| `0x04` | `wd` | `req` [31], `ack` [30], `addr` [29:24], `data` [23:0] | RWI | Width configuration request/ack, address width, data width |
| `0x08` | `read` | `req` [31], `ack` [30], `cmd` [15:0] | RWI | Read command request/ack and 16‑bit command value |
| `0x0C` | `write` | `req` [31], `ack` [30], `cmd` [15:0] | RWI | Write command request/ack and 16‑bit command value |
| `0x10` | `wr_dummy` | `num` [31:0] | RW | Number of dummy bytes for write transactions |
| `0x14` | `rd_dummy` | `num` [31:0] | RW | Number of dummy bytes for read transactions |
| `0x18` | `mode_status` | `current` [1:0] | RO | Current mode: `00` = SPI, `01` = Dual (future), `10` = QSPI, `11` = OSPI (future) |
| `0x1C` | `independent` | `req` [31], `ack` [30], `mode` [29:28], `cmd` [15:0] | RWI | Independent command request/ack, target mode, and command value |

---

## VI. Software Sequences

### 1. Normal Read and Write Access

1. Program the `read`, `write`, `wd`, `wr_dummy`, `rd_dummy`, and `ctrl` registers.
2. Issue a read or write transaction on the AXI4 interface.
3. The AXI address is used directly as the PSRAM access address.

### 2. Independent Command

An **independent command** is a command-only transaction with no data phase. A configurable dummy phase may precede or follow the command depending on the PSRAM instruction set. This mechanism is used for control operations such as switching from SPI to QSPI mode.

1. Write the desired command to `independent.cmd`, set the target mode in `independent.mode`, and assert `independent.req`.
2. Poll `independent.ack`; when it asserts, the IP has begun sending the command to the PSRAM.
3. After completion, both `independent.ack` and `independent.req` de‑assert automatically. The user may then issue a new AXI transaction.

> **Note:** If an independent request is asserted while the IP is still processing pending AXI transactions, those transactions will **complete in full** before the IP acknowledges the independent request.

### 3. Special Read / Write Command

Special commands allow the user to temporarily replace the normal read or write instruction and/or change the data/address width. Typical use cases include:

- **Read ID:** instruction code, data width, and dummy count differ from standard reads.
- **Page Read / Write:** larger data width (QSPI supports up to 2 MB).

**Sequence:**

1. Configure `read.cmd` and assert `read.req`, **or** configure `write.cmd` and assert `write.req`.
2. Configure `wd.data`, `wd.addr`, and assert `wd.req` (if width changes are needed).
3. Poll `read.ack` or `write.ack`, and `wd.ack`. When all acknowledge bits are asserted, the IP is ready to use the new command or width configuration.
4. After the special transaction completes, restore the standard command values before resuming normal memory accesses.

### 4. XIP Mode

XIP (Execute-In-Place) is not configured through a dedicated register bit; instead it is inferred from AXI burst behaviour:

- A **single-beat** AXI transaction implies **non‑XIP** operation.
- A **burst** AXI transaction may be interpreted as **XIP** operation by the downstream memory system.

The CSR field `ctrl.xip_en` is reserved for future explicit XIP control.

---

## VIII. References

| Component | Repository |
|---|---|
| AXI Controller Function | <https://github.com/nguyenquanicd/AXI4-SRAM-CONTROLLER> |
| CSR Interface (APB CSR Generator) | <https://github.com/nguyenquanicd/APB-CSR-Generator> |
| SRAM Model (used for verification) | <https://github.com/chipfoundry/EF_PSRAM_CTRL-1> |

---

## IX. Contact

This IP is developed and maintained by **VLSI Technology**.  
Designers: **Ethan**, **Link**  
For questions, please contact the VLSI Technology page.
