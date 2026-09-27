# ISSI (IS66/IS67) and Winbond QSPI/SPI PSRAM Product Families

## Densities/capacities, bus organization, and package options

### Takeaway
ISSI sells PSRAM under three distinct interface families that all share the "IS66/IS67" prefix: **WVQ** (Quad-only DDR "QuadRAM", x4, 32/64Mb, 24-ball TFBGA), **WVS** ("SerialRAM", x8, classic SPI+QPI, 8/16/32Mb, small packages: WSON/USON/SOIC/WLCSP), and **WVO/WVH** (Octal-IO "OctalRAM" and HyperRAM/HyperBus, x8, up to 512Mb, 24-ball TFBGA) — these are NOT the same protocol and must not be conflated. The part numbers the user asked about (IS66WVQ8M4, IS67WVQ8M4) are real and datasheet-confirmed; **IS66WVQ4M8, IS66WVQ16M8 and IS66WVQ32M8 as named do not exist** — under ISSI's naming, "WVQ" is always x4-organized (no "M8" variant), and the two publicly-documented WVQ densities are 8M4 (32Mb) and 16M4 (64Mb). Winbond's entire "Customized Memory Solution → PSRAM" datasheet catalog (25 documents checked) is HyperRAM/HyperBus (DDR, JEDEC HyperBus protocol, 8-bit DQ bus with differential clock) plus one legacy async CRAM part — Winbond does **not** appear to sell a classic byte-opcode SPI/QPI PSRAM comparable to ISSI's WVS family; W955D8MBYA is a HyperBus part, not a "QSPI PSRAM" in the SPI/QPI opcode sense.

### Cited Findings
- ISSI **IS66/67WVQ8M4FALL/BLL** — 32Mb QuadRAM, organized 8M words × 4 bits, package: 24-ball TFBGA 6×8mm 5×5 array ("B"), also KGD bare die ("W"). Interface: Quad DDR (x4 xSPI), JEDEC-xSPI-Flash-compatible. — [ISSI datasheet 66-67WVQ8M4FALL-BLL.pdf, Rev. A1, 12/01/2025](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- ISSI **IS66/67WVQ16M4FALL/BLL** — 64Mb QuadRAM, organized 16M words × 4 bits, same package options (24-ball TFBGA 6×8mm, or KGD). — [ISSI datasheet 66-67WVQ16M4FALL-BLL.pdf, Rev. A, 01/16/2025](https://www.issi.com/WW/pdf/66-67WVQ16M4FALL-BLL.pdf)
- ISSI's product page lists the full WVQ family lineup with public/gated datasheet links: **IS66/67WVQ2M4** (D/DA/DB/EDA/EDB variants, 8Mb — datasheet gated behind sales inquiry, no public PDF), **IS66/67WVQ4M4** (16Mb — gated), **IS66/67WVQ8M4FALL/FBLL** (32Mb — public PDF), **IS66/67WVQ16M4FALL/FBLL** (64Mb — public PDF). No WVQ*M8 variant is listed anywhere on this page. — [ISSI Serial SRAM/OctalRAM/HyperRAM product page](https://www.issi.com/US/product-serial-sram-and-serial-ram.shtml)
- ISSI **IS66/67WVS1M8ALL/BLL** ("SerialRAM") — 8Mb, organized 1M words × 8 bits, SPI(1-1-1/1-4-4) & QPI(4-4-4) protocol. Packages: 8-contact WSON 6×5mm, 8-contact USON 4×3mm, 8-pin SOIC 150mil, 12-ball WLCSP (marked "TBD" — package outline not yet finalized in this datasheet revision). Device Identification Register's Density field explicitly enumerates 000=8Mb, 001=16Mb, 010=32Mb, implying sibling parts IS66WVS2M8 (16Mb) and IS66WVS4M8 (32Mb) exist in the same SerialRAM family. — [ISSI datasheet 66-67WVS1M8ALL-BLL.pdf, Rev. A2, 07/08/2024](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- ISSI also sells **WVO** (OctalRAM, OPI protocol, x8, densities from 4M8 up to 64M8 seen in product-page links) and **WVH** (HyperRAM/HyperBus, x8, densities from 4M8 up to 64M8 seen) — both in 24-ball TFBGA 6×8mm packages; these are separate protocol families from WVQ/WVS and are out of strict scope for "QSPI" but confirm ISSI's broader PSRAM lineup. — [ISSI product page](https://www.issi.com/US/product-serial-sram-and-serial-ram.shtml)
- A DigiKey/Adafruit "Eye on NPI" writeup (secondary/distributor source, not independently re-verified against a datasheet PDF) tabulates: IS66WVS1M8ALL-104NLI (8Mbit, 1M×8, SPI/QPI, 8-SOIC), IS66WVS2M8ALL-104NLI (16Mbit, 2M×8), IS66WVS4M8ALL-104NLI (32Mbit, 4M×8), IS66WVQ8M4DALL-200BLI (32Mbit, 8M×4, SPI-Quad I/O, 24-TFBGA — this is the older "D" die revision, gated/NDA on ISSI's own site), IS66WVO8M8DBLL-166BLI (64Mbit Octal). — [Adafruit blog: "Eye on NPI – ISSI's serial and quad PSRAM chips"](https://blog.adafruit.com/2024/04/18/eye-on-npi-issis-serial-and-quad-psram-chips-digikey-digikey-issi_ww/)
- Winbond **W955D8MBYA6I** — 32Mb HyperRAM, VCC/VCCQ 1.8V, I/O width 8, package 24-ball TFBGA, interface HyperBus, max clock 166MHz, -40°C to 85°C. — [Winbond datasheet, Rev. A01-002, Sep 16 2022](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- Winbond's documentation portal (queried directly, "PSRAM" family filter, Datasheet category) lists 25 matching documents; the visible entries are all HyperRAM/HyperBus parts — W956D8MBYA (64Mb, automotive and standard grades), W955K8MBYA (32Mb 1.8V, automotive), W955N8MBYA (32Mb **3.0V**, automotive and standard), W956D8MW (64Mb HyperRAM, 15-ball WLCSP), W956D8NBRA (64Mb, "HyperRAM 2.1" — i.e. a newer JEDEC HyperBus spec revision), and one legacy part W956D6KBKX (64Mb **CRAM**, ADM/SDR — asynchronous, not DDR, not SPI-based at all). No plain "QSPI"/"QPI"-only PSRAM (byte-opcode style) appears in this list. — [Winbond Documentation search, PSRAM family filter](https://www.winbond.com/hq/support/documentation/?__locale=en&line=%2Fproduct%2Fcustomized-memory-solution%2Findex.html&family=%2Fproduct%2Fcustomized-memory-solution%2Fpsram%2Findex.html&category=%2F.categories%2Fresources%2Fdatasheet%2F)
- Winbond's PSRAM product-line landing page states general specs for its "Standard PSRAM" (parallel ADM/ADP, x16, ≥64Mb, 133MHz, 1.7–1.9V) and "HyperRAM" (up to 256Mb/512Mb, 24BGA/WLCSP/KGD packages) sub-lines. — [Winbond PSRAM product page](https://www.winbond.com/hq/product/customized-memory-solution/psram/?__locale=en)

### Inferences
- The 24-ball TFBGA 6×8mm 5×5(-1) footprint is a de-facto multi-source standard for both ISSI (WVQ, WVO, WVH) and Winbond (HyperRAM) high-density serial PSRAM, likely reflecting a common JEDEC-style ball-out for xSPI/HyperBus-class parts, even though the electrical protocols differ.
- ISSI's naming convention "WVQ**x**M**y**" reliably encodes organization: the trailing digit after "M" is always 4 for the WVQ (Quad-DDR-only) sub-family and always 8 for WVS (byte-serial SPI/QPI) and WVO/WVH (octal/HyperBus) sub-families in the parts confirmed here — a useful heuristic when guessing unseen ISSI part numbers, but per the constraints of this task we do not extend it to invent specific untested part numbers.

### Gaps
- ISSI IS66WVQ2M4 (8Mb) and IS66WVQ4M4 (16Mb) exist as valid ordering codes on ISSI's site but their datasheet PDFs are gated behind a sales/NDA "General Inquiry" link, not publicly downloadable — could not verify their AC/command-table details independently (they are presumed, but not confirmed, to match the WVQ8M4/WVQ16M4 protocol exactly).
- Could not confirm existence or specs of IS66WVS2M8/IS66WVS4M8 datasheets directly (only inferred from the ID-register density-field enumeration in the WVS1M8 datasheet and from a secondary DigiKey/Adafruit source); no primary PDF was fetched for these two.
- No evidence was found, after checking ISSI's product page and Winbond's full PSRAM documentation category, of an ISSI part named IS66WVQ4M8, IS66WVQ16M8, or IS66WVQ32M8, or of a Winbond byte-opcode (non-HyperBus) QSPI/QPI PSRAM part — these should be treated as not existing rather than guessed at.

## Interface modes supported (SPI / QSPI-QPI / Octal-OPI)

### Takeaway
ISSI splits interface mode strictly by product sub-family rather than offering one part with multiple selectable protocols: **WVQ** parts are Quad-DDR-only from power-up (no legacy single/dual SPI mode, no protocol-switch command); **WVS** parts genuinely support both legacy single-bit SPI and 4-bit QPI with an explicit mode-switch command pair; ISSI additionally sells separate **WVO** (Octal/OPI) and **WVH** (HyperRAM/HyperBus) families. Winbond's W955D8MBYA supports only the HyperBus DDR protocol (an 8-bit-wide, differential-clock, RWDS-strobed bus) — it has no SPI(1-bit) or classic QPI(4-bit) mode at all.

### Cited Findings
- ISSI WVQ8M4/WVQ16M4: "The device supports Quad DDR interface, which is compatible with JEDEC standard x4 xSPI Flash." 7 signal pins total (CS#, SCLK, DQSM, SIO0-3); command byte is single-data-rate, address/data are double-data-rate. There is no 1-bit SPI mode and no protocol-entry/exit command — the part is always in this one mode. — [ISSI 66-67WVQ8M4FALL-BLL.pdf, Rev A1, p.3](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- ISSI WVS1M8: "SPI Protocol: 1-1-1 & 1-4-4 operation" and "QPI protocol: 4-4-4 operation," selectable via the 0x35 (Enter QPI) / 0xF5 (Exit QPI) commands; power-on default is SPI mode. — [ISSI 66-67WVS1M8ALL-BLL.pdf, Rev A2, pp.2,10,15](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- ISSI's OctalRAM (WVO) line uses "OPI (Octal Peripheral Interface) protocol," 11(12)-pin signal count, up to 200MHz, with Variable or Fixed Latency burst read/write. — [ISSI product page](https://www.issi.com/US/product-serial-sram-and-serial-ram.shtml)
- Winbond W955D8MBYA: "Interface: HyperBus... Differential clock (CK/CK#)... 8-bit data bus (DQ[7:0])... Read-Write Data Strobe (RWDS)." All transactions use this single DDR HyperBus protocol; there is no alternate SPI or QPI mode described anywhere in the datasheet. — [Winbond W955D8MBYA datasheet, Rev A01-002, p.3,7](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)

### Inferences
- Because the user's key questions (Enter/Exit QPI opcodes, 0x9F/0x66/0x99/0xEB/0x38-style commands) describe exactly the ISSI **WVS** family's protocol, and the user's named example part numbers (IS66WVQ8M4, IS67WVQ8M4) belong to the **WVQ** family which has no such commands at all, a host-controller/PHY design that targets "IS66WVQ8M4" must NOT expect Enter-QPI/Exit-QPI/0x9F-style opcodes — it must implement the nibble-based xSPI DDR command set described below.

### Gaps
- None significant beyond those noted in the first section.

## Full command opcode table

### Takeaway
ISSI's WVS (SerialRAM) family opcode table matches the "classic QSPI PSRAM" opcode set the user described almost exactly (0x9F Read ID, 0x66/0x99 Reset Enable/Reset, 0xEB Fast Read Quad, 0x38 Quad Write, 0x35/0xF5 Enter/Exit QPI). ISSI's WVQ (QuadRAM) family instead uses a completely different, non-standard 4-bit ("nibble") command set with no relationship to those bytes. Winbond's HyperBus part has no discrete opcode byte at all — commands are encoded as 3 bits (R/W#, Address-Space, Burst-Type) inside a 48-bit Command/Address (CA) word.

### Cited Findings
**ISSI IS66/67WVS1M8ALL/BLL (SPI & QPI SerialRAM), Table 4.1, p.10** — [source](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf):

| Command | Opcode | SPI mode (CMD-Addr-Data / wait cycles / max freq) | QPI mode (CMD-Addr-Data / wait cycles / max freq) |
|---|---|---|---|
| Read | 03h | S-S-S / 0 wait / 33MHz | Q-Q-Q / 4 wait / 84MHz |
| Fast Read | 0Bh | S-S-S / 8 wait / 104MHz | Q-Q-Q / 4 wait / 84MHz |
| Quad IO Read | EBh | S-Q-Q (1-4-4) / 6 wait / 104MHz | Q-Q-Q / 6 wait / 104MHz |
| Write | 02h | S-S-S / 0 wait / 104MHz | Q-Q-Q / 0 wait / 104MHz |
| Quad IO Write | 38h | S-Q-Q (1-4-4) / 0 wait / 104MHz | Q-Q-Q / 0 wait / 104MHz |
| Enter QPI mode | 35h | S, no address/data | N/A (already in QPI) |
| Exit QPI mode | F5h | N/A (SPI-mode only concept) | Q, switches back to SPI |
| RESET Enable | 66h | S / 104MHz | Q / 104MHz |
| RESET | 99h | S / 104MHz | Q / 104MHz |
| Set Burst Length | C0h | S / 104MHz | Q / 104MHz |
| Read ID | 9Fh | S-S-S / 0 wait / 104MHz | Q, 6 wait / 104MHz |
| Deep Power Down Entry | B9h | S / 104MHz | Q / 104MHz |

  Note in the datasheet: "03h command in QPI mode is the same with... 0Bh command in QPI Mode." Read ID returns a 48-bit MF-ID(9Dh)+KGD(5Dh or 55h)+EID field, wrapping and repeating until CS# goes high (SPI mode) or after 6 wait cycles (QPI mode). RESET requires RESET-Enable(66h) immediately followed by RESET(99h); any other command in between cancels the reset-enable state.

- ISSI WVS1M8 In-Band Reset (an alternative to the dedicated hardware RESET# pin, used when the SPI/QPI opcodes above can't be reached because the bus is stuck): 4 CS# low/high pulses toggling SIO0 low-high-low-high triggers an internal reset; requires CS# low ≥500ns and high ≥500ns per pulse. — [same source, §5.10, p.21](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)

**ISSI IS66/67WVQ8M4FALL/BLL and WVQ16M4FALL/BLL (QuadRAM, x4 xSPI DDR), Table 4.2, p.9** — [source](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf) (identical table in the 64Mb datasheet):

| Command | Code (nibble, clock 1) | Notes |
|---|---|---|
| Memory READ with continuous burst | Ah | SDR command byte; row/col address DDR |
| Memory READ with wrapped burst | 8h | |
| Memory WRITE with continuous burst | 2h | |
| Memory WRITE with wrapped burst | 0h | |
| Identification Register read | Ch or Eh | address fields all 00h |
| Configuration Register READ | Ch or Eh | address = 00h,04h,00h,00h |
| Configuration Register WRITE | 4h or 6h | same address pattern |
| Hybrid Sleep Entry | 4h or 6h | requires D0=F0h at clock 7 and CS# low for exactly 8 cycles |

  There is **no Read-ID-as-a-standalone-opcode** (0x9F does not exist here — device ID is read through the same register-space access using command nibble Ch/Eh), **no Reset-Enable/Reset opcode pair** (reset is only via the dedicated RESET# pin or via an In-Band-Reset SIO0-toggle sequence identical in mechanism to WVS's), **no Enter-QPI/Exit-QPI opcode** (the part never leaves quad-DDR mode), and **no Fast-Read-Quad (0xEB) / Quad-Write (0x38) byte opcodes** — reads/writes are selected purely by which 1-nibble code (Ah/8h/2h/0h) is sent. — [same sources, §4, §5.3, §6.4]

**Winbond W955D8MBYA (HyperBus), Table 2 (CA bit assignments) and Table 5 (register address map)** — [source, pp.12,20](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf):
  - CA[47] R/W# (1=Read, 0=Write); CA[46] Address Space (0=memory, 1=register); CA[45] Burst Type (0=wrap for memory R/W, 1=register R/W); CA[33:22] row address; CA[21:16] upper column (half-page); CA[2:0] lower column.
  - Register-space transactions are addressed via these bits combined into a byte pattern the datasheet documents as e.g. "E0h" (read, register space, CA0 high byte) for Identification Register 0/1 reads and Configuration Register 0/1 reads, and "60h" for the corresponding writes — but this is a composed CA field, not an independent SPI-style opcode byte.
  - There is no dedicated "Reset" command opcode; reset is only via the RESET# pin (hardware) — Winbond's datasheet does not document an in-band/software reset sequence for this part.

### Inferences
- A controller designed against the user's assumed generic opcode set (0x9F/0x66/0x99/0xEB/0x38/Enter-Exit-QPI) will work correctly against ISSI's **WVS** SerialRAM family but will not work at all against ISSI's **WVQ** QuadRAM family or against Winbond's HyperBus PSRAM — these require fundamentally different command encodings.

### Gaps
- Could not obtain the WVQ2M4/WVQ4M4 (8Mb/16Mb "D-die") datasheets to confirm whether the older ISSI "D" die revision (sold via distributors, e.g. IS66WVQ8M4DBLL-133BLI on DigiKey) used the same nibble command set as the newer "F" die (FALL/FBLL, the only ones with public datasheets) or an older/different protocol — this is a real ambiguity we could not resolve from public sources.

## Dummy cycle counts per command, and their dependency on clock frequency

### Takeaway
Both ISSI families expose an explicit, datasheet-documented "latency count vs. maximum operating frequency" table — directly answering the user's question about a frequency-vs-dummy-cycle table. ISSI WVQ ties a 4-bit Configuration-Register field to both the initial latency (in clocks) and the maximum SCLK frequency permitted at that latency setting, and doubles the latency automatically whenever a refresh collision occurs. ISSI WVS gives fixed per-opcode wait-cycle counts (not user-configurable) that already differ by opcode and by SPI-vs-QPI mode. Winbond's HyperBus part uses a similar configurable-latency-vs-frequency register (CR0[7:4]), with a refresh-triggered latency doubling mechanism functionally identical to ISSI's.

### Cited Findings
- **ISSI WVQ8M4/WVQ16M4** Configuration Register bits [7:4] ("Latency count") map directly to both the number of initial latency clocks and the maximum SCLK frequency (Table 6.5, identical in both the 32Mb and 64Mb datasheets):

  | CR[7:4] | Latency (no refresh collision) | Latency (with refresh collision) | Max freq @1.8V | Max freq @3.0V |
  |---|---|---|---|---|
  | 0000 | 3 clocks | 6 clocks | 83MHz | 83MHz |
  | 0001 | 4 clocks | 8 clocks | 100MHz | 100MHz |
  | 0010 | 5 clocks | 10 clocks | 133MHz | 133MHz |
  | 0011 | 6 clocks | 12 clocks | 166MHz | 166MHz |
  | 0100 (default) | 7 clocks | 14 clocks | 200MHz | 200MHz |
  | 0101 | 8 clocks | 16 clocks | 200MHz | 200MHz |

  Register-write operations always have 0-cycle latency; register reads and all memory reads/writes use the table above (1× the value if no refresh collision, 2× if a collision occurred, when "Variable Latency" mode CR[3]=0 is selected; always 2× if "Fixed Latency" mode CR[3]=1 is selected). — [66-67WVQ8M4FALL-BLL.pdf §6.2.2 Table 6.5-6.6, p.21](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf); identical table confirmed in [66-67WVQ16M4FALL-BLL.pdf §6.2.2, p.21](https://www.issi.com/WW/pdf/66-67WVQ16M4FALL-BLL.pdf)
- ISSI WVQ AC-characteristics tables give the actual clock-period-based latency-count minimums separately at 200MHz and 166MHz (`LC` = 7 clocks min at 200MHz, 6 clocks min at 166MHz, for both read and write) — consistent with the CR table above. — [66-67WVQ8M4FALL-BLL.pdf §7.6.1/7.6.2, pp.32-33](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- **ISSI WVS1M8** wait-cycle counts are fixed per opcode (not register-configurable): Read(03h)=0 wait cycles (max 33MHz SPI / 84MHz QPI-equivalent via 03h), Fast Read(0Bh)=8 wait cycles in SPI mode but only 4 wait cycles in QPI mode (max 104MHz SPI / 84MHz QPI), Quad-IO Read(EBh)=6 wait cycles in both SPI and QPI mode (max 104MHz both), Write(02h)/Quad-Write(38h)=0 wait cycles (max 104MHz). Read-ID(9Fh) has 0 wait cycles in SPI mode but 6 wait cycles in QPI mode. — [66-67WVS1M8ALL-BLL.pdf Table 4.1, p.10](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- **Winbond W955D8MBYA** Configuration Register 0 bits [7:4] ("Initial Latency"): 0000b=5 clocks for ≤133MHz, 0001b=6 clocks for ≤166MHz (default), 1110b=3 clocks for ≤83MHz, 1111b=4 clocks for ≤104MHz (others reserved) — i.e. the same "latency count scales with target frequency" pattern as ISSI, though with only 4 discrete points documented versus ISSI's 6. CR0[3] "Fixed Latency Enable" (default=1, i.e. fixed/always-2×) mirrors ISSI's CR[3] Initial-Access-Latency bit exactly in concept: variable mode uses 1× the configured latency normally and 2× only when RWDS indicates a refresh is in progress during the CA phase; fixed mode always uses 2×. — [Winbond datasheet §9.4/9.4.2/9.4.3 Table 8, pp.22,23-24](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)

### Inferences
- The "latency doubles under refresh collision" mechanism is architecturally identical across ISSI WVQ and Winbond HyperBus (both use a strobe signal — DQSM for ISSI, RWDS for Winbond — driven high during the command/address phase to signal the host that an extra latency period is being inserted), strongly suggesting this is an industry-standard approach to hiding DRAM-style refresh inside a serial/parallel PSRAM protocol, independent of vendor.

### Gaps
- ISSI WVS1M8's per-opcode wait-cycle counts are not user-configurable and are not organized as an explicit "frequency-vs-dummy-cycle" table the way WVQ's and Winbond's are — the datasheet simply states a fixed wait-cycle count per opcode alongside a single max-frequency number, so there is no additional frequency-tiered dummy-cycle data to extract for this family.

## Wrap burst support and the register/command that controls it

### Takeaway
All three families (ISSI WVQ, ISSI WVS, Winbond HyperBus) support a configurable wrap-boundary, but the specific boundary options, the controlling register, and the default differ per family and none of them match the specific "8/16/32/1024-byte" list the user hypothesized.

### Cited Findings
- **ISSI WVQ8M4/WVQ16M4**: Configuration Register bits [1:0] ("Burst Length") select 128, 64, 32 (default), or 16 bytes; bit [2] ("Burst Type") selects plain Wrapped vs. "Hybrid Wrapped" (bursts through the configured wrap length once, then continues incrementally up to the max column address before wrapping within the full column space). A separate "Continuous" burst mode (selected via the READ/WRITE command nibble itself — Ah/2h — rather than the CR) ignores wrap entirely and continues until CS# goes high or the array end is reached. — [66-67WVQ8M4FALL-BLL.pdf Table 6.1, 6.4, pp.19-20](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- **ISSI WVS1M8**: Only two wrap-boundary options exist, toggled by the dedicated **Set Burst Length command (C0h)**: 1024 bytes (default / page size) or 32 bytes. There is no register bit for this in WVS — it's a standalone command, not a configuration-register field. — [66-67WVS1M8ALL-BLL.pdf §5.9, p.20; §4.2 "Page Length," p.10](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- **Winbond W955D8MBYA**: Configuration Register 0 bits [1:0] select 128, 64, 16, or 32 bytes (default); bit [2] "Burst Type" is fixed at 1b ("legacy wrapped burst," default; 0b reserved). — [Winbond datasheet Table 8, §9.4.1, pp.22-23](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)

### Inferences
- None of ISSI-WVQ, ISSI-WVS, or Winbond-HyperBus documents an "8-byte" wrap option, and none uses exactly the "8/16/32/1024" list hypothesized in the task — a host controller must read the specific part's configuration register/command definition rather than assume a universal wrap-length set across PSRAM vendors.

### Gaps
- None.

## PSRAM-specific timing behavior: row/page timing, refresh window, max CS-low burst duration

### Takeaway
All parts documented here use "hidden"/distributed self-refresh signaled via a dedicated strobe pin (DQSM for ISSI, RWDS for Winbond) that goes high during the command/address phase to add extra latency when a refresh coincides with a new access — the host never issues an explicit refresh command. All three families additionally impose a hard maximum on how long CS# may stay low continuously (tCSM/tCEM), forcing the host to periodically deselect the device so the internal refresh machinery can catch up; this limit tightens at higher temperature.

### Cited Findings
- **ISSI WVQ8M4/WVQ16M4** — "Chip Select Maximum Low Time": 4.0µs max (~85°C), tightening to 1.0µs max (~105°C), identical for both read and write timing tables at both 200MHz and 166MHz. DQSM is driven by the memory during command/address cycles as a "Refresh Collision Indicator" — high or low state (SDR) tells the host whether the read/write will need 1× or 2× the configured latency count. — [66-67WVQ8M4FALL-BLL.pdf §7.6.1/7.6.2 (tCSM row), pp.32-33](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- **ISSI WVS1M8** — "Chip Select Maximum Low Time" (tCEM): 4µs max (~85°C), 1µs max (~105°C) — same values as WVQ. — [66-67WVS1M8ALL-BLL.pdf §7.6 Table, p.29](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- **Winbond W955D8MBYA** — "Chip Select Maximum Low Time" (tCSM): 4µs max, documented in the Write Timing table for TCASE<85°C (no explicit 105°C row is given, since this part's rated operating range tops out at 85°C rather than ISSI's optional 105°C automotive grade). RWDS is driven by the memory during the CA phase to indicate whether additional latency (for a refresh that's in progress) will be inserted — "RWDS High indicates additional latency, Low indicates no additional latency," functionally identical to ISSI's DQSM refresh-collision indicator. — [Winbond datasheet §7 (RWDS ball description) p.5, Table 15 (tCSM), p.37](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- **Row/page geometry**: ISSI WVQ8M4 (32Mb) organizes the array as 8K rows × 512-byte columns (13-bit row address, 9-bit column address); WVQ16M4 (64Mb) as 8K rows × 1K-byte columns (13-bit row, 10-bit column). — [66-67WVQ8M4FALL-BLL.pdf §4 note 1, p.8](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf); [66-67WVQ16M4FALL-BLL.pdf §4 note 1, p.8](https://www.issi.com/WW/pdf/66-67WVQ16M4FALL-BLL.pdf)
- Winbond's 32Mb HyperRAM: 4096 rows, each row = 512 words (1K bytes); a "Page" for refresh-latency purposes is defined as a 16-word (32-byte) aligned unit, and additional RWDS-signaled latency may be inserted specifically "when crossing Page boundaries." — [Winbond datasheet Table 3/4 and note 1, p.19](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- **Read-Write Recovery Time (tRWR)**, a distinct minimum-turnaround timing parameter that a host must also respect between back-to-back read/write transactions on the same device (separate from the CS-low-time ceiling): ISSI WVQ8M4/16M4 = 35ns min at 200MHz, 36ns min at 166MHz; Winbond W955D8MBYA = 36ns min at 166MHz — essentially identical across vendors. — [ISSI 66-67WVQ8M4FALL-BLL.pdf §7.6.1, p.32](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf); [Winbond datasheet Table 14/15, pp.34,37](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- Neither ISSI nor Winbond documents a classical DRAM "tRC" (row-cycle-time) parameter by that name — the PSRAM's self-refresh DRAM core is fully hidden behind the DQSM/RWDS collision-indicator + tCSM mechanism; the closest analogous parameters found are tRWR (read-write turnaround) and tCSM (max CS-low duration), both cited above.
- ISSI additionally supports **Partial Array Refresh** (CR bits [11:9] on WVQ; same concept, CR1[2:0] on Winbond) to reduce standby current by refreshing only a fraction (1/2, 1/4, 1/8, top or bottom half) of the array instead of the full array — a power-optimization feature orthogonal to the per-access refresh-collision latency mechanism. — [ISSI 66-67WVQ8M4FALL-BLL.pdf Table 6.1 & §6.2.5, pp.19,23](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf); [Winbond datasheet Table 10 & §9.5.1, p.25](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)

### Inferences
- Because tCSM is essentially identical (4µs/1µs) across ISSI WVQ, ISSI WVS, and Winbond HyperBus, a host memory controller designed to respect a "4µs continuous CS-low, tightening to 1µs above ~85–105°C" rule of thumb would be safe across all families surveyed here — but this must still be confirmed against the exact target part's datasheet since it is not guaranteed to be a universal industry constant.

### Gaps
- No explicit numeric refresh-interval or "rows-per-refresh-window" specification (e.g., "must refresh all N rows within T ms," as would be typical of a raw DRAM datasheet) was found in any of the three datasheets — the refresh scheduling is entirely internal to the chip and opaque to the host; the host only sees the tCSM ceiling and the RWDS/DQSM collision flag.

## Operating voltage (VDD) and maximum SCLK for SPI vs QPI

### Takeaway
ISSI's WVQ and WVS families both offer a 1.8V-only ("ALL") and a 3.0V ("BLL") ordering option, with WVQ reaching 200MHz DDR at either voltage and WVS reaching 104MHz at either voltage (33MHz for the plain single-bit "Read" opcode). Winbond's W955D8MBYA is 1.8V-only (1.7–1.95V) and tops out at 166MHz.

### Cited Findings
- ISSI WVQ8M4FALL/BLL and WVQ16M4FALL/BLL: VCC/VCCQ 1.70–1.95V (1.8V typ, "ALL" suffix) or 2.7–3.6V (3.0V typ, "BLL" suffix); max clock rate 200MHz at **both** 1.8V and 3.0V (per the Performance Summary and the Table 6.5 latency-vs-frequency table, which shows identical max-frequency columns for 1.8V and 3.0V). — [66-67WVQ8M4FALL-BLL.pdf §7.2, p.28 and §6.2.2, p.21](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- ISSI WVS1M8ALL/BLL: VCC 1.65–1.95V (1.8V typ) or 2.7–3.6V (3.0V typ); max clock rate 104MHz — the datasheet does not differentiate max frequency by voltage for this family (single "104MHz(max) for fast read" spec applies across the VDD range). SPI mode's plain "Read" (03h) opcode is capped at 33MHz regardless of voltage; QPI-mode 03h/0Bh reads are capped at 84MHz; EBh (Quad IO Read) reaches the full 104MHz in either SPI or QPI mode. — [66-67WVS1M8ALL-BLL.pdf §Features p.2, §7.2 p.26, Table 4.1 p.10](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- Winbond W955D8MBYA6I: VCC/VCCQ 1.7–1.95V (1.8V typical) only — no 3.0V option is offered for this part number. Maximum clock rate 166MHz, DDR up to 333 MT/s (2 bytes/clock × 166MHz). — [Winbond datasheet §1 Features, §2 Order Information, p.3](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBps_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- (Distributor-sourced, not independently verified via a fetched Winbond PDF): Winbond's PSRAM product page states a 3.0V HyperRAM variant exists as a separate part number "W955N8MBYA" (32Mb, 3.0V, per the Winbond documentation-portal listing) — confirming Winbond does offer 3.0V PSRAM, just under a different part number than W955D8MBYA. — [Winbond Documentation portal listing](https://www.winbond.com/hq/support/documentation/?__locale=en&line=%2Fproduct%2Fcustomized-memory-solution%2Findex.html&family=%2Fproduct%2Fcustomized-memory-solution%2Fpsram%2Findex.html&category=%2F.categories%2Fresources%2Fdatasheet%2F)

### Inferences
- None beyond the cited data.

### Gaps
- The W955N8MBYA (3.0V Winbond HyperRAM) datasheet itself was not fetched/verified in this pass — its exact max frequency and full spec were not independently confirmed, only its existence and voltage/density were read from the documentation-portal search-result listing.

## Application notes: how a host controller must interact with the part (CS timing, minimum CS-high time)

### Takeaway
Beyond the tCSM (max CS-low) ceiling already covered above, all three families specify a minimum CS-high time between back-to-back transactions, and ISSI further documents a dedicated hardware-reset timing sequence and an "in-band" (SIO0-toggle) software reset sequence usable when the part is otherwise unresponsive. No separate "application note" document (as opposed to the main datasheet) was found publicly for QSPI-PSRAM host-interfacing specifically; the timing rules below come from the datasheets' AC-characteristics sections.

### Cited Findings
- **ISSI WVQ8M4/16M4**: "CS# High Between READ/WRITE" (tCSP) = 6ns min at both 200MHz and 166MHz. "CS# Setup to next CLK Rising Edge" (tCSS) = 3ns min; "CS# Hold After CLK Falling Edge" (tCSH) = 2ns min. Hardware RESET# timing: tSHRL (RESET# low after CS# high) = 15ns min, tRLRH (RESET# low pulse width) = 10µs min, tRHSL (RESET# high before CS# low) = 10µs min. — [66-67WVQ8M4FALL-BLL.pdf §7.6.1, p.32; §5.3 Table 5.1, p.16](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- ISSI WVQ In-Band Reset (usable without the dedicated RESET# pin, only when the part is unresponsive to normal commands): CS# low pulse ≥500ns, CS# high pulse ≥500ns, setup/hold times ≥5ns, 4 alternating-SIO0 CS# pulses trigger internal reset, followed by a 100ms device-ready delay. — [66-67WVQ8M4FALL-BLL.pdf §6.4, Fig 6.5, pp.25-26](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- **ISSI WVS1M8**: "CE# High between Subsequent operations" (tCPH) = 1 clock period min. In-Band Reset timing identical structure to WVQ's (tCSL/tCSH ≥500ns, tSU/tHD ≥5ns, 100ms device-ready delay after the 4th pulse) but this feature is only available on the "R" option-suffix ("In-Band Reset supported") variant — the base part does not support it. — [66-67WVS1M8ALL-BLL.pdf §7.6 Table p.29; §5.10 p.21-22, ordering info p.35](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf)
- **Winbond W955D8MBYA**: "Chip Select High Between Transactions" (tCSHI) = 6ns min at 166MHz (same numeric value as ISSI's tCSP). Hardware reset (RESET# pin): tRP (pulse width) ≥200ns, tRH (RESET# high before CS# low) ≥200ns, tRPH (RESET# low to CS# low) ≤400ns typical value shown in the timing table. A hardware reset returns all configuration registers to default and is explicitly stated to likely corrupt/invalidate array data (self-refresh halts during RESET# low). Winbond documents no in-band/software reset sequence for this part — only the RESET# pin. — [Winbond datasheet Table 14, p.34; §11.2.5 Table 12, p.32](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)
- Both ISSI families explicitly warn that continuing a continuous-burst **read** past the last array address returns undefined data, while continuing a continuous-burst **write** past the last address silently wraps back to address 0 and keeps writing — an asymmetry a host controller must guard against explicitly (e.g. by capping burst length in software) since the device provides no error/overflow signaling. — [66-67WVQ8M4FALL-BLL.pdf Fig 5.4 & 5.7 notes, pp.12,15](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf)
- Power-up initialization time before the first access is allowed: ISSI WVQ/WVS both require tPU = 150µs after VCC/VCCQ reaches minimum before any command is issued. Winbond requires tVCS = 150µs (identical value) after VCC reaches minimum and RESET# is high. — [ISSI 66-67WVQ8M4FALL-BLL.pdf §5.4, p.17](https://www.issi.com/WW/pdf/66-67WVQ8M4FALL-BLL.pdf); [Winbond datasheet §11.2.4 Table 11, p.31](https://www.winbond.com/resource-files/W955D8MBYA_32Mb_HyperBus_pSRAM_TFBGA24_datasheet_A01-002_20220916.pdf)

### Inferences
- The 150µs power-up delay and the ~6ns minimum CS-high-between-transactions figure are consistent across ISSI (both families) and Winbond, again suggesting these are converged/near-industry-standard values for this class of DDR serial PSRAM rather than vendor-specific quirks — but, as elsewhere in this dossier, this should be re-verified against the exact target datasheet rather than assumed for parts not covered here.

### Gaps
- No dedicated ISSI or Winbond "application note" (as a separate document from the datasheet) specifically about QSPI/HyperBus PSRAM host-controller interfacing was located; ISSI's site does reference an unrelated packaging-handling app note (AN25D011, for USON/WSON/XSON assembly, not protocol/timing) linked from the WVS1M8 package-outline page. This is noted as a gap rather than fabricated content: [https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf](https://www.issi.com/WW/pdf/66-67WVS1M8ALL-BLL.pdf) §8.1 references it but the app note itself was not fetched.
