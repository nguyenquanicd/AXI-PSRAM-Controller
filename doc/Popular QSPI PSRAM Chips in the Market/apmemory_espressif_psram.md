# AP Memory PSRAM Families and Espressif-Branded PSRAM

Scope covered: AP Memory APS6404L (64Mbit QSPI), APS1604M-SQ (16Mbit QSPI), APS6408L-3OCx "OctaRAM" (64Mbit proprietary-protocol Octal DDR, 3.3V), APS6408L-OBMx "Xccela" (64Mbit JEDEC/Xccela-compatible Octal DDR, 1.8V), Espressif-branded ESP-PSRAM64/ESP-PSRAM64H, and Espressif's ESP32-S3 PSRAM software/driver stack (ESP-IDF). All part numbers, opcodes and timing values below are taken verbatim from vendor datasheets or from Espressif's own public source code — nothing is inferred numerically beyond what is explicitly flagged as an inference.

## Densities, bus organization, and package options per part family

### Takeaway
All five AP Memory/Espressif parts examined are byte-addressable pseudo-SRAM with self-managed (hidden) refresh; densities range from 16Mbit to 64Mbit in the parts with full datasheets obtained, with AP Memory's Octal family scaling further to 512Mbit per its product-page listing. Packages are SOP-8/USON-8 for QSPI parts and 24-ball miniBGA for Octal parts.

### Cited Findings
- **APS6404L-SQH** (AP Memory, QSPI datasheet Rev. 4.1, Jan 05 2024): 64Mb, organized 8M x 8 bits, addressable range A[22:0], page size 1024 bytes, packages SOP-8L(150) code "SN" and USON-8L 3x2mm code "ZR" — [AP Memory datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773)
- **APS1604M-SQR** (AP Memory, QSPI datasheet Rev. 3.0, Sep 4 2024): 16Mb, organized 2M x 8 bits, addressable range A[20:0], default page size 512 bytes, packages SOP-8L(150) "SN" and USON-8L 3x2mm "ZR" — [AP Memory datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620)
- **APS6408L-3OCx "OctaRAM"** (AP Memory, Octal PSRAM datasheet Rev. 1.9, Oct 18 2021): 64Mb, organized 8M x 8 bits, 1024-byte page size, Column address AY0–AY9, Row address AX0–AX12, package "miniBGA 24L", 6x8x1.2mm, ball pitch 1.0mm, code "BA" — [AP Memory datasheet](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549)
- **APS6408L-OBMx "Xccela"** (AP Memory, Octal DDR OPI Xccela datasheet Rev. 3.7, Aug 12 2022): 64Mb, organized 8M x 8 bits, 1024-byte page, package "mini-BGA 24B" 6x8x1.2mm ball pitch 1.0mm code "BA" — [Octopart-hosted copy of AP Memory datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf)
- AP Memory's own OPI/HPI product page lists a much broader Octal SPI family at 64Mb, 128Mb (APS12808L-OBM/-3OBM, APS128XXO-OB9), 256Mb (APS25608N-OBR/-OCH, APS256XXN-OB9), and 512Mb (APS51208N-OBR/-OCH, APS512XXN-OB9), each in 1.8V or 3.3V, x8 or x8/x16 variants — [AP Memory OPI/HPI product page](https://www.apmemory.com/en/product/iotram/OPIHPI)
- **ESP-PSRAM64 / ESP-PSRAM64H** (Espressif datasheet v1.0, 2018.06): 64Mbit, organized 8Mx8 bits, package "SOP8-150 mil", 1KB pages — [Espressif ESP-PSRAM64/64H datasheet, Adafruit-hosted mirror](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf) (official path: https://www.espressif.com/sites/default/files/documentation/esp-psram64_esp-psram64h_datasheet_en.pdf)

### Inferences
- AP Memory sells two structurally distinct 64Mbit Octal PSRAM protocol families under the same "APS6408L" prefix — a proprietary "OctaRAM" command set (-OCx/-3OCx suffix, 3.3V-capable) and a JEDEC/Xccela-compatible command set (-OBMx suffix, 1.8V). These are not opcode-compatible with each other (see Command Opcode section) even though marketed under the same base part number.

### Gaps
- Did not obtain a datasheet specifically for "ESP-PSRAM32" (the 32Mbit/4MB part historically used on original ESP32-WROVER modules); only the 64Mbit ESP-PSRAM64/64H datasheet was retrieved. Its exact organization/package could not be verified from a primary source in this pass.

## Interface modes: SPI, QSPI/QPI, Octal SPI (OPI), and DDR Octal

### Takeaway
The QSPI-class parts (APS6404L, APS1604M-SQ, ESP-PSRAM64/64H) support single-bit SPI and 4-bit QPI, both SDR only. The Octal-class parts (APS6408L-3OCx, APS6408L-OBMx) are DDR-only, 8-bit-wide, with two data bytes transferred per clock cycle.

### Cited Findings
- APS6404L: "operates in SPI (serial peripheral interface) or QPI (quad peripheral interface) mode with frequencies up to 144 MHz" — [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), Rev 4.1
- APS1604M-SQR: "Interface: SPI/QPI with SDR mode" — [AP Memory APS1604M-SQ datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), Rev 3.0
- ESP-PSRAM64/64H: "Both of the PSRAM devices can be accessed via the Serial Peripheral Interface (SPI). Additionally, a Quad Peripheral Interface (QPI) is supported if the application needs faster data rates." — [Espressif ESP-PSRAM64/64H datasheet v1.0](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf)
- APS6408L-3OCx: "Interface: Octal SPI with DDR OctaRAM mode, two bytes transfers per one clock cycle" — [AP Memory APS6408L-3OCx datasheet Rev 1.9](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549)
- APS6408L-OBMx: "Interface: Octal SPI with DDR mode, two bytes transfers per one clock cycle" — [AP Memory APS6408L-OBMx datasheet Rev 3.7](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf)
- ESP-IDF confirms the same SDR/DDR split on the controller side: "Quad PSRAM only supports STR mode, while Octal PSRAM only supports DDR mode" — [ESP-IDF Programming Guide, SPI Flash and External SPI RAM Configuration (ESP32-S3, stable)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-guides/flash_psram_config.html)

### Inferences
None beyond the direct statements above.

### Gaps
None significant for this question.

## Full command opcode tables

### Takeaway
The two QSPI parts (APS6404L, APS1604M-SQ) and the Espressif ESP-PSRAM64/64H share essentially the same core opcode set (0x03/0x0B/0xEB read family, 0x02/0x38 write family, 0x35/0xF5 QPI enter/exit, 0x66/0x99 reset-enable/reset, 0x9F Read ID), which is strong evidence of a common underlying command-set lineage. The two Octal parts use two mutually incompatible opcode sets even though both are AP Memory "APS6408L" silicon.

### Cited Findings
**APS6404L-SQH (SPI Mode / QPI Mode Command/Address Latching Truth Table, section 9.5):**
- Read = `0x03` (Serial cmd/addr, 0 wait cycles, max 33MHz)
- Fast Read = `0x0B` (Serial cmd/addr, 8 wait cycles, max 144MHz SPI / 66MHz QPI)
- Fast Read Quad = `0xEB` (Serial cmd + Quad addr/IO, 6 wait cycles, max 144MHz)
- Write = `0x02` (0 wait cycles, max 144MHz)
- Quad Write = `0x38` (0 wait cycles, max 144MHz, "same as 0x02" in QPI mode)
- Enter Quad Mode = `0x35` (SPI-mode only)
- Exit Quad Mode = `0xF5` (QPI-mode only)
- Reset Enable = `0x66`
- Reset = `0x99`
- HalfSleep Entry = `0xC0` (SPI only)
- Read ID = `0x9F` (0 wait cycles, max 33MHz, SPI-mode only; outputs EID = vendor ID/KGD/density/mfg ID)
— [AP Memory APS6404L datasheet Rev 4.1](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), §9.5, §12–14

**APS1604M-SQR (adds Mode-Register and forced-wrap commands vs. APS6404L, §11):**
- Read = `0x03`, Fast Read = `0x0B` (8 wait), Fast Read Quad = `0xEB` (6 wait), Write = `0x02`, Quad Write = `0x38` — same as APS6404L
- Wrapped Read = `0x8B` (8 wait cycles, forced wrap using MR0[6:5] or toggle-fixed 32B)
- Wrapped Write = `0x82` (0 wait cycles, forced wrap)
- Mode Register Read = `0xB5` (8 wait cycles)
- Mode Register Write = `0xB1` (0 wait cycles)
- Enter Quad Mode = `0x35`, Exit Quad Mode = `0xF5`
- Reset Enable = `0x66`, Reset = `0x99`
- Burst Length Toggle = `0xC0`
- Read ID = `0x9F`
— [AP Memory APS1604M-SQ datasheet Rev 3.0](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), §11

**ESP-PSRAM64 / ESP-PSRAM64H (Espressif, §5.4 Truth Table)** — opcode set is byte-identical to APS6404L/APS1604M-SQ's non-Mode-Register subset: Read=`0x03`, Fast Read=`0x0B`, Fast Read Quad=`0xEB`, Write=`0x02`, Quad Write=`0x38`, Enter Quad Mode=`0x35`, Exit Quad Mode=`0xF5`, Reset Enable=`0x66`, Reset=`0x99`, "Set/Wrap Boundary Toggle"=`0xC0`, Read ID=`0x9F` — [Espressif ESP-PSRAM64/64H datasheet v1.0](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf), §4–8

**APS6408L-3OCx "OctaRAM" (proprietary protocol, §7.4 Command Truth Table):**
- Sync Read = `0x80`
- Sync Write = `0x00`
- Sync Read/Write (Linear Burst, forces 2K-byte wrap, ignores MR burst setting) = `0xA0`
- ID Register Read / Mode Register Read = `0x20` (address selects which register)
- Global Reset = `0xC0` or `0xE0` (4-clocked-CE#-low command frame; power-up use only) — the exact split of this opcode group between "Mode Register Write" and "Global Reset" could not be disambiguated with full confidence from the extracted table (see Gaps)
— [AP Memory APS6408L-3OCx datasheet Rev 1.9](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549), §7.4

**APS6408L-OBMx "Xccela" (JEDEC/Xccela-compatible protocol, §8.4 Command Truth Table, cross-validated against ESP-IDF source below):**
- Sync Read = `0x00`
- Sync Write = `0x80`
- Sync Read/Write, Linear Burst (forces 1K wrap, "ignore burst setting defined by MR8[2:0]") = `0x20` (read) / `0xA0` (write) — datasheet explicitly states "Linear Burst commands, 20h and A0h, ignore burst setting defined by MR8[2:0]"
- Mode Register Read = `0x40`, Mode Register Write = `0xC0` (register writes are always latency-1; registers 0/4/8 are R/W, registers 1/2/3 are read-only)
- Global Reset uses a 4-clocked-CE#-low frame ("command frame is made of 4 clocked CE# lows... can be used ONLY as Power-up initialization")
— [AP Memory APS6408L-OBMx datasheet Rev 3.7](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf), §7.4/§8.4

**ESP-IDF `esp_psram_impl_ap_oct.c` (Espressif source, master branch)** independently defines: Sync Read=`0x0000`, Sync Write=`0x8080`, Burst(Linear) Read=`0x2020`, Burst(Linear) Write=`0xA0A0`, Register Read=`0x4040`, Register Write=`0xC0C0` (16-bit values because Octal DDR repeats the 8-bit opcode across the double-data-rate command phase, i.e. `0x8080` = opcode `0x80` sent DDR) — [`esp_psram_impl_ap_oct.c`, espressif/esp-idf @master](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c). This exactly matches the APS6408L-OBMx datasheet's opcodes above once the DDR-doubling is accounted for, confirming the ESP32 family's octal PSRAM driver targets the **Xccela-protocol** APS6408L-OBM/-OBMx chip, not the proprietary OctaRAM (-OCx/-3OCx) chip.

**ESP-IDF `esp_quad_psram_defs_ap.h`** (Espressif source) defines the quad-PSRAM opcode set: `PSRAM_QUAD_READ 0x03`, `PSRAM_QUAD_FAST_READ 0x0B`, `PSRAM_QUAD_FAST_READ_QUAD 0xEB`, `PSRAM_QUAD_WRITE 0x02`, `PSRAM_QUAD_WRITE_QUAD 0x38`, `PSRAM_QUAD_ENTER_QMODE 0x35`, `PSRAM_QUAD_EXIT_QMODE 0xF5`, `PSRAM_QUAD_RESET_EN 0x66`, `PSRAM_QUAD_RESET 0x99`, `PSRAM_QUAD_SET_BURST_LEN 0xC0`, `PSRAM_QUAD_DEVICE_ID 0x9F`, with fast-read dummy cycles of 4 and fast-read-quad dummy cycles of 6, and an explicit comment referencing "AP Memory PSRAM" (per the file's content, though no specific AP Memory part number is named in-file) — [`esp_quad_psram_defs_ap.h`, espressif/esp-idf @master](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_quad_psram_defs_ap.h). This opcode set is identical to APS6404L/APS1604M-SQ/ESP-PSRAM64's non-Mode-Register command subset.

### Inferences
- The file is literally named `esp_psram_impl_ap_oct.c` / `esp_quad_psram_defs_ap.h` — the "ap" infix, combined with opcode-for-opcode matches to AP Memory datasheets and an explicit AP-Memory vendor-ID check (see next sections), is Espressif's own source code effectively naming AP Memory as the supported/reference vendor for both its quad and octal PSRAM drivers.

### Gaps
- The APS6408L-3OCx (OctaRAM) truth table's exact split between "Mode Register Write" and "Global Reset" opcodes (rows showing `0xC0 or 0xE0` / `0x40 or 0x60` / `0xFF` variants) could not be disambiguated with full confidence — the PDF-to-text conversion merged table columns in a way that left this specific mapping ambiguous. This is flagged rather than guessed.
- Exact Global Reset opcode byte for the Xccela (OBMx) chip was not confidently recovered from the extracted table text (only the 4-clocked-CE#-low framing is confirmed); ESP-IDF's `esp_psram_impl_ap_oct.c` does not appear to issue a Global Reset command at all (per the WebFetch summary: "No explicit reset commands are defined; initialization uses mode register writes"), so this may simply not be used by the ESP32-S3 driver.

## Dummy/latency cycle counts, Mode-Register configurability, and frequency dependence

### Takeaway
For the QSPI-class AP Memory/Espressif parts, dummy ("wait") cycle counts are **fixed per opcode**, not software-configurable via a Mode Register — there is no dummy-cycle field in APS6404L (which has no Mode Register at all) and none in ESP-PSRAM64/64H. For the Octal-class parts, dummy/latency cycles genuinely **are** Mode-Register-configurable and the register's Latency Code field is explicitly keyed to target SCLK frequency in the datasheet's own tables.

### Cited Findings
**Fixed (non-MR) dummy cycles, QSPI parts:**
- APS6404L: Read (`0x03`) = 0 wait cycles; Fast Read (`0x0B`) = 8 wait cycles; Fast Read Quad (`0xEB`) = 6 wait cycles; Write/Quad Write = 0 wait cycles — [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), §9.5 truth table
- APS1604M-SQR: same base wait-cycle counts (0/8/6/0/0), plus Wrapped Read (`0x8B`)=8, Mode Register Read (`0xB5`)=8, Mode Register Write (`0xB1`)=0 — [AP Memory APS1604M-SQ datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), §11
- ESP-PSRAM64/64H: identical wait-cycle pattern to APS6404L (0/8/6/0/0) per its truth table — [Espressif datasheet](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf), §5.4
- ESP-IDF's quad driver hard-codes this: dummy cycles for fast-read = 4 and for fast-read-quad = 6 per `esp_quad_psram_defs_ap.h` (note: this 4-vs-8 discrepancy between the datasheet's "8 wait cycles" for `0x0B` and ESP-IDF's constant of 4 was not reconciled in this pass — see Gaps) — [`esp_quad_psram_defs_ap.h`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_quad_psram_defs_ap.h)

**Mode-Register-configurable latency, Octal parts:**
- APS6408L-3OCx (OctaRAM), single 16-bit Mode Register at address `0x0`: Latency Code field MR[7:4] selects LC per Table 5, with explicit VL (Variable Latency, MR[3]=0) vs FL (Fixed Latency, MR[3]=1) codes and a **Max Input CLK Freq column** tying each LC value to a maximum clock speed, e.g. LC=3 (VL, no-refresh)→66MHz standard/extended; LC=4→104MHz; LC=5(default)→133MHz; LC=6→133MHz; LC=7→133MHz; LC=8(default row shown, i.e. MR[7:4]=1000)→133MHz. Under refresh-in-progress, output latency doubles to LC×2. Register writes are always 0 latency cycles, register reads use the same latency as data reads — [AP Memory APS6408L-3OCx datasheet](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549), Table 5/6, §7.7
- APS6408L-OBMx (Xccela), 8-bit Mode Registers MR0/MR1/MR2/MR3/MR4/MR6/MR8: Read Latency Code = MR0[4:2] (Table 5), with Latency Type (Variable/Fixed) = MR0[5] (Table 4). Table 5's Max Input CLK Freq column: MR0[4:2]=001 → LC=3 → 66MHz; =011 → LC=4 → 109MHz; =101(default) → LC=5 → 133MHz; =110 → LC=6 → 166MHz; =111 → LC=7 → 200MHz. Separately, **Write Latency** is its own field, MR4[7:5] (Table 16): WL=3→66MHz, WL=4→104MHz, WL=5(default)→133MHz, WL=6→166MHz, WL=7→200MHz ("Default powered up behavior is WL 5"). Register reads use the same MR0[4:2] latency as burst reads; register writes are always Latency 1 — [AP Memory APS6408L-OBMx datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf), Tables 3–6, 16, §8.7
- ESP-IDF's octal driver mirrors this structure directly in code: "MR0 - Read Latency: `mode_reg.mr0.read_latency = mode_reg_config->mr0.read_latency`" and "MR4 - Write Latency: `mode_reg.mr4.wr_latency = mode_reg_config->mr4.wr_latency`", i.e. the driver explicitly sets MR0 read-latency and MR4 write-latency fields at init time — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c)
- ESP-IDF's dummy-bit-length macros scale with target frequency: default `AP_OCT_PSRAM_RD_DUMMY_BITLEN (2*(10-1))` / write `(2*(5-1))`; at 200MHz, read=`(2*(14-1))` / write=`(2*(7-1))`; at 250MHz, read=`(2*(18-1))` / write=`(2*(9-1))` — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c). Earlier general web search corroborates the encoding convention: "for N dummy bits, `reg_dummy_bits` should be configured to N − 1" and "MR0.read_latency field value determines cycles (2 × value + 6)" (source: Espressif Rust `esp-hal` docs, `PsramTimingParams`) — [`esp-hal` PsramTimingParams docs](https://docs.espressif.com/projects/rust/esp-hal/1.2.0-rc.0/esp32s31/esp_hal/psram/struct.PsramTimingParams.html)
- ESP-IDF's own `esp_psram_impl_octal.c` (older, ESP32-S3-specific implementation) hard-codes `mode_reg.mr0.read_latency = 2;` and `mode_reg.mr8.bl = 3; mode_reg.mr8.bt = 0;` at init — i.e., that specific code path does not vary read latency by frequency, contrasting with the newer shared `device/esp_psram_impl_ap_oct.c` driver's frequency-tiered dummy-bitlen macros — [`esp_psram_impl_octal.c`, espressif/esp-idf @master](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c)

### Inferences
- Software (ESP-IDF) sets PSRAM dummy/latency cycles by writing the MR0 (read latency) and MR4 (write latency) fields via the Mode Register Write command at PSRAM init time, choosing the LC/WL code from the datasheet's frequency table that is safely ≥ the configured `CONFIG_SPIRAM_SPEED` target; this directly follows the mechanism AP Memory's own APS6408L-OBMx datasheet documents (Tables 5 and 16).
- The discrepancy between two different ESP-IDF source files (`esp32s3/esp_psram_impl_octal.c` hard-coding LC=2, vs. `device/esp_psram_impl_ap_oct.c` doing frequency-tiered dummy-bitlen calculation) suggests these are two different generations/refactors of the octal PSRAM driver (older chip-specific ESP32-S3 file vs. newer shared multi-chip "device" framework used by later chips such as ESP32-P4); this was not independently confirmed against ESP-IDF version history in this pass.

### Gaps
- Could not reconcile APS6404L/APS1604M-SQ/ESP-PSRAM64's datasheet-stated "8 wait cycles" for Fast Read (`0x0B`) against ESP-IDF's `PSRAM_QUAD_FAST_READ_DUMMY` value reported as `4` by the automated extraction — this may be a units mismatch (e.g., dummy *bytes* vs *cycles*, or DDR/SDR half-cycle counting) rather than a real conflict, but it was not verified against the raw ESP-IDF source line in this pass.
- Did not obtain the numeric values of the "UNILC" fallback vendor's latency table for cross-comparison (see next section) — only AP Memory's own tables were retrieved.

## Wrap burst support and boundary-crossing toggle mechanism

### Takeaway
Wrap-burst configurability progresses from "none" (APS6404L: fixed 1KB page wrap only) to "toggle between two fixed options" (ESP-PSRAM64/64H: Linear vs. fixed 32-byte wrap) to "fully register-configurable wrap length plus a toggle command" (APS1604M-SQ: MR0[6:5], 16/32/64/512B) to "register-configurable Wrap or Hybrid-Wrap across four lengths, plus a dedicated Linear Burst opcode that overrides the register" (both APS6408L Octal variants, MR8/MR bits).

### Cited Findings
- APS6404L: no Mode Register exists; burst is a fixed 1KB page wrap ("Page size is 1K (CA[9:0]). The device operates in a bursting address sequence back to starting address of same page in a wrap manner"); feature list separately advertises "1K Byte Wrapped Burst as long as tCEM is met" — [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), §9.2
- ESP-PSRAM64/64H: "Wrap Boundary Toggle Operation allows the device to switch between the linear burst mode (CA[9:0]) and the 32-byte wrap mode (CA[4:0]). The default setting is Linear Burst." Toggle command = `0xC0`; Linear Burst crosses page boundaries but is capped at 84MHz, vs. up to 144MHz (ESP-PSRAM64) / 133MHz (ESP-PSRAM64H) when wrap-32 is selected and no boundary crossing occurs — [Espressif datasheet](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf), §4, Table 4-1
- APS1604M-SQR: dedicated Mode Register MR0, with **Wrap Codes MR0[6:5]** (Table 4): `00`→16B wrap, `01`→32B wrap, `10`→64B wrap, `11` (default)→512B (full page) wrap/Linear. A separate **Burst Length Toggle** command (`0xC0`) "switches the device's wrapped burst boundary between the Mode Register setting MR0[6:5] and a fixed value of 32 bytes." Only when Toggle=MR-setting AND MR0[6:5]=11 (full page) can non-wrap commands (`0x03/0x0B/0xEB/0x02/0x38`) cross page boundaries (Linear, RBX), capped at 84MHz; the dedicated Wrapped Read/Write commands (`0x8B`/`0x82`) always force wrap per MR0[6:5] regardless of the toggle, up to 144MHz — [AP Memory APS1604M-SQ datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), Table 3/4, §14
- APS6408L-3OCx (OctaRAM): Burst Type MR[2] and Burst Length MR[1:0] (Table 8): non-Hybrid (MR[2]=0) wraps continually within 128/64/32(default)/16 bytes per MR[1:0]; Hybrid (MR[2]=1) bursts through the initial wrap length once then continues incrementally to the 1K column-address boundary before wrapping the full 1K space. A separate **Linear Burst Command** (INST[5:0]=`0b100000`) overrides MR[2:0] entirely and forces 2K-byte wrap, continuing linearly within the page and wrapping only at the page end — [AP Memory APS6408L-3OCx datasheet](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549), Table 8, §7.2
- APS6408L-OBMx (Xccela): Burst Type MR8[2] / Burst Length MR8[1:0] (Table 20): non-Hybrid wraps within 16/32(default)/64/1K bytes; Hybrid (MR8[2]=1) bursts the initial length once then continues to the 1K boundary. Dedicated **Linear Burst commands** (`0x20` read / `0xA0` write, INST[5:0]=`0b100000`) override MR8[2:0] and force 1K-byte wrap. A further **Row Boundary Crossing (RBX)** capability exists: MR3[7] (read-only) reports whether the die supports RBX; when supported, MR8[3]=1 enables Linear Burst reads to cross into the next row (RA+1) rather than staying within the 1K column space — "RBX Write is NOT supported" (read-only feature) — [AP Memory APS6408L-OBMx datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf), Tables 13/20/21, §8.2
- ESP-IDF's octal driver reads this back out explicitly for diagnostics: `"BurstType : 0x%02x (%s Wrap)", reg_val->mr8.bt` and `"BurstLen : 0x%02x (%d Byte)", reg_val->mr8.bl`, with burst-length decode `mr8.bl==0x00?16 : mr8.bl==0x01?32 : mr8.bl==0x10?64 : 1024` — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c)

### Inferences
- For XIP/execute-in-place use on ESP32-S3, the Linear Burst command (which overrides the wrap-length Mode Register field and lets a cache-line-sized read continue linearly rather than wrapping at a short boundary) is the mechanism that matters most for contiguous cache-line fills; the register-configurable Wrap/Hybrid-Wrap lengths are more relevant to a fixed-size burst-fetch controller that intentionally wants wrap-around behavior (e.g., a critical-word-first cache refill).

### Gaps
- Did not confirm which exact wrap/Linear Burst configuration ESP-IDF's PSRAM driver selects by default for cache-line fills on ESP32-S3 (only the readback/decode logic was found, not the specific configuration value chosen at init for MR8 in the shared `device/esp_psram_impl_ap_oct.c`, versus the older `esp32s3/esp_psram_impl_octal.c` which hard-codes `mr8.bl=3` [=1K/1024B] and `mr8.bt=0` [non-Hybrid], per the Dummy-cycle section above).

## Refresh behavior, max CS-low burst duration, and cycle-time equivalents

### Takeaway
All parts examined implement fully hidden, host-transparent self-refresh (no DRAM-style refresh commands are ever issued by the controller); the datasheets instead specify a maximum continuous CS-low ("burst") duration (tCEM) that the host must respect so the device can service its internal refresh, and a minimum read/write cycle time (tRC) between back-to-back short operations on the Octal parts.

### Cited Findings
- APS6404L: "It incorporates a seamless self-managed refresh mechanism. Hence it does not require the support of DRAM refresh from system host." tCEM (CE# low pulse width) = 8µs (standard temp) / 3µs (extended temp, per Rev 3.7 changelog note "Revised tCEM value from 4us to 3us @105C") — [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), §2, Table 10
- APS1604M-SQR: identical self-managed refresh statement; same tCEM = 8µs standard / 3µs extended — [AP Memory APS1604M-SQ datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), §2, Table 12
- ESP-PSRAM64/64H: "the device will need... a user-issued reset operation... to complete its self-initialization"; command-termination section states CE# must be pulled high after every read/write "in order to terminate ongoing read and write operations... Not doing so will block internal refresh operations and cause memory failure" — [Espressif datasheet](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf), §5.5; tCEM listed as 8µs max in Table 10-5 (labelled ambiguously in the extracted table, see Gaps)
- APS6408L-3OCx (OctaRAM): "Auto Temperature Compensated Self-Refresh (ATCSR) by built-in temperature sensor"; tCEM = 8µs standard / 3µs extended temp (Table 15, with changelog noting the same 4µs→3µs revision); tRC (both "Write Cycle" and "Read Cycle") = 60ns minimum — [AP Memory APS6408L-3OCx datasheet](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549), Table 15, §Change Log
- APS6408L-OBMx (Xccela): same ATCSR self-refresh feature, plus **user-configurable refresh rate** and **Partial Array Self-Refresh (PASR)** — MR4[3] selects Fast (default) vs. Slow refresh frequency (Slow allowed only when MR3[5] self-refresh-flag, a read-only temperature-driven indicator, permits it); MR4[2:0] (Table 18) restricts refresh to Full/½/¼/⅛/None of the array to cut standby current. tCEM = 8µs standard / 3µs extended (Table 30); tRC (Write Cycle / Read Cycle) = 60ns minimum — [AP Memory APS6408L-OBMx datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf), Tables 15/17/18/30
- Read-latency doubling under refresh: in both Octal variants, "In case of internal refresh insertion, variable latency output data is/may be delayed by (LC×2) latency cycles... The 1st DQS/DM rising edge after read pre-amble will indicate the beginning of valid data" — i.e., the device flags an in-progress refresh to the host purely via the DQS preamble timing, not via a status command — [APS6408L-3OCx](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549) §7.5; [APS6408L-OBMx](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf) §8.5

### Inferences
- The consistent 8µs/3µs tCEM figure and the "4µs→3µs @105°C" changelog note appearing verbatim across all four AP Memory datasheets checked strongly suggests these parts share a common underlying memory-array/refresh IP block despite differing I/O protocols (QSPI SDR vs. Octal DDR, OctaRAM vs. Xccela command sets).

### Gaps
- The exact tCEM value for ESP-PSRAM64/64H could not be cleanly read from the extracted AC-characteristics table (columns were visually merged by PDF-to-text conversion); the table confirms an 8µs-class entry exists but its precise row/column assignment is uncertain.

## Operating voltage and maximum SCLK/DDR frequency per mode

### Takeaway
QSPI parts run at 1.62–1.98V core supply with SDR clock rates up to 144MHz (limited to 84MHz when a burst crosses a page boundary). The 3.3V OctaRAM part tops out at 133MHz DDR (266MB/s); the 1.8V Xccela part reaches 200MHz DDR (400MB/s) at its fastest speed grade.

### Cited Findings
- APS6404L: VDD = 1.62–1.98V; clock rate up to 144MHz for all operations except SPI Read `0x03` (33MHz) and QPI Fast Read `0x0B` (66MHz) — [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773), Table 9, §9.5
- APS1604M-SQR: VDD = 1.62–1.98V; 144MHz for Wrapped Burst operation, 84MHz for Linear 512-byte burst crossing a page boundary (RBX) — [AP Memory APS1604M-SQ datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r6586620), feature list, Table 1
- ESP-PSRAM64: VDD = 1.62–1.98V (1.8V nominal), up to 144MHz; ESP-PSRAM64H: VDD = 2.7–3.6V (3.3V nominal), up to 133MHz; both limited to 84MHz max when bursts cross page boundaries — [Espressif datasheet](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf), §1, Table 10-4
- APS6408L-3OCx (OctaRAM): VDD = VDDQ = 2.7–3.6V; clock rate up to 133MHz, "266MB/s read/write throughput" (two bytes/clock DDR × 133MHz) — [AP Memory APS6408L-3OCx datasheet](https://www.apmemory.com/tw/downloadFiles/0324112221xb586549), feature list, Table 1
- APS6408L-OBMx (Xccela): VDD = VDDQ = 1.62–1.98V; clock rate up to 200MHz, "400MB/s read/write throughput"; three speed grades in Table 30: "-7" = 133MHz, "-6" = 166MHz, "-5" = 200MHz — [AP Memory APS6408L-OBMx datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf), feature list, Table 30
- ESP32-S3 controller-side ceiling (lower than the chips' own rated maxima, presumably for system margin): Quad PSRAM STR mode supports 20/40/80/120MHz; Octal PSRAM DDR mode supports 40/80MHz, plus 120MHz DDR gated behind `CONFIG_IDF_EXPERIMENTAL_FEATURES` with an explicit temperature-drift warning ("If your chip powers on at a certain temperature, then after the temperature increases or decreases over 20 [degrees], the accesses to/from PSRAM/flash will crash randomly" at 120MHz DDR, mitigated by "dynamic phase-point adjustment via temperature sensing") — [ESP-IDF flash_psram_config (ESP32-S3, stable)](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-guides/flash_psram_config.html)

### Inferences
None beyond the direct statements above.

### Gaps
None significant.

## How Espressif's ESP32-S3 documentation/source describes the PSRAM controller's command set and dummy-cycle configuration

### Takeaway
Espressif's public-facing ESP-IDF *programming guide* and TRM prose describe PSRAM support only at a policy level (which SDR/DDR modes and MHz options are selectable via Kconfig); the actual command opcodes, Mode-Register field layouts, and per-frequency latency/dummy-cycle selection logic live in ESP-IDF's C source (`components/esp_psram`), not in prose documentation. That source code is a faithful, opcode-level implementation of AP Memory's own command sets described above.

### Cited Findings
- ESP-IDF programming guide (prose level only): "Octal PSRAM only supports DTR mode" (DTR ≡ DDR); mode/speed options exposed as `CONFIG_SPIRAM_MODE` (Quad vs. Octal) and `CONFIG_SPIRAM_SPEED` (the MHz values listed in the Voltage/Frequency section above) — [ESP-IDF flash_psram_config](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-guides/flash_psram_config.html)
- Attempting to extract the ESP32-S3 Technical Reference Manual's PSRAM-controller register chapter via automated PDF text extraction did not surface a distinct "PSRAM controller register" section comparable in detail to the flash SPI0/SPI1 chapters — text extraction of the 9.9MB TRM PDF (mirrored at Adafruit's CDN) succeeded structurally but did not return legible PSRAM-specific opcode/dummy-cycle register prose in this pass (see Gaps). The actual command-set/latency logic was instead recovered from ESP-IDF's C source, listed below.
- `components/esp_psram/esp32s3/esp_psram_impl_octal.c` (chip-specific ESP32-S3 implementation) defines: `OPI_PSRAM_SYNC_READ 0x0000`, `OPI_PSRAM_SYNC_WRITE 0x8080`, `OPI_PSRAM_REG_READ 0x4040`, `OPI_PSRAM_REG_WRITE 0xC0C0`; bit-length constants `OCT_PSRAM_RD_CMD_BITLEN`/`OCT_PSRAM_WR_CMD_BITLEN` = 16, `OCT_PSRAM_ADDR_BITLEN` = 32, `OCT_PSRAM_RD_DUMMY_BITLEN (2*(10-1))`, `OCT_PSRAM_RD_REG_DUMMY_BITLEN (2*(5-1))`, `OCT_PSRAM_WR_DUMMY_BITLEN (2*(5-1))`; and hard-coded init values `mode_reg.mr0.read_latency = 2; mode_reg.mr8.bl = 3; mode_reg.mr8.bt = 0;` — [`esp_psram_impl_octal.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c)
- `components/esp_psram/device/esp_psram_impl_ap_oct.c` (newer, shared multi-chip "device" framework) implements the same opcode set plus explicit frequency-tiered dummy-bit-length macros (10/14/18 read dummy "cycles", 5/7/9 write, for default/200MHz/250MHz tiers respectively) and writes `mode_reg.mr0.read_latency` / `mode_reg.mr4.wr_latency` / `mode_reg.mr8.bl` / `mode_reg.mr8.bt` from a config struct rather than hard-coding them — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c)
- Same file performs explicit vendor detection: `AP_OCT_PSRAM_VENDOR_ID_AP 0xD` checked against `mode_reg.mr1.vendor_id`, with a named fallback constant that the automated extraction rendered as `AP_OCT_PSRAM_VENDOR_ID_UNILC` for a second/alternate vendor's compatible die — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c)

### Inferences
- `0xD` (binary `1101`) is exactly the "APM" vendor code documented in AP Memory's own APS6408L-OBMx datasheet Table 9 ("Vendor ID mapping MR1[4:0]: 01101: APM") and the APS6408L-3OCx datasheet's ID Register Table ("1101 - AP Memory"). This is a direct, code-level cross-confirmation that Espressif's ESP32 PSRAM driver was written against, and validates against, AP Memory silicon specifically.
- Espressif's TRM appears to treat PSRAM initialization as a ROM-bootloader/driver responsibility documented in source rather than in the register-level TRM prose that covers SPI0/SPI1 flash — i.e., for a real embedded PSRAM controller implementation, the "spec" a firmware engineer would actually follow is the ESP-IDF driver source, not the TRM chapter text.

### Gaps
- Could not confirm the exact full name behind the "UNILC" vendor-ID constant (likely OCR/extraction artifact of a real vendor name); flagging rather than guessing.
- Did not locate a TRM-prose (as opposed to source-code) description of the PSRAM controller's own SPI1-side register fields (e.g., an equivalent to `SPI_MEM_CACHE_SRAM_USR_RCMD`-style register names) in this pass; automated PDF extraction of the 9.9MB ESP32-S3 TRM did not surface this content, and a targeted re-fetch was not attempted due to time budget. This should be treated as an open item for further research directly against `https://www.espressif.com/sites/default/files/documentation/esp32-s3_technical_reference_manual_en.pdf` (or its documentation.espressif.com successor), specifically the SPI0/SPI1 controller chapter.

## Espressif-branded PSRAM (ESP-PSRAM32/64/64H) — actual silicon vendor identification

### Takeaway
Espressif's own ESP-PSRAM64/ESP-PSRAM64H datasheet never names a manufacturer, but its command opcodes, Known-Good-Die encoding, and pin layout are byte-for-byte identical to AP Memory's APS6404L/APS1604M-SQ QSPI PSRAM family, and Espressif's own ESP-IDF driver source for both quad and octal PSRAM is written and named specifically against AP Memory's command sets and vendor-ID codes. Taken together this is strong (though not 100%-explicit-statement) evidence that AP Memory is the silicon vendor behind Espressif-branded PSRAM, consistent with the task's premise — but no single source states "manufactured by AP Memory" in plain text for the Espressif-branded parts.

### Cited Findings
- ESP-PSRAM64/64H datasheet opcode table is opcode-for-opcode identical to AP Memory APS6404L's: `0x03/0x0B/0xEB` read family, `0x02/0x38` write family, `0x35/0xF5` QPI enter/exit, `0x66/0x99` reset-enable/reset, `0x9F` Read ID, `0xC0` burst-toggle — [Espressif datasheet](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf) vs. [AP Memory APS6404L datasheet](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773)
- ESP-PSRAM64/64H's Known-Good-Die table is verbatim identical to AP Memory's: `0b0101_0101` = Fail, `0b0101_1101` = Pass, "default is FAIL... only mark PASS after all tests passed" — appears near-verbatim in both [Espressif datasheet §6.4](https://cdn-shop.adafruit.com/product-files/4677/4677_esp-psram64_esp-psram64h_datasheet_en.pdf) and [AP Memory APS6404L datasheet §12](https://www.apmemory.com/tw/downloadFiles/0324112120r9601773)
- Espressif's own ESP-IDF quad-PSRAM opcode header is named `esp_quad_psram_defs_ap.h` (the "_ap" suffix) and its octal-PSRAM implementation is named `esp_psram_impl_ap_oct.c`/`esp_psram_impl_ap_hex.c`, sitting alongside `esp_psram_impl_ap_quad.c` in the shared `components/esp_psram/device/` directory — [GitHub directory listing, espressif/esp-idf @master](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/include/) (directory contents: `esp_psram_impl_ap_hex.c`, `esp_psram_impl_ap_oct.c`, `esp_psram_impl_ap_quad.c`, `esp_quad_psram_defs_ap.h`)
- Espressif's octal PSRAM driver explicitly checks the PSRAM's Mode Register vendor-ID field against `AP_OCT_PSRAM_VENDOR_ID_AP = 0xD`, matching AP Memory's own datasheet-documented vendor code (Table 9 of the APS6408L-OBMx datasheet: "01101: APM") — [`esp_psram_impl_ap_oct.c`](https://github.com/espressif/esp-idf/blob/master/components/esp_psram/device/esp_psram_impl_ap_oct.c); [AP Memory APS6408L-OBMx datasheet](https://datasheet.octopart.com/APS6408L-OBM-BA-AP-Memory-datasheet-182363276.pdf)
- A general web search for community/forum-level confirmation ("ESP-PSRAM32 actual manufacturer AP Memory") did not return a directly on-point esp32.com forum thread in this pass; only generic ESP-IDF external-RAM documentation pages surfaced, none of which name a manufacturer for ESP-PSRAM32 — [ESP-IDF external-RAM guide, ESP32 stable](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-guides/external-ram.html)

### Inferences
- The combination of (a) identical opcode tables, (b) a verbatim-identical Known-Good-Die bit encoding scheme (an unusual, vendor-specific implementation detail unlikely to be independently reinvented), and (c) Espressif's own driver source code being explicitly named and keyed to AP Memory's vendor-ID codes, together constitute strong circumstantial evidence that AP Memory (or an AP-Memory-licensed/compatible design) is the silicon behind Espressif-branded PSRAM (ESP-PSRAM64/64H, and by extension likely the octal PSRAM options on ESP32-S3-WROOM-1 modules, i.e. AP Memory APS6408L-OBM-BA). This is an inference from strong circumstantial technical evidence, not a directly quoted manufacturer statement, and should be presented to readers with that caveat.

### Gaps
- No single primary source explicitly states in plain text "ESP-PSRAM64/64H is manufactured by AP Memory" or "ESP32-S3-WROOM-1's octal PSRAM option is AP Memory APS6408L-OBM-BA" — this mapping is inferred from opcode/behavior/source-code correlation, not a direct vendor citation, and should be flagged as such in the final report.
- Did not obtain a datasheet or teardown source for ESP-PSRAM32 (32Mbit/4MB, used on earlier ESP32-WROVER modules) to check whether the same AP Memory correlation holds for that older/smaller part.
- Did not independently verify (e.g., via a teardown photo or die-marking report) that a physical ESP32-S3-WROOM-1-N16R8 module's PSRAM package is silk-screened or die-marked as AP Memory; this dossier's vendor conclusion rests entirely on protocol/opcode/source-code correlation, not physical inspection evidence.
