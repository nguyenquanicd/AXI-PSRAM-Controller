# QSPI/SPI PSRAM Manufacturers Beyond ISSI, Winbond, and AP Memory

Scope: verify and document real, currently-produced QSPI/SPI PSRAM chip families from manufacturers other than ISSI, Winbond, and AP Memory, per the candidate list supplied (Lyontek, Zentel/ZD Semiconductor, Puya Semiconductor, Dosilicon, Vitesa, Etron Technology, Alliance Memory, Cypress/Infineon HyperRAM) plus any others discoverable via distributor catalogs. Every candidate was checked against primary sources (official datasheets/product pages) before inclusion; several candidates on the suggested list could not be verified and are documented as excluded, with reasoning, rather than fabricated.

## Executive summary — verification status of every candidate

| Candidate | Verdict | Reason |
|---|---|---|
| **Lyontek Inc.** (Taiwan) | **VERIFIED — include** | Real, current QSPI/QPI PSRAM family (LY68L6400, LY68S6400), official datasheet obtained and fully read. |
| **Cypress/Infineon HyperRAM** | **VERIFIED — include (as comparison)** | Real, current, HyperBus-interface PSRAM (S27KL0642/S27KS0642). Official datasheet obtained and fully read. Explicitly a *different* protocol from QSPI, documented below. |
| **XTX Technology** (Shenzhen, China) | **PARTIALLY VERIFIED — include with caveats** | Company's own news page confirms a PSRAM product (announced 2016), sold only inside an MCP (multi-chip package) with SPI NOR flash under the "XT70" series. Part numbers XT70F64B64ALGIGA / XT70F128B64ALGIGA are listed by distributor LCSC, but the actual datasheet PDF could not be retrieved (blocked by distributor anti-bot page), so opcode/timing detail is a documented gap. |
| **Zentel Electronics** | **VERIFIED but reclassified — not an independent manufacturer today** | Zentel was a real Taiwanese PSRAM/DRAM maker; **AP Memory has acquired Zentel**, and Zentel's PSRAM parts (APS6404L family) are now sold as AP Memory ("APM") IoTRAM™ products. Since the task explicitly excludes AP Memory, Zentel-branded PSRAM is not treated as a separate entry — it is the same lineage as the already-excluded manufacturer. |
| **"ZD Semiconductor" (ZD-branded PSRAM)** | **NOT VERIFIED — dropped** | No company named "ZD Semiconductor" producing PSRAM could be found. Searches only surfaced an unrelated NXP marking code and a Shenzhen radio/RF company ("Shenzhen ZD Tech"). Likely a conflation with Zentel (see above) or a datecode marking, not a real PSRAM brand. |
| **Puya Semiconductor (Shanghai)** | **NOT VERIFIED — dropped** | Confirmed via the company's own site navigation: their product lines are Flash (SPI NOR), EEPROM, MCU (PY32), Analog, and KGD services only. No PSRAM category exists. |
| **Dosilicon Co., Ltd.** | **NOT VERIFIED — dropped** | Confirmed via the company's own homepage: product categories are SPI NAND Flash, PPI NAND Flash, SPI NOR Flash, DDR3(L), MCP, and LPDDR only. No PSRAM category exists. |
| **Vitesa Technology** | **NOT VERIFIED — dropped** | No company by this name could be found. (Vitesse Semiconductor is a real but unrelated GaAs/Ethernet-IC company, acquired by Microsemi in 2015, with no PSRAM products.) The name may be a mix-up with **Vilsion Technology (VTI)**, a real PSRAM maker discovered during this research — see below. |
| **Etron Technology** | **NOT VERIFIED for QSPI — dropped from main list** | Real Taiwanese DRAM company, historically cited as a co-originator of the PSRAM/CellularRAM concept, but its current official product navigation (commercial/industrial/automotive DRAM, RPC DRAM, Flash, LifeMemory) lists no PSRAM or CellularRAM product, and no serial SPI/QSPI PSRAM part number could be found anywhere (only legacy parallel-bus parts like EM6A9320 turn up on datasheet aggregators, and even those are actually a parallel DDR SDRAM, not PSRAM). |
| **Alliance Memory** | **NOT VERIFIED for QSPI — dropped from main list** | Real, current company, and it did sell PSRAM (AS1C1M16P/AS1C2M16P/AS1C4M16P families, 8–128 Mb), but every one of these is a **16-bit parallel** pseudo-SRAM (SRAM-style parallel bus, not serial SPI/QSPI), and the company's own site now lists PSRAM under an "EOL" (end-of-life) heading. Fails both the "QSPI" and "not discontinued" requirements. |
| **Vilsion Technology (VTI)** (新增발견) | **VERIFIED but out of scope — noted, not detailed** | Real, currently marketed PSRAM line (VTI108/116/132/164 series, 8–64 Mb) discovered via distributor search. Confirmed **16-bit parallel SRAM-style interface only** — no SPI/QSPI variant found — so it is out of the requested QSPI/SPI scope and is only logged here for completeness. |
| **GigaDevice** | **NOT VERIFIED — dropped** | Checked because it is a major Chinese memory vendor; it makes QSPI NAND/NOR flash and MCUs but no PSRAM product was found. |

Only **Lyontek** and **Infineon/Cypress HyperRAM** yielded enough primary-source detail to fully answer the technical key questions (opcodes, dummy cycles, timing). **XTX Technology** is documented with what could be verified, and the rest are documented as excluded with the specific evidence for exclusion, per the instruction to drop anything unverifiable rather than invent data.

---

## 1. Lyontek Inc. (Taiwan) — LY68L6400 / LY68S6400 family

### Existence and current-production status
- Lyontek Inc. is a fabless IC design company established 2003, Hsinchu, Taiwan, per its own datasheet letterhead. — [LY68L6400 datasheet Rev. 0.4, p.0](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- The manufacturer's own current product page lists **two** serial PSRAM part numbers, both marked "M/P" (mass production): **LY68L6400** (64 Mb, 3.3 V, 100 MHz) and **LY68S6400** (64 Mb, 1.8 V, 143 MHz), both in 8-pin SOP / 8-pin DFN packages, described for "IoT and wearable device applications." — [Lyontek Serial PSRAM product page](https://www.lyontek.com.tw/en/serialsram.html)
- Distributor confirmation: LY68L6400SLIT is listed as an active, stocked part on LCSC (brand page for Lyontek Inc.). — [LCSC Lyontek brand page](https://www.lcsc.com/brand-detail/11667.html), [LY68L6400SLIT product page](https://jlcpcb.com/partdetail/Lyontek_Inc-LY68L6400SLIT/C261881)
- **Caveat on supply chain (not existence):** a 2024–2025 EEVblog forum thread reports the part had become hard to source through mainstream distributors (reported as vanishing from LCSC), while Lyontek's own site still lists it as mass-production; some buyers reported only finding it via AliExpress with counterfeit-risk concerns, and users suggested AP Memory's APS6404L as a pin/function-compatible substitute. This is a distribution/counterfeiting concern, not evidence the part is discontinued by the manufacturer. — [EEVblog forum thread "What happened to Lyontek LY68L6400 PSRAM?"](https://www.eevblog.com/forum/projects/what-happened-to-lyontek-ly68l6400-psram/)

### Densities / organization / packages
- 64 Mb (8M × 8 bit), 1,024-byte page size, byte-addressable with A[22:0]. Column address AY0–AY9, Row address AX0–AX12. — [Datasheet §4, §10.1](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- Package: 8-pin, 150 mil SOP only (per this datasheet revision); ordering codes LY68L6400SL (tube) / LY68L6400SLT (tape & reel). — [Datasheet §7, Table 1](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- The current Lyontek product page additionally lists an 8-pin DFN package option and the 1.8 V LY68S6400 variant (143 Mbps). — [Lyontek Serial PSRAM product page](https://www.lyontek.com.tw/en/serialsram.html)

### Interface modes
- SPI (single I/O) and QPI (quad I/O), SDR (single data rate) only — no octal mode offered. Device powers up in SPI mode by default; QPI is entered/exited via dedicated commands. — [Datasheet §4, §10.4, §11](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

### Command opcode table (verbatim from datasheet Table: "Truth Table")
| Command | Opcode | SPI mode max freq | QPI mode max freq | Matches "industry common"? |
|---|---|---|---|---|
| Read (slow, serial I/O) | `0x03` | 33 MHz | N/A | — |
| Fast Read (serial I/O) | `0x0B` | 100 MHz | 84 MHz (as QPI CMD) | — |
| **Fast Read Quad** | `0xEB` | 100 MHz | 100 MHz* | **Matches** industry-common `0xEB` |
| Write | `0x02` | 100 MHz | 100 MHz* (same as `0x02`) | — |
| **Quad Write** | `0x38` | 100 MHz | same as `0x02` | **Matches** industry-common `0x38` |
| **Enter Quad (QPI) Mode** | `0x35` | 100 MHz | N/A | **Matches** industry-common `0x35` |
| Exit Quad Mode | `0xF5` | N/A | 100 MHz | (no "industry common" reference given for this one) |
| **Reset Enable** | `0x66` | 100 MHz | 100 MHz | **Matches** industry-common `0x66` |
| **Reset** | `0x99` | 100 MHz | 100 MHz | **Matches** industry-common `0x99` |
| Set Burst Length (toggle 1024/32 byte wrap) | `0xC0` | 100 MHz | 100 MHz | (no common-set reference given) |
| **Read ID** | `0x9F` | 100 MHz | N/A (SPI-mode only) | **Matches** industry-common `0x9F`; returns 24-bit "don't care" address field then EID: density code EID[47:45], then Manufacturer ID `0x0D`, then Known-Good-Die byte `0x5D` (PASS) / other pattern (FAIL) |
*"*Quad operations that cross a row boundary are limited to 84 MHz MAX."*
— [Datasheet §10.5 "Truth Table" and §11.4](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

**Flag: every opcode Lyontek uses for the "industry common" set the task asked to check (`0x9F`, `0x66`/`0x99`, `0xEB`, `0x38`, `0x35`) is identical to the reference values.** No deviation found for this part.

### Dummy/wait cycles per command and frequency dependency
Exact "Wait Cycle" column from the datasheet's truth table:
- `0x03` Read: 0 wait cycles (33 MHz max).
- `0x0B` Fast Read: 8 wait cycles in SPI mode (100 MHz); 4 wait cycles in QPI mode (84 MHz).
- `0xEB` Fast Read Quad: 6 wait cycles in both SPI and QPI mode (100 MHz, or 84 MHz if crossing a row boundary).
- `0x02`/`0x38` Writes: 0 wait cycles.
— [Datasheet §10.5](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

Frequency dependency is thus command-specific and explicit in the datasheet (not a configurable dummy-cycle register — Lyontek's dummy-cycle counts are fixed per opcode, unlike some flash-style QSPI PSRAMs that let you trade dummy cycles for frequency headroom via a register).

### Wrap burst support and configuration mechanism
- Reads/writes always operate in **wrap mode within 1 KB** by default; **Linear Burst with Row Boundary Crossing (RBX)** is available (for RBX-enabled part variants) as long as tCEM is respected, up to 84 MHz. — [Datasheet §10.2](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- Configuration mechanism: a single dedicated opcode `0xC0` ("Set Burst Length") **toggles** the wrap length between **1024 bytes (default) and 32 bytes** — there is no addressable configuration register; it's a stateful toggle command. This command "has no effect on RBX Enabled parts." — [Datasheet §14](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

### Refresh/timing behavior (PSRAM-specific) and max CS-low duration
- Refresh is described as "Self-managed" — no explicit refresh command is exposed to the host. — [Datasheet §4](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- **CE# (CS#) low pulse width max (tCEM): 2 µs.** All reads/writes must terminate (CE# → HIGH) promptly afterward; failing to do so "will block internal refresh operations until the device sees the read/write wordline terminated." — [Datasheet §10.6 and Table 7 "READ/WRITE Timing"](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- Power-up: on-chip voltage sensor triggers self-initialization; requires **≥150 µs** plus a user-issued Reset operation before the device is ready; during this window CLK must stay LOW, CE# must stay HIGH, and SI/SO/SIO[3:0] must stay LOW. — [Datasheet §9](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- Full read/write AC timing table (all values from Table 7): tCLK (SPI Read `0x03`) min 30.3 ns (33 MHz); tCLK (QPI Fast Read `0x0B`) min 11.9 ns (84 MHz); tCLK (all other ops) min 9.6 ns (100 MHz); tCH/tCL min 0.45×tCLK; tKHKL (clock edge rate) max 1.5 ns; tCPH (CE# HIGH between bursts) min 9.6 ns; tCEM (CE# low pulse width) **max 2 µs**; tCSP 3 ns min; tCHD 3 ns min; tSP 2.5 ns min; tHD 2 ns min; tHZ max 7 ns; tACLK (clock-to-output) max 7 ns; tKOH min 1.5 ns. — [Datasheet Table 7](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

### Operating voltage and max SCLK
- VCC = VCCQ = **2.7 V–3.6 V** (this is the 3.3 V-class LY68L6400; the 1.8 V-class sibling is LY68S6400, per the product page, not covered by this specific datasheet revision). — [Datasheet §16.2](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf), [Lyontek product page](https://www.lyontek.com.tw/en/serialsram.html)
- Max clock rate: **100 MHz** for the LY68L6400 (feature line also states "clock rate up to 100 MHz"; 84 MHz cap applies specifically to linear-burst-with-row-boundary-crossing and to any quad operation that crosses a row boundary). LY68S6400 (1.8 V variant) is rated 143 MHz per the product page (not separately datasheet-verified in this research). — [Datasheet §3–4](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- Standby current max 400 µA @ 85 °C; active read/write current max 40 mA. Operating temperature −25 °C to +85 °C. — [Datasheet §16.3](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)

### Gaps for Lyontek
- The datasheet obtained is Rev. 0.4 (2017), a "Preliminary" marking; a newer revision (LY68L6400-1.2.pdf) is referenced in search results at `lyontek.com.tw/pdf/ddr/LY68L6400-1.2.pdf` but was not independently fetched/verified in this pass — later revisions could not be cross-checked for opcode/timing changes.
- No datasheet was obtained for the 1.8 V sibling LY68S6400; its 143 MHz/1.8 V spec is sourced only from the product page, not a datasheet, and command opcodes for it were not independently confirmed (likely identical given the shared "serialsram" family page, but not verified).

---

## 2. Cypress/Infineon HyperRAM — S27KL0642 / S27KS0642 (HyperBus interface) — comparison reference

**This is documented explicitly as an important compatibility boundary, per the task's instructions: HyperRAM is a real, current, "PSRAM" product family, but it does NOT use classic QSPI/SPI — it uses HyperBus, a distinct DDR protocol. A plain QSPI/SPI controller cannot talk to it directly.**

### Existence and status
- Infineon (having acquired Cypress) currently sells the S27KL0642 (3.0 V) and S27KS0642 (1.8 V), 64 Mb HyperRAM™ self-refresh DRAM (PSRAM) with HyperBus™ interface. Datasheet document 002-24692 Rev. *I, dated 2022-04-29 — actively maintained (multiple named revisions *F through *I between 2019 and 2022). — [Infineon S27KL0642/S27KS0642 datasheet](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Currently stocked at distribution (e.g., S27KL0642DPBHI033, S27KL0642DPBHV023 on LCSC, alongside larger HyperRAM parts like S70KL1283 at 128 Mb). — [LCSC S27KL0642DPBHI033](https://www.lcsc.com/product-detail/psram_infineon-technologies-s27kl0642dpbhi033_C17356776.html), [LCSC S70KL1283GABHV023](https://www.lcsc.com/product-detail/psram_infineon-technologies-s70kl1283gabhv023_C17295895.html)

### Why HyperBus ≠ QSPI (the compatibility boundary)
- **Bus width/signals:** HyperBus uses an 8-bit bidirectional data bus DQ[7:0], a single-ended or optional differential clock (CK / CK,CK#), CS#, RESET#, and a unique bidirectional **Read-Write Data Strobe (RWDS)** signal that a classic QSPI flash/PSRAM bus does not have. 11 signals (single-ended clock) or 12 (differential clock) total. — [Datasheet, Features & I/O summary Table 1](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **DDR, not SDR:** HyperBus transfers two bytes per clock cycle (both clock edges) — up to 400 MB/s at 200 MHz clock. A classic QSPI PSRAM (e.g., Lyontek above) is SDR (one data transfer per clock edge... i.e., one nibble/byte per full clock cycle in quad mode). — [Datasheet §1.1, §2.1](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **Command/address word format is completely different from a QSPI opcode+address stream:** every HyperBus transaction begins with **three 16-bit Command-Address (CA) words** (CA0, CA1, CA2 — 48 bits total) sent as a fixed bit-field structure, not a 1-byte opcode: CA[47]=R/W#, CA[46]=Address Space (memory vs. register), CA[45]=Burst type (wrapped/linear), CA[44:16]=row/upper-column address, CA[15:3]=reserved, CA[2:0]=lower column address. There is **no equivalent of `0x9F`/`0xEB`/`0x38`-style single-byte opcodes at all** — the "opcode" is really just bit 47 of the CA word (read vs. write) combined with bit 46 (memory vs. register space). — [Datasheet §4.1, Table 3 "Command/address bit assignments"](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **RWDS-driven variable latency instead of fixed dummy cycles:** rather than a fixed dummy-cycle count per opcode (as in QSPI flash/PSRAM), HyperBus signals "additional latency" dynamically: RWDS driven HIGH during the CA phase means the transaction needs **2× the configured Initial Latency** (to allow a pending DRAM refresh to complete first); RWDS LOW means only 1× latency. The Initial Latency value itself (3–7 clocks, selects for target frequency: e.g., "7 Clock latency @ 200 MHz Max frequency," "3 Clock latency @ 85 MHz Max frequency") is stored in **Configuration Register 0 [7:4]**, accessed via HyperBus register-space transactions (CA[46]=1), not via SPI-style register-read/write opcodes. — [Datasheet §6.3.1, Table 9 "Configuration Register 0"](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **Register-space vs. memory-space addressing, not opcode dispatch:** device ID and configuration are reached by setting CA[46]=1 ("register space") with specific fixed CA field patterns (e.g., Identification Register 0 read = CA bits `C0h` or `E0h` in the top byte, then `00h 00h 00h 00h 00h`), rather than a distinct 1-byte command like `0x9F`. — [Datasheet §6.1, Table 6 "Register space address map"](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **Reset:** HyperRAM uses a dedicated hardware **RESET#** pin (active low) rather than a software `0x66`/`0x99` Reset-Enable/Reset opcode pair. There is no software reset opcode in this datasheet. — [Datasheet §9.8, Table 25](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)

**Practical implication documented for the reader:** because HyperBus needs a DDR-capable controller that understands the RWDS strobe and the CA-word protocol (and, per the datasheet, "a plain QSPI/SPI controller cannot talk to it directly"), MCUs need a **dedicated HyperBus/OctaSPI/OSPI peripheral** (e.g., STM32's OCTOSPI in HyperBus mode) — it is not software-compatible with a generic QSPI flash-style controller, even though both devices are colloquially called "PSRAM."

### Densities/organization/package
- 64 Mb, organized with 9 column address bits + 13 row address bits (2²² = 4 M words = 8 MB addressable at word granularity); 8192 rows, 512 words (1 KB) per row, 8-word (16-byte) half-pages. ID0 register value for the 64 Mb part = `0x0C81`. — [Datasheet §5.1, §6.2.1, Table 5, Table 7](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Package: 24-ball FBGA, 1 mm pitch, 5×5 array, 6 mm × 8 mm body (also available with an optional DCARS variant — DDR Center-Aligned Read Strobe — using extra PSC/PSC# pins, same 24-ball footprint). — [Datasheet §11, §13, Figure 35/38](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Note: larger-density HyperRAM parts exist in the same family line at the same distributor (e.g., S70KL1283, 128 Mb) — not separately verified in this research pass.

### Burst/wrap support
- Configurable wrapped burst lengths of **16, 32, 64, or 128 bytes** (aligned groups), plus a **linear** burst mode, plus a **"Hybrid"** mode (wrap once, then continue linear from the next aligned group) — configured via Configuration Register 0 bits [1:0] (burst length) and [2] (hybrid vs. legacy wrap), and the CA[45] "Burst type" bit per-transaction (wrapped vs. linear). — [Datasheet Features list, §6.3.2, Table 9, Table 11](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)

### Refresh/timing (PSRAM-specific) and max CS-low duration
- Distributed self-refresh: refresh logic waits for read/write idle time between transactions; if a refresh is due exactly when a new transaction starts, RWDS goes HIGH during CA to insert **additional latency** (the "refresh time," tRFH = 35 ns min at 200 MHz / 3.0 V or 1.8 V, per Table 29/30) before the row is opened. — [Datasheet §6.3.2.2, §1](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- **Max CS-low time (tCSM), i.e., the equivalent of "burst length limit": 4 µs at 85 °C, 1 µs at 105 °C** (both 200 MHz and 166 MHz speed grades) — the host must end (or the controller must auto-split) any burst before this limit to guarantee the distributed refresh schedule is met. Full array refresh interval: 64 ms at 85 °C (8192 rows) → 16 ms at 105 °C. — [Datasheet §6.3.3.4, Table 13, Table 30](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Read-write recovery time tRWR = 35 ns min (200 MHz) / 36 ns min (166 MHz). Initial access time tACC = 35 ns min (200 MHz) / 36 ns min (166 MHz). — [Datasheet Performance summary, Table 30](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Power-up: tVCS = up to 150 µs after VCC/VCCQ reach minimum and RESET# is HIGH, before first access is allowed. — [Datasheet §9.6, Table 22](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Additional low-power states not found in classic QSPI PSRAMs in this research: **Hybrid Sleep** (data retained, current reduced, exit via CS# toggle) and **Deep Power-Down** (data lost, lowest current, exit via CS# toggle) — both configured via Configuration Register bits, with defined entry/exit timing (tHSIN, tCSHS, tEXTHS, tDPDIN, tCSDPD, tEXTDPD). — [Datasheet §8.3–8.4, Tables 15–16](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)

### Operating voltage and max clock
- 1.8 V (1.7–2.0 V) or 3.0 V (2.7–3.6 V) VCC/VCCQ variants (device-family prefix S27KS = 1.8 V-only, S27KL = 3.0 V-only). — [Datasheet §9.4.2, Table 20, §14.1](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Max clock: **200 MHz** (both 1.8 V and 3.0 V), DDR → up to **400 MB/s** sustained throughput; a 166 MHz speed grade also exists. — [Datasheet Features, Table 27](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)

### Gaps for HyperRAM
- Precise die-process node beyond "38-nm DRAM" was given but no further foundry detail. — [Datasheet Performance summary](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- Larger-density HyperRAM parts (128 Mb S70KL1283 and above) were seen listed at distribution but not independently datasheet-verified for this report.

---

## 3. XTX Technology — XT70 series (partially verified; document as a gap-flagged entry)

### What is verified
- XTX Technology Inc. (Shenzhen, China, founded 2014; formerly Paragon Technology Shenzhen Limited) is a real, currently operating memory-chip design company. — [XTX Technology company profile](https://www.zoominfo.com/c/xtx-technology-limited/463227484), [official site](https://www.xtxtech.com/en/)
- XTX's own news/case-study page states: *"XTX released its PSRAM product on July 18, 2016,"* and describes the **XT70 series** as "an MCP (multi-chip package) storage solution that integrates a serial NOR flash chip and a serial PSRAM chip," used in smartwatch designs "to enhance the speed of image and audio processing." — [XTX news: "The all-rounder in smart wearable storage devices—XTX"](https://www.xtxtech.com/en/newsandevents/info.aspx?itemid=137)
- Distributor listings show concrete part numbers consistent with this MCP description: **XT70F64B64ALGIGA** and **XT70F128B64ALGIGA**, in an LGA-16 (5×6 mm) package, carried by LCSC (though LCSC's own category tag for these parts reads "NOR-FLASH", reflecting that the flash die is the addressable/primary component of the MCP). — [LCSC XT70F64B64ALGIGA listing](https://www.lcsc.com/product-detail/NOR-FLASH_XTX-XT70F64B64ALGIGA_C1884608.html), [LCSC XT70F128B datasheet link](https://datasheet.lcsc.com/szlcsc/2012222139_XTX-XT70F128B64ALGIGA_C1884607.pdf)

### What could not be verified (explicit gaps)
- The actual XT70Fxx datasheet PDF could **not** be retrieved — every fetch attempt (direct URL, browser-UA curl, referer header) returned LCSC's anti-bot HTML shell instead of the PDF content. **No opcode table, dummy-cycle counts, wrap-burst mechanism, refresh timing, voltage, or max-SCLK figures could be confirmed for XTX's PSRAM die.**
- XTX's current top-level product navigation (as of this research) shows only NOR Flash, NAND Flash/SD NAND/eMMC, MCU, and Analog&Control categories — **no standalone PSRAM product category** is presented, suggesting the PSRAM die today ships only embedded inside the NOR-flash MCP rather than as a discrete part a designer can buy alone. — [XTX product navigation](https://www.xtxtech.com/en/)
- Because of the above, XT70-series PSRAM is reported here only as a **verified-to-exist but technically undocumented** family; no opcode or timing claims are made for it.

---

## 4. Manufacturers investigated and excluded (with evidence)

### Zentel Electronics (folded into AP Memory)
- Zentel's PSRAM part numbers found in distribution (e.g., APS6404L-SQ-SN family in Zentel's own ball-assignment documents) are the same **APS6404L** part numbers sold under the **AP Memory ("APM")** brand — e.g., AP Memory's own datasheet is literally titled "APM_PSRAM_QSPI_APS6404L..." — [Zentel ball-assignment PDF reference found via search](https://zentel-europe.com/pdf/Ball%20assignment%20of%20APM%20PSRAM%20and%20LPDRAM%20products%20Q2.pdf), [AP Memory APS6404L-SQH datasheet](https://www.apmemory.com/en/downloadFiles/0324112120r9601773)
- AP Memory has acquired Zentel (confirmed via search results referencing "AP Memory Technology Corp" / Zentel Electronics Corp. LinkedIn entity and multiple secondary sources), so Zentel is not an independent PSRAM supplier distinct from the already-excluded AP Memory. — [search finding, AP Memory/Zentel LinkedIn entity](https://www.linkedin.com/company/zentel-electronics-corp.)
- Because the task explicitly excludes AP Memory, and Zentel's PSRAM lineage is AP Memory's own IoTRAM™ product line, no separate Zentel entry is included to avoid double-counting the same silicon under a different historical brand name.

### "ZD Semiconductor"
- No manufacturer named "ZD Semiconductor" producing PSRAM was found in any search. The only "ZD" hits were: (a) an unrelated NXP/other-vendor marking-code reference on a generic datasheet aggregator, and (b) "Shenzhen ZD Tech Co., Ltd.," a radar/RF/anti-drone company with no memory-chip products. — search results for `"ZD Semiconductor" PSRAM company China`
- **Conclusion: dropped as unverifiable.** Most likely explanation is a conflation with Zentel (see above) or with a wafer/date-code marking prefix, not a distinct company.

### Puya Semiconductor (Shanghai) Co., Ltd.
- Puya is real and current (NOR Flash P25Q series, EEPROM, PY32 MCU line, analog), but its own site's top-level navigation — Flash, EEPROM, MCU, Analog, KGD Service — contains **no PSRAM category at all**. — [Puya Semiconductor official homepage](https://www.puyasemi.com/en/)
- **Conclusion: dropped — Puya does not currently produce PSRAM.**

### Dosilicon Co., Ltd. (东芯半导体)
- Dosilicon is real and current (a Shanghai-headquartered, 2014-founded fabless memory company), but its own homepage product-category list is exactly: SPI NAND Flash, PPI NAND Flash, SPI NOR Flash, DDR3(L), MCP, LPDDR. **No PSRAM category.** — [Dosilicon official homepage](https://www.dosilicon.com/)
- **Conclusion: dropped — Dosilicon does not currently produce PSRAM.**

### Vitesa Technology
- No company by this exact name was found anywhere. The closest real, verifiable name is **Vitesse Semiconductor**, a GaAs/high-speed-Ethernet-IC company (founded 1984, acquired by Microsemi in 2015) with **no PSRAM or general memory products** — entirely unrelated to PSRAM. — [Vitesse Semiconductor company history](https://en.wikipedia.org/wiki/Vitesse_Semiconductor)
- **Conclusion: dropped as unverifiable / likely a name mix-up.** See Vilsion Technology below as the probable actual company the requester may have intended.

### Etron Technology, Inc.
- Etron is a real, current Taiwanese DRAM/SoC company, historically cited as one of the companies that helped establish the PSRAM/CellularRAM concept. However, its **current** official product navigation (Commercial/Industrial/Automotive DRAM, RPC DRAM®, Flash, LifeMemory®, Logic ICs) shows **no PSRAM or CellularRAM line today**, and no serial SPI/QSPI PSRAM part number could be found under the Etron brand on any distributor or the company's own site. Parts that surface on datasheet aggregators under "Etron... PSRAM" searches (e.g., EM6A9320BI-5) are actually labeled **parallel DDR SDRAM** (4M×32), not PSRAM, and not SPI/QSPI. Etron's EM73-series SPI parts found are **SPI NAND Flash**, not PSRAM. — [Etron Technology official homepage](https://etron.com/), [Etron EM73 SPI NAND Flash datasheets](https://etron.com/wp-content/uploads/2024/08/EM73E044VCEG-SPI-NAND-Flash_Rev-1.00.pdf)
- **Conclusion: dropped — no currently-produced, verifiable QSPI/SPI PSRAM product from Etron could be confirmed.**

### Alliance Memory
- Alliance Memory is real and current, and it did/does list PSRAM: AS1C1M16P / AS1C2M16P / AS1C4M16P families (8 Mb–128 Mb, 48-ball/49-ball FPBGA). — [Alliance Memory PSRAM press release](https://www.alliancememory.com/new-alliance-memory-high-speed-cmos-psrams-offer-densities-from-8mb-to-128mb-in-48-ball-and-49-ball-fpbga-packages/), [16 Mb datasheet example](https://www.alliancememory.com/wp-content/uploads/pdf/psram/AllianceMemory_16M_PSRAM_AS1C1M16P-70BIN_August2018-v1.0.pdf)
- However, every one of these parts is explicitly a **16-bit-wide parallel** pseudo-SRAM (organization "512K × 16," "2M × 16," etc. — an address/data-bus parallel part, not a 1/4-bit serial SPI/QSPI interface), and the company's current product-overview navigation now lists PSRAM under an **"EOL PSRAM"** (end-of-life) heading rather than as an active line. — [Alliance Memory product overviews page](https://www.alliancememory.com/product-overviews/)
- **Conclusion: dropped from the main list** — fails both the "QSPI" interface requirement and the "not discontinued" requirement from the task's own constraints.

### Vilsion Technology (VTI) — discovered while researching "Vitesa," logged for completeness
- Real, currently marketed pSRAM line: VTI108NA16LM / VTI108LA16LM (8 Mb), VTI116NA16LM/LA16LM (16 Mb), VTI132NA16LM/LA16LM (32 Mb), VTI164NA16LM/LA16LM (64 Mb) — each offered in both a 2.70–3.60 V and a 1.70–1.95 V version, 60/70 ns speed grades, 48-ball BGA package. — [Vilsion Technology pSRAM product list](https://www.vilsion.com/list-14-1.html)
- Confirmed **16-bit parallel SRAM-style interface** ("all listed devices use parallel SRAM-like interfaces... no SPI or QSPI pSRAM variants appear") — out of scope for this QSPI/SPI-focused research. — [Vilsion Technology pSRAM product list](https://www.vilsion.com/list-14-1.html)
- Logged here only because it was a genuine new discovery matching the task's instruction to report "any other manufacturer you discover" — but it does not meet the QSPI/SPI requirement, so no further detail (opcodes, timing) was pursued.

### GigaDevice (checked opportunistically; not on the original candidate list)
- A major, very-much-current Chinese memory/MCU vendor (NOR flash, SPI NAND flash, MCUs with QSPI peripherals). No standalone GigaDevice-branded PSRAM product was found in any search — its QSPI-related hits are all NAND flash or MCU peripherals, not PSRAM die. — search results for `GigaDevice PSRAM QSPI datasheet`
- **Conclusion: dropped — no PSRAM product found.**

---

## Answers to the task's specific cross-cutting questions

**Opcode deviations from the "industry common" set (0x9F Read ID, 0x66/0x99 Reset Enable/Reset, 0xEB Fast Read Quad, 0x38 Quad Write, 0x35 Enter QPI):**
- **Lyontek LY68L6400: no deviations found.** All five reference opcodes match exactly, confirmed directly from the datasheet's command truth table (see table above). — [Lyontek datasheet §10.5](https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/kinetis/41021/1/LY68L6400-0.4.pdf)
- **Infineon/Cypress HyperRAM: the entire premise of "single-byte opcodes" does not apply.** HyperBus has no `0x9F`/`0x66`/`0x99`/`0xEB`/`0x38`/`0x35`-style commands at all — every operation is dispatched by 2 bits (R/W# and Address-Space) inside a 48-bit Command-Address word, with device-ID/config-register access reached via register-space addressing rather than opcodes. This is flagged as the single largest "opcode-set" deviation found in this entire research pass, precisely because it isn't really an opcode set. — [Infineon datasheet §4.1, Table 3](https://www.infineon.com/dgdl/Infineon-S27KL0642_S27KS0642_3.0_V_1.8_V_64_Mb_(8_MB)_HyperRAM_Self-Refresh_DRAM-DataSheet-v09_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ee8a1c47164)
- XTX's XT70-series opcode set could not be checked (datasheet unobtainable) — logged as a gap, not assumed to match or differ.

**Dummy cycle counts / frequency dependency:** documented in full for Lyontek (fixed per-opcode wait-cycle counts, see table) and for HyperRAM (RWDS-signaled 1×/2× of a configurable 3–7 clock "Initial Latency" register value, itself indexed to target frequency, e.g. 7 clocks for 200 MHz, 3 clocks for 85 MHz) above. Not available for XTX (gap) or any of the dropped manufacturers (no verified product to measure).

**Wrap burst support and configuration mechanism:** Lyontek uses a single toggle opcode (`0xC0`) flipping between 1024-byte and 32-byte wrap, with an optional Linear/RBX mode; HyperRAM uses a Configuration-Register-based mechanism supporting 16/32/64/128-byte wrap groups plus a linear mode and a "hybrid" (wrap-then-linear) mode — a materially richer configuration space than the simple QSPI PSRAMs. See details above.

**Refresh/timing behavior vs. true SRAM, and max CS-low duration:** both verified parts are explicit that refresh is self-managed/transparent but bounded: Lyontek's tCEM (CE# low max) is **2 µs**; HyperRAM's tCSM (CS# low max) is **4 µs at 85 °C / 1 µs at 105 °C**. Both datasheets explicitly warn that violating this window blocks/risks the internal refresh cycle. This "must not hold chip-select low too long" behavior is the core practical difference from true SRAM (which has no such limit) that a controller design must respect.

**Operating voltage / max SCLK summary:**
| Part | Voltage | Max clock | Data rate |
|---|---|---|---|
| Lyontek LY68L6400 | 2.7–3.6 V | 100 MHz | SDR |
| Lyontek LY68S6400 (product-page only, not datasheet-verified) | ~1.7–2.0 V (implied by "S" 1.8V-class naming) | 143 MHz (product page) | SDR |
| Infineon/Cypress HyperRAM S27KL0642 / S27KS0642 | 1.7–2.0 V or 2.7–3.6 V | 200 MHz | **DDR** (400 MB/s) |

---

## Overall gaps (explicitly not filled, per instruction not to fabricate)

1. XTX Technology's XT70-series PSRAM: existence confirmed via the manufacturer's own news page and distributor listings, but no opcode table, dummy-cycle counts, wrap-burst mechanism, refresh timing, voltage range, or max SCLK could be sourced — the datasheet PDF was not retrievable through any method attempted.
2. Lyontek LY68S6400 (1.8 V/143 MHz sibling part): only a product-page summary was found, not a datasheet; its opcode table was assumed (not confirmed) to mirror the LY68L6400 given they share one "Serial PSRAM" product family page.
3. Whether a newer Lyontek datasheet revision (1.2, referenced in search results but not fetched) changes any opcode, dummy-cycle, or timing value from the Rev. 0.4 data reported here.
4. No manufacturer in this research batch (beyond ISSI/Winbond/AP Memory, already out of scope) was found offering **Octal**-mode QSPI-family PSRAM; only Infineon's HyperRAM (a different protocol, DDR-8-bit) and AP Memory (excluded, but noted for context as its Octal-SPI PSRAM was mentioned in a press-release title turned up during search: "AP Memory Octal-SPI PSRAM validated by Renesas RZ...") appear associated with anything beyond Quad-mode in the sources found.
5. A Chinese-language niche-memory industry report (东方财富/dfcfw.com, "利基型存储深度报告") was located that likely enumerates additional domestic PSRAM suppliers, but its PDF could not be parsed by available tooling in this pass — it is flagged as a lead for follow-up rather than a source used for any claim in this document.
