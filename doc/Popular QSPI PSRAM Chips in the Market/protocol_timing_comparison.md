# QSPI/SPI PSRAM Protocol & Timing Mechanics: Cross-Manufacturer Comparison

Scope note: this file focuses on the cross-cutting protocol/timing *mechanics* a QSPI PSRAM host
controller must implement correctly, using specific parts as concrete, cited examples. It does not
attempt a full per-manufacturer part catalog (that is covered elsewhere). Two families of parts are
in play in the sources found: (a) classic SPI/QPI PSRAM (1-bit or 4-bit I/O, SDR, opcode-driven —
ISSI QUADRAM/OctalRAM-SPI-mode, AP Memory APSxxxxL), and (b) Octal DDR PSRAM (JEDEC Xccela/xSPI-style,
8-bit I/O, DDR — used as a supporting data point for the "command byte width" and "burst register"
questions because it makes the underlying mechanism explicit in a way plain QSPI datasheets don't
always spell out).

Confidence flags used below: **[Primary]** = fetched directly from the datasheet/source PDF or an
official vendor's source-code repo. **[Secondary/aggregated]** = derived from a search-engine result
snippet or an AI-summarized fetch of a primary document (content plausible and internally consistent,
but exact section/table numbering could not be independently re-verified against raw datasheet text
because several vendor PDF hosts (ISSI issi.com, JLCPCB-hosted mirror, DigiKey-hosted mirror,
alldatasheet.com, Mouser direct) blocked automated fetching (bot-detection / 403 / corrupted-stream
responses) during this research pass. Where a number could not be confirmed at all, it is listed
explicitly as a **Gap**.

---

## Key Question 1: QPI/QSPI mode entry and exit — opcodes, convention vs. divergence, in-flight transaction handling

### Takeaway
There is a real cross-vendor convention — Enter-QPI = 0x35, Exit-QPI = 0xF5 — that shows up
consistently in the one datasheet family fully verified in this pass (AP Memory APS6404L) and is
corroborated by a second-hand snippet attributing the same pair to an ISSI-style datasheet (with
the exit command apparently named "RSTQIO"). The bigger divergence found is not in the opcode value
but in whether a manufacturer implements this SPI/QPI protocol family **at all**: Winbond's PSRAM
line is HyperBus-only and has no 0x35/0xF5-style command set whatsoever, which is a total protocol
mismatch, not a mere opcode conflict. Datasheet guidance on in-flight transactions during the mode
switch is thin in the sources found; the one explicit rule captured is that the enter/exit commands
are themselves mode-gated (0x35 is only recognized in SPI mode, 0xF5 only in QPI mode), which
implicitly forbids issuing them mid-transaction rather than as a standalone, complete command.

### Cited Findings
- AP Memory APS6404L-3SQN: "Enter Quad Mode" opcode **0x35**, accepted only while the device is in
  SPI (1-bit command) mode; "Exit Quad Mode" opcode **0xF5**, accepted only while the device is
  already in QPI (4-bit command) mode; device powers up in SPI mode by default and has no
  persistent mode-register bit for this state — mode is tracked purely by which command sequence
  was last issued — [AP Memory APS6404L-3SQN datasheet (Rev. 2.3, Apr 30 2020), via Mouser-hosted PDF, sections referenced as 8.4/10.3/11.3 in the extraction](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated — content extracted via an AI-summarized fetch of the primary PDF; opcode values and mode-gating behavior are consistent with independently-corroborated industry convention, but exact section numbers are as reported by the extraction tool and were not manually re-verified against raw PDF text]**
- A search-result synthesis (query targeting ISSI IS66WVQ8M4DBLL) states: "the device enables QPI
  protocol by issuing an Enter QPI mode (35h) command, and to reset the QPI mode, the RSTQIO (F5H)
  command is required" — i.e. ISSI's own naming for the exit command appears to be **RSTQIO**
  ("Reset Quad I/O"), which matches the user's premise that some vendors frame the exit command as a
  reset-flavored operation rather than a bare "exit" — [search snippet, exact source PDF not
  independently retrievable in this pass; part referenced: IS66WVQ8M4DBLL-133BLI] **[Secondary/aggregated — low-to-moderate confidence; could not open the underlying ISSI PDF directly to confirm wording/opcode against primary text]**
- Sipeed-distributed "IPUS 64Mbit SQPI" PSRAM datasheet (a further, distinct manufacturer/part not
  ISSI/Winbond/AP Memory) is stated in a search-result synthesis to also define **0xF5** as the
  "Quad Mode Exit command," available only in QPI mode — [IPUS_64Mbit_SQPI_Datasheet, hosted by
  Sipeed](https://dl.sipeed.com/TANG/Nano/Spec/IPUS_64Mbit_SQPI_Datasheet%C2%A0(1704).pdf) — direct
  PDF text extraction failed (compressed-stream/undecodable response) in this pass, so this is a
  search-snippet-level corroboration only. **[Secondary/aggregated]**
- Winbond's commercial PSRAM catalog (W955D8MBYA, W956A8MBYA, and the W957/958/959 family) is
  HyperBus/HyperRAM-protocol PSRAM, not classic SPI/QPI-opcode PSRAM — confirmed by Winbond's own
  product-family page and part datasheets being filed under "HyperBus"/"HyperRAM" branding with no
  SPI/QPI opcode table analogous to 0x35/0xF5 appearing in any search result for these parts —
  [Winbond PSRAM product page](https://www.winbond.com/hq/product/customized-memory-solution/psram/?__locale=en); [Mouser W955D8MBYA6I listing](https://www.mouser.com/ProductDetail/Winbond/W955D8MBYA6I) **[Secondary — inferred from consistent absence of SPI/QPI opcode documentation across every Winbond PSRAM source found, and from every part being marketed/branded as HyperBus/HyperRAM; the negative claim ("Winbond has no true QSPI-opcode PSRAM") is an inference, not a directly quoted datasheet statement]**
- NXP AN13028 ("Advanced HyperRAM/PSRAM Usage on i.MX RT") separately validates ISSI (IS66WVH32M8DALL) and Winbond (W956x8MBYA) parts, but both are listed as **HyperRAM-class** parts in that
  document, alongside AP Memory's APS6404L-3SQR listed as the **QSPI-class** part and AP Memory's
  APS12808L-OBM-BA listed as the **Octal-SPI-class (DDR)** part — i.e. even NXP's own cross-vendor
  validation table keeps ISSI/Winbond in the HyperRAM column and AP Memory in the QSPI/Octal column
  for the specific parts it tested — [NXP AN13028](https://www.nxp.com/docs/en/application-note/AN13028.pdf) **[Secondary/aggregated — extracted via proxy fetch; direct PDF text rendering failed via WebFetch itself]**

### Inferences
- Because the enter/exit opcodes are only valid in the mode they transition *from* (0x35 valid only
  in SPI mode, 0xF5 valid only in QPI mode), a host controller cannot "double-enter" or issue a
  stray mode-switch command while a multi-byte transaction (e.g., a burst read) is mid-flight without
  risking the device either ignoring the byte (wrong mode context) or misinterpreting a data byte as
  a new command on the next CS-low assertion. The safe pattern implied by the datasheets is: mode
  switches must be their own complete, dedicated SPI transaction (CS asserted, full command
  sequence, CS deasserted) issued only between other transactions, never interleaved with a read/
  write burst.
- The fact that three independently-named parts across the search (AP Memory APS6404L, an
  ISSI-family part, and the Sipeed/IPUS part) all converge on 0x35/0xF5 suggests this pairing
  is a de facto industry convention for classic SPI/QPI PSRAM, likely inherited from the same
  convention used in SPI NOR flash (where 0x35 "Enable QPI"/"EQIO" and 0xF5 "Reset QPI"/"RSTQIO"
  are also common opcodes) — the "RSTQIO" name found in the ISSI snippet is itself the standard
  SPI-NOR-flash term for this operation, reinforcing that classic PSRAM vendors borrowed the
  legacy serial-NOR-flash command set almost verbatim rather than inventing a PSRAM-specific one.
- Winbond's decision to ship PSRAM only as HyperBus (not classic QSPI-opcode PSRAM) means the
  single biggest "manufacturer divergence" in this whole area is architectural, not opcode-level: a
  host QSPI-PSRAM controller hardcoded against the 0x35/0xF5/0xEB/0xC0-style command set will not
  merely mis-time a Winbond part, it will fail to communicate with it at all, because HyperBus uses
  a fundamentally different command-address (CA) packet + RWDS-signal protocol rather than a
  1-bit-opcode-then-N-bit-data SPI transaction.

### Gaps
- Could not directly confirm ISSI's exact opcode table (0x35/0xF5 and whether the mnemonic is
  literally "RSTQIO") against raw ISSI datasheet text — every retrieval path attempted (issi.com
  direct PDF, JLCPCB-hosted mirror, DigiKey-hosted mirror, alldatasheet.com, r.jina.ai proxy of the
  issi.com PDF) was blocked by bot-detection, returned HTTP 403, or returned an undecodable
  compressed stream. This should be treated as needing independent confirmation before being relied
  upon as a hard fact.
- No datasheet text was found that explicitly narrates "what happens if you assert the mode-switch
  command while a burst is still open" (e.g., whether the part aborts the burst, ignores the
  command, or corrupts data) — this appears to be left as an implicit "don't do this" rather than an
  explicitly documented failure mode in any source located.
- Did not find a case of a manufacturer using an opcode *other than* 0x35/0xF5 for entry/exit
  (i.e., no evidence of outright numeric divergence was found — the divergence found is
  architectural/absence-of-QPI-at-all, as with Winbond, rather than a different hex value for an
  equivalent function).

---

## Key Question 2: Command byte width — 1-byte vs. 2-byte/16-bit opcodes

### Takeaway
No evidence was found of a classic single-data-rate QSPI (1-bit/4-bit, SDR) PSRAM part using a true
extended 2-byte opcode space. The closest real-world match to "2-byte command" is Octal **DDR**
PSRAM (JEDEC Xccela/xSPI-style, used by AP Memory and at least one other vendor code-named "UNILC"),
where the command byte is transmitted twice — once per DDR clock edge — so a datasheet/driver may
represent it as a 16-bit constant (e.g. 0x0000, 0x8080), but this is DDR duplication of an 8-bit
opcode, not a genuinely larger opcode space with 65536 distinct codes.

### Cited Findings
- In Espressif's ESP-IDF Octal-PSRAM driver, the four core commands are defined as 16-bit constants:
  `OPI_PSRAM_SYNC_READ = 0x0000`, `OPI_PSRAM_SYNC_WRITE = 0x8080`, `OPI_PSRAM_REG_READ = 0x4040`,
  `OPI_PSRAM_REG_WRITE = 0xC0C0` — [espressif/esp-idf, `components/esp_psram/esp32s3/esp_psram_impl_octal.c`, master branch](https://raw.githubusercontent.com/espressif/esp-idf/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c) **[Primary — official vendor source-code repository, fetched directly]**
- The 16-bit representation is because Octal PSRAM operates in DDR (Double Data Rate): the same
  8-bit opcode byte is clocked out on both the rising and falling edge of the same SCLK cycle, so
  the "wire pattern" looks like a 16-bit value even though the logical opcode is 8 bits — [same
  source, code comments/structure] **[Primary]**
- This driver distinguishes PSRAM vendors by reading a **Vendor ID** field out of Mode Register 1
  (MR1): AP Memory's ID is `0xD`, and a second vendor code-named "UNILC" is `0x1A` in the same
  field — both are treated with identical initialization sequences by the driver despite the
  different vendor ID, implying the command/opcode set (including the DDR-duplicated 16-bit
  commands above) is shared between at least these two Octal-PSRAM vendors — [same source] **[Primary]**
- By contrast, every classic SPI/QPI (SDR) PSRAM part found in this research (AP Memory APS6404L
  family) uses conventional single-byte opcodes (0x35, 0xF5, 0x03, 0x0B, 0xEB, 0x02, 0x38, 0xC0) —
  [AP Memory APS6404L-3SQN datasheet, Rev. 2.3](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated, see Q1 sourcing note]**

### Inferences
- A host controller designed only for classic SDR QSPI PSRAM (1-byte opcode) will not be able to
  address Octal DDR PSRAM at all without a distinct command-phase mode (DDR command clocking), so
  "2-byte opcode support" in a controller spec is really shorthand for "DDR command-phase support,"
  not an independent addressing-mode extension bolted onto the same SDR QSPI protocol.
- Because the register-space commands (`REG_READ`/`REG_WRITE` = 0x4040/0xC0C0) sit in the *same*
  16-bit-representation family as the data-space commands, a controller implementing Octal PSRAM
  needs a generalized "send command byte, duplicated per DDR edge, with distinct data-space vs.
  register-space opcodes" mechanism, rather than being able to special-case a single fixed opcode
  list.

### Gaps
- Could not find a classic SPI/QPI (SDR) PSRAM datasheet from any manufacturer that defines a
  genuinely distinct, non-duplicated 2-byte/16-bit opcode (i.e., an "extended command set" in the
  sense the user's question raises for SDR QSPI PSRAM specifically). This may not exist in the
  classic QSPI PSRAM market segment at all — flagged as an open question rather than a confirmed
  negative, since the ISSI and Winbond primary datasheets could not be fully read in this pass.

---

## Key Question 3: Dummy cycle mechanics — fixed vs. configurable, frequency dependence, SPI vs. QPI difference

### Takeaway
For AP Memory's APS6404L (the one part fully verified), dummy cycle counts are fixed per command
opcode by datasheet specification (not software-configurable via a mode register), but the *count*
differs depending on which mode (SPI vs. QPI) the same logical "Fast Read" opcode is issued in — a
concrete, citable example of the exact mechanic the user asked about. Octal DDR PSRAM (AP Memory /
ESP-IDF driver) instead expresses dummy timing as configurable bit-lengths per command class
(data-read, register-read, register-write), each different, again fixed-by-opcode-class rather than
runtime-configurable in that specific driver.

### Cited Findings
- AP Memory APS6404L-3SQN dummy-cycle table (as extracted): **Standard Read (0x03)** — 0 dummy
  cycles, max 33 MHz; **Fast Read (0x0B) in SPI mode** — 8 dummy cycles, max ~133 MHz (109 MHz at
  VDD = 3.3 V ±10%); **Fast Read Quad (0xEB) in SPI mode** — 6 dummy cycles, max ~133 MHz; **Fast
  Read (0x0B) issued while already in QPI mode** — 4 dummy cycles, max 66 MHz; **Fast Quad Read
  (0xEB) in QPI mode** — 6 dummy cycles, max ~133 MHz — [AP Memory APS6404L-3SQN datasheet Rev. 2.3, "Table 8.5" as cited by the extraction](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated — see Q1 sourcing caveat; the SPI-vs-QPI difference for the same nominal opcode (0x0B: 8 dummy in SPI vs. 4 dummy in QPI) is the specific mechanic the user asked about and is internally consistent with how such tables are normally laid out in PSRAM datasheets, but the exact table number/page could not be independently re-verified against raw PDF text]**
- All write opcodes (0x02 serial, 0x38 quad) on the same part are listed with **0 dummy cycles** at
  up to 133 MHz — [same source] **[Secondary/aggregated]**
- On the Octal DDR PSRAM side, ESP-IDF's driver encodes dummy timing as **bit-length** constants
  rather than a "cycle count," reflecting DDR: `OCT_PSRAM_RD_DUMMY_BITLEN = 2*(10-1)` (18 bit-times
  = 9 full DDR clock cycles) for data reads, `OCT_PSRAM_RD_REG_DUMMY_BITLEN = 2*(5-1)` (8 bit-times
  = 4 cycles) for register reads, and `OCT_PSRAM_WR_DUMMY_BITLEN = 2*(5-1)` (8 bit-times = 4 cycles)
  for writes — [espressif/esp-idf `esp_psram_impl_octal.c`](https://raw.githubusercontent.com/espressif/esp-idf/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c) **[Primary]**
- Mode Register 0 (MR0) on the Octal-PSRAM side carries a "read latency" and "latency type" field,
  meaning on that part family the dummy/latency behavior *is* register-configurable (not purely
  fixed-by-opcode) — [same source, `opi_psram_mode_reg_t` structure] **[Primary]**

### Inferences
- The SPI-vs-QPI dummy-cycle asymmetry for the same nominal "Fast Read" opcode (0x0B: 8 cycles in
  SPI-mode issue vs. 4 cycles when the host is already in QPI mode and re-issues 0x0B) means a
  controller's dummy-cycle logic cannot be keyed off opcode value alone — it must also condition on
  which protocol mode (SPI vs. QPI) the transaction is issued under, even for what looks like "the
  same command."
- The presence of a genuine mode-register latency field only on the Octal/DDR side (MR0) but not
  on the classic APS6404L QSPI side (which the datasheet extraction describes as having "no mode
  register... no persistent configuration bits") suggests that configurable-dummy-cycle behavior is
  a feature that entered the PSRAM command set specifically with the higher-speed Octal DDR designs,
  while simpler classic QSPI PSRAM keeps dummy counts as fixed, per-opcode constants baked into the
  datasheet AC table.

### Gaps
- Could not obtain a frequency-vs-dummy-cycle table with more than the two SCLK operating points
  captured above (133 MHz / 109 MHz for VDD variants, and the QPI-mode 66 MHz point) — a denser
  table (e.g., stepped dummy-cycle requirements at multiple discrete frequency bins, as some flash
  and higher-speed PSRAM parts publish) was not found for any manufacturer in this pass.
  This should be treated as an open item — ISSI's datasheet (which the user specifically flagged as
  a manufacturer of interest) could not be opened to check whether it publishes such a table.
  Community/search-snippet material (not independently verified) suggested "read dummy cycles of 5,
  write dummy cycles of 0" as a typical ISSI QSPI PSRAM configuration value, but this could not be
  traced to a specific datasheet page and is not included above as a cited fact.

---

## Key Question 4: Wrap-burst / burst-length toggle mechanism

### Takeaway
On classic QSPI PSRAM (AP Memory APS6404L), the wrap boundary is a two-state, **command-toggled**
setting — a single opcode (0xC0) flips the device between 1024-byte-wrapped and 32-byte-wrapped
burst behavior, with no separate readable/writable register exposed for it; the host controller
must therefore track the current wrap state itself (it is not observable by reading the device
back). On Octal DDR PSRAM, the same concept is instead expressed as genuine register fields —
burst length (BL) and burst type (BT) bits inside Mode Register 8 (MR8), set via an explicit
register-write command rather than a bare toggle opcode. This is a real architectural difference in
*how* a host is expected to issue the "set burst type" operation between the two PSRAM families.

### Cited Findings
- AP Memory APS6404L: opcode **0xC0** is the "Wrap Boundary Toggle Operation," which "switches the
  device's wrapped boundary between 1K Bytes Wrapped Burst or 32 Bytes Wrapped Burst"; default at
  power-up is 1K-byte wrapped; the command is available in both SPI and QPI modes; the datasheet
  extraction explicitly notes "No register bits exposed — toggle is command-based only, no readable
  mode register" — [AP Memory APS6404L-3SQN datasheet Rev. 2.3, "Section 9"](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated, see Q1 caveat]**
- A separate, independent search result (not tied to a specific fetched page) states essentially the
  same mechanism for AP Memory-style QSPI PSRAM in general: "The Wrap Boundary Toggle Operation
  switches the device's wrapped boundary between 1K Bytes Wrapped Burst or 32 Bytes Wrapped Burst.
  The default setting is 1K Bytes Wrapped... The QPI Wrap Boundary Toggle command is 'hC0'" —
  corroborating the 0xC0 opcode and the two-state (32 B / 1024 B) nature of the toggle independently
  of the single datasheet fetch above **[Secondary/aggregated — search-engine synthesis, exact source page not confirmed]**
- On Octal DDR PSRAM (AP Memory / ESP-IDF driver), the equivalent configuration lives in **Mode
  Register 8 (MR8)**, which the driver's `opi_psram_mode_reg_t` structure defines with explicit
  **burst length (bl)** and **burst type (bt)** bit fields, set by issuing the `OPI_PSRAM_REG_WRITE`
  (0xC0C0) command against that register address rather than a standalone toggle opcode —
  [espressif/esp-idf `esp_psram_impl_octal.c`](https://raw.githubusercontent.com/espressif/esp-idf/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c) **[Primary]**

### Inferences
- Because the classic-QSPI 0xC0 command is a stateless *toggle* rather than a *set-to-value*
  register write, a host controller must maintain its own shadow copy of "which wrap mode is the
  device currently in" — issuing 0xC0 twice returns the device to its original state, so a
  controller that loses track of state (e.g., after a warm reset it didn't fully control, or a
  shared-bus scenario with another master) can desynchronize from the actual device state with no
  way to read back and confirm which wrap mode is active.
- The move from a bare toggle command (classic QSPI PSRAM) to a genuine addressable register field
  (Octal DDR PSRAM, MR8 BL/BT bits) mirrors the same trend noted in Key Question 3 for dummy/latency
  configuration — the higher-speed Octal DDR generation of PSRAM parts generally replaced
  "stateless toggle commands" with "addressable, read-and-write-able mode registers," which is a
  more controller-friendly (self-verifying) design.
- A controller that supports only a fixed, non-wrapping linear-burst assumption (i.e., assumes
  1024-byte wrap = "effectively linear" for typical cache-line-sized accesses) would work correctly
  against APS6404L's power-on default without ever needing to issue 0xC0, but would silently produce
  wrong addressing behavior on any part or any prior software state that had already toggled the
  boundary down to 32 bytes — reinforcing that a robust controller must issue the toggle
  deterministically at init time rather than relying on a device's poweryup default.

### Gaps
- Could not confirm whether ISSI's classic QSPI PSRAM (QUADRAM/OctalRAM-SPI-mode) uses the same
  0xC0 toggle opcode and 32 B/1024 B two-state scheme, or a different opcode/scheme (e.g., a
  register-based approach, or additional wrap sizes such as 8 B/16 B as the user's prompt
  anticipated as a possibility) — ISSI primary datasheet text was not retrievable in this pass.
- Could not confirm whether any manufacturer supports a "continuous linear burst" (no-wrap) mode as
  a third selectable state alongside the two wrap sizes, or whether the two-state toggle (32 B /
  1024 B) is the universal limit of what's offered in this product class.
- Did not find a wrap-boundary mechanism example smaller than 32 bytes (i.e., no confirmed 8-byte or
  16-byte wrap option was found in any source in this pass, despite the user's prompt suggesting
  these might exist on some parts) — flagged as unconfirmed rather than ruled out.

---

## Key Question 5: PSRAM refresh mechanics — distributed/hidden refresh, max CS-low duration, temperature dependence

### Takeaway
All PSRAM datasheets/technical docs found agree on the underlying mechanism: because the storage
array is DRAM-based, the device runs its own internal refresh oscillator and interleaves refresh
cycles into idle gaps whenever CS# is deasserted (i.e., refresh is "distributed" and normally
invisible to the host) — but this requires the host to guarantee CS# is deasserted at least once
within a bounded maximum interval (commonly named tCEM / tCSM), or a refresh cycle will be missed
and array data can be lost/corrupted. This maximum interval is temperature-dependent and shrinks at
high temperature because DRAM leakage (and thus required refresh rate) increases with temperature;
the exact numbers and the exact ratio of the derating differ by manufacturer/part family.

### Cited Findings
- AP Memory APS6404L-3SQN: maximum CS-low time (tCEM) is **≤ 8 µs** for the standard temperature
  range (commercial, roughly −40 °C to +85 °C) and **≤ 4 µs** for the extended temperature range
  (−40 °C to +105 °C) — i.e., the allowed max CS-low window is **halved** for the extended-temperature
  grade of this specific part — [AP Memory APS6404L-3SQN datasheet Rev. 2.3, "Section 14.6 / Table 9" as cited by the extraction](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated, see Q1 caveat]**; the datasheet extraction also
  quotes explicit host-facing guidance: "All Reads & Writes must be completed by raising CE# high
  immediately afterwards… Not doing so will block internal refresh operations and cause memory
  failure."
- Realtek's Ameba (RTL872x-family) PSRAM controller documentation gives its own generic
  temperature-derated refresh-interval table (used across the PSRAM parts it validates, described as
  a general "distributed refresh strategy: refresh commands are evenly distributed into the gaps
  between normal accesses, transparently to software"): **T ≤ 85 °C → 4 µs** max interval (labeled
  in its code as `Psram_Tcem_T25`, i.e. the "normal"/room-temperature setting), and **85 °C <
  T ≤ 125 °C → 1 µs** max interval (labeled `Psram_Tcem_T85`, the "high-temperature" setting) — a
  4× reduction (not merely a halving) between its two grades — [Realtek Ameba IoT PSRAM peripheral documentation](https://aiot.realmcu.com/en/latest/rtos/peripherals/psram/index.html) **[Secondary/aggregated — extracted via proxy fetch of the live docs page; this is a controller-side reference document describing generic PSRAM handling across parts it validates, not a single chip's own datasheet, so it should be read as "typical/representative" rather than tied to one specific part number]**
- NXP AN13028 ("Advanced HyperRAM/PSRAM Usage on i.MX RT") documents the underlying formula
  governing this limit for HyperRAM-class parts: the maximum distributed-refresh interval (tCSM) is
  derived as **(array refresh interval) ÷ (number of rows in the array)**, and explicitly recommends
  that a host controller **halve** the resulting calculated value as a safety margin, "to ensure
  that a maximum length host access start[ing] immediately before a distributed refresh does not
  miss a distributed refresh interval" — [NXP AN13028](https://www.nxp.com/docs/en/application-note/AN13028.pdf) **[Secondary/aggregated — the underlying formula/design-margin guidance is reported here with reasonable confidence since it was consistently stated across the extraction; however, the specific example numeric values this extraction attributed to a Cypress HyperRAM part (an "8192 rows" / "64 ms interval" example allegedly yielding "4105 µs"/"1025 µs" tCSM figures) are dimensionally inconsistent with the stated formula (64 ms ÷ 8192 rows ≈ 7.8 µs, not thousands of µs) and are therefore NOT reported here as reliable — treat as an extraction artifact, see Gaps]**
- The same NXP AN13028 extraction lists validated parts by protocol family: **QSPI PSRAM** —
  AP Memory APS6404L-3SQR (up to 133 MHz, tested on i.MX RT1050); **Octal SPI PSRAM (DDR)** — AP
  Memory APS12808L-OBM-BA (up to 200 MHz, tested on i.MX RT1170, and noted to require even-address
  alignment for that part); ISSI (IS66WVH32M8DALL) and Winbond (W956x8MBYA) parts are listed as
  validated but in the **HyperRAM** category rather than the QSPI category — [same source] **[Secondary/aggregated]**

### Inferences
- The fact that Realtek's generic guidance (4 µs → 1 µs, a 4× drop) and AP Memory's specific
  APS6404L datasheet (8 µs → 4 µs, a 2× drop) differ in both absolute value and derating ratio
  strongly indicates that "max CS-low time and its temperature derating factor" is **not** a
  standardized, cross-vendor-identical number — a host controller cannot hardcode a single
  "safe" CS-low ceiling across parts/vendors and must instead treat this as a per-part
  datasheet parameter (ideally software-configurable / read from a device-specific table), exactly
  as the user's prompt anticipated.
- Because both the AP Memory datasheet's explicit warning ("failing to raise CE# high... will block
  internal refresh operations and cause memory failure") and NXP's formula-based derivation describe
  the same underlying constraint (a hard ceiling on continuous CS-low duration tied to the array's
  physical refresh requirement), it is reasonable to treat "periodically toggle CS# high for at
  least the device's minimum CS-high time, no less often than tCEM apart" as the universal
  *mechanism*, even though the *specific numbers* are not universal.
- NXP's explicit recommendation to apply a 2× safety margin (halve the calculated/specified value)
  on top of whatever the datasheet already states suggests that datasheet-published tCEM/tCSM
  numbers should be treated by a conservative host-controller implementation as an upper bound
  requiring its own margin, not as a value safe to use at face value in the worst case (a
  maximum-length burst starting just before a refresh boundary).

### Gaps
- Could not obtain ISSI's or Winbond's own tCEM/tCSM numeric limits and temperature-derating
  behavior directly from their datasheets (both parts are only referenced as "validated" in
  secondary NXP/Realtek documentation without exact numbers attributable to them specifically).
- Could not verify the specific Cypress HyperRAM numeric example (the "4105 µs / 1025 µs" figures)
  extracted from NXP AN13028 — the numbers as extracted are internally inconsistent with the stated
  refresh-interval-÷-rows formula and should not be relied upon; the correct figures likely differ
  by roughly three orders of magnitude from what the extraction reported (i.e., single-digit µs
  range, consistent with the AP Memory and Realtek figures above), but this is inference, not a
  confirmed replacement value.
- Did not find an explicit definition of the *minimum* CS-high (deselect) time required between
  transactions for the refresh cycle to actually execute (i.e., tCPH / tCEH-style parameter) for any
  of the three named manufacturers in this pass — flagged as an open item since the "CS toggle to
  permit a refresh cycle" mechanism logically requires both a maximum low-time AND a minimum
  high-time to be useful, but only the max-low-time side was found with citable numbers.

---

## Key Question 6: Write behavior — combinational vs. latency/dummy-cycle requirements; do wrap rules apply equally to writes

### Takeaway
On the one part fully verified (AP Memory APS6404L), writes are specified with **zero dummy
cycles** at any supported frequency (i.e., write data follows the address phase immediately, with
no turnaround/latency gap) — unlike reads, which require several dummy cycles at speed. However,
"zero dummy cycles" is not the same as "no timing requirement": the datasheet's write path is still
rate-limited to the part's normal max SCLK frequency, and the same wrap-boundary configuration
(1 KB / 32 B, set via the 0xC0 toggle) is stated to apply to writes just as it does to reads — a
wrapped write will wrap its address back to the start of the same aligned block rather than
progressing linearly past the boundary. Octal DDR PSRAM writes, by contrast, do have a small nonzero
dummy requirement in the ESP-IDF driver's constants.

### Cited Findings
- AP Memory APS6404L-3SQN: both write opcodes — **0x02** ("serial"/single-bit-data write) and
  **0x38** (quad-I/O write, used in both SPI-mode-with-quad-data and full QPI-mode contexts) — are
  listed with **0 dummy cycles**, at a maximum frequency of 133 MHz (same ceiling as the fastest
  read commands) — [AP Memory APS6404L-3SQN datasheet Rev. 2.3, "Table 8.5"](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf) **[Secondary/aggregated, see Q1 caveat]**
- The same datasheet extraction states the wrap-boundary configuration ("1K Bytes Wrapped Burst or
  32 Bytes Wrapped Burst," Section 9) is described as applying to "Reads & Writes" generally, and
  separately quotes the explicit host-facing warning that "All Reads & Writes must be completed by
  raising CE# high immediately afterwards" — grouping reads and writes under the identical CS-low
  and refresh-blocking constraint described in Key Question 5, with no separate/relaxed rule stated
  for writes — [same source, Sections 8.6 and 9] **[Secondary/aggregated]**
- On the Octal DDR PSRAM side, ESP-IDF's driver specifies a **nonzero** write dummy requirement:
  `OCT_PSRAM_WR_DUMMY_BITLEN = 2*(5-1)` = 8 DDR bit-times (4 full SCLK cycles) — the same bit-length
  as its register-read dummy constant, and shorter than its data-read dummy constant (`2*(10-1)` =
  18 bit-times / 9 cycles) — [espressif/esp-idf `esp_psram_impl_octal.c`](https://raw.githubusercontent.com/espressif/esp-idf/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c) **[Primary]**

### Inferences
- The zero-dummy-cycle write behavior on classic QSPI PSRAM (AP Memory) is consistent with writes
  being a purely combinational/write-immediate operation from the bus-protocol perspective (no
  internal sense-amp precharge delay is exposed to the host the way it is on a read), but this is a
  bus-timing statement only — it says nothing about how quickly the write becomes durably stored in
  the DRAM cell array, which is an internal-refresh-cycle concern already covered by the CS-low/
  refresh rules in Key Question 5 that explicitly apply to writes too.
- Because the write opcodes are the *same* physical opcodes (0x02, 0x38) regardless of which wrap
  boundary is currently configured, and the datasheet frames the wrap-boundary toggle as applying to
  "Reads & Writes" without a separate write-specific override, a host controller's address-wrapping
  logic for burst/cache-line-fill writes can and should reuse the identical wrap-boundary/
  address-increment state machine it uses for reads — there is no evidence of an asymmetric or
  write-specific exception to burst-wrap addressing on this part family.
- The nonzero write-dummy requirement on Octal DDR PSRAM (vs. zero on classic QSPI PSRAM) is another
  data point (alongside Key Questions 3 and 4) showing that the higher-speed DDR generation of
  PSRAM generally trades "combinational, no-latency" classic-PSRAM behavior for small, fixed
  latencies on every operation type, likely to accommodate DDR clock-domain-crossing / command
  decode pipeline delay that a lower-speed SDR design didn't need.

### Gaps
- Could not confirm write-dummy-cycle behavior for ISSI or Winbond parts directly (both primary
  datasheets were unreachable in this pass).
- Did not find an explicit statement addressing whether a **partial** write within a wrapped block
  (i.e., a write burst that starts mid-block and would cross the wrap boundary) wraps its *address*
  back to the block start the same way a read does, versus some parts potentially disallowing or
  behaving differently for unaligned/partial-block wrapped writes — the datasheet language found
  states the wrap boundary "applies to Reads & Writes" generally but does not walk through an
  explicit unaligned-write example.

---

## Key Question 7: Known cross-manufacturer opcode/behavior incompatibilities (concrete list)

### Takeaway
The clearest, best-evidenced incompatibility found in this pass is architectural rather than a
single conflicting hex value: Winbond's PSRAM catalog is HyperBus-protocol-only and shares no
common opcode table at all with the classic SPI/QPI PSRAM command set used by AP Memory (and,
per secondary sources, ISSI). Within the classic SPI/QPI PSRAM family itself, the specific opcodes
found (0x35, 0xF5, 0x03, 0x0B, 0xEB, 0x02, 0x38, 0xC0) appear consistent across every source located
for that family, so no confirmed *numeric* opcode collision (i.e., the same hex value meaning two
different things across vendors) was found in this research pass — this should be read as "not yet
found," not as "proven not to exist," given how many primary datasheets could not be opened.

### Cited Findings
- Winbond PSRAM parts (W955D8MBYA, W956A8MBYA, W957/958/959 family) are HyperBus/HyperRAM-protocol
  devices; every source found for these parts frames them under HyperBus/HyperRAM branding and none
  surfaced a 0x35/0xF5/0xEB/0xC0-style opcode table for them — [Winbond PSRAM product page](https://www.winbond.com/hq/product/customized-memory-solution/psram/?__locale=en) **[Secondary — see Q1 caveat: this is an inference from absence of evidence across multiple searches, not a directly quoted "we do not support SPI/QPI mode" statement from Winbond]**
- Within the classic SPI/QPI PSRAM sources reviewed (AP Memory APS6404L family; and, per
  lower-confidence secondary snippets, an ISSI QUADRAM part and the Sipeed/IPUS SQPI part), the
  Enter-QPI (0x35) / Exit-QPI (0xF5) pairing and the general read/write opcode pattern (0x03/0x0B/
  0xEB read family, 0x02/0x38 write family) were consistent across every source that specified them
  — no conflicting alternate meaning for any of these hex values was found in this pass — [AP Memory APS6404L-3SQN datasheet](https://www.mouser.com/datasheet/2/1127/APM_PSRAM_QSPI_APS6404L_3SQN_v2_3_PKG-1954905.pdf); search-snippet corroboration for ISSI and Sipeed/IPUS parts (see Q1) **[Secondary/aggregated]**
- The Octal DDR PSRAM generation (AP Memory + the "UNILC"-vendor-ID part recognized by ESP-IDF)
  uses an entirely different opcode namespace (DDR-duplicated 16-bit values 0x0000/0x8080/0x4040/
  0xC0C0, per Key Question 2) that has no numeric relationship to the classic QSPI opcode set at
  all — meaning a controller cannot assume "Octal PSRAM opcodes are a superset/extension of QSPI
  PSRAM opcodes"; they are a disjoint command set requiring separate driver logic — [espressif/esp-idf `esp_psram_impl_octal.c`](https://raw.githubusercontent.com/espressif/esp-idf/master/components/esp_psram/esp32s3/esp_psram_impl_octal.c) **[Primary]**
- ESP-IDF's own Octal-PSRAM driver explicitly restricts itself to Espressif-badged PSRAM modules via
  a `PSRAM_IS_VALID()`-style check, and community sources note that third-party (non-Espressif)
  Octal PSRAM of otherwise-compatible physical footprint (e.g., a bare ISSI or AP Memory octal part
  substituted for an Espressif-badged one) is reported to fail initialization / not be officially
  supported by that driver — [search-result synthesis referencing `esp-idf` GitHub issues #8863, #11456, #15653 discussing third-party/non-Espressif PSRAM compatibility problems](https://github.com/espressif/esp-idf/issues/8863) **[Secondary/aggregated — this is real-world evidence that even within nominally-compatible vendor-ID-aware drivers, hardcoded assumptions about a specific vendor's part cause outright incompatibility with other vendors' otherwise similar parts, which directly supports the user's underlying concern about hardcoding to one vendor's table, but the exact root cause (opcode difference vs. timing difference vs. ID-check-only difference) was not confirmed in the sources found]**

### Inferences
- The single largest practical "incompatibility trap" for a host controller author is protocol-
  family confusion, not opcode-table diffing within one family: a controller that assumes "PSRAM"
  uniformly means "classic SPI/QPI opcode PSRAM" will completely fail against Winbond's HyperBus
  parts and will need a wholly separate protocol implementation (CA-packet/RWDS-based), not a
  patched opcode table.
- Because the Octal-DDR command set is numerically disjoint from the classic QSPI command set
  (different opcode encoding entirely, DDR vs. SDR clocking), any controller intended to be
  "vendor-agnostic across QSPI PSRAM" should very explicitly scope that claim to SDR QSPI/QPI parts
  only, and treat Octal DDR PSRAM support as a separate mode requiring its own command table, dummy-
  cycle constants, and mode-register (MR0/MR1/MR2/MR8) parsing logic — attempting to reuse one
  state machine for both would be a design error given the evidence found.
- The ESP-IDF vendor-ID check (AP=0xD, UNILC=0x1A) followed by "identical initialization sequences"
  for both is itself a data point that at least at the Octal-DDR level, some vendors *do*
  successfully share a common opcode/register table (unlike the Winbond-vs-classic-QSPI case above)
  — so opcode compatibility across vendors is not all-or-nothing; it appears to cluster by protocol
  generation/family (HyperBus vs. classic SDR QSPI/QPI vs. Octal DDR), with strong compatibility
  within a cluster and none across clusters.

### Gaps
- Did not find a confirmed case of the *same* hex opcode meaning two *different* operations across
  two classic-QSPI-PSRAM vendors (e.g., manufacturer A's 0xC0 meaning something other than "wrap
  boundary toggle" on manufacturer B's part) — this remains an open question requiring direct
  ISSI/Winbond(-equivalent) primary-source confirmation that could not be completed in this pass due
  to repeated datasheet-hosting access failures (bot-detection pages, HTTP 403 responses, and
  undecodable/compressed PDF-stream responses across issi.com, JLCPCB's hosted mirror, DigiKey's
  hosted mirror, alldatasheet.com, and the Sipeed-hosted IPUS datasheet).
- Could not identify additional named QSPI PSRAM manufacturers beyond AP Memory, ISSI (partially),
  Winbond (partially, and shown to be architecturally different), and the Sipeed/IPUS-branded part
  (manufacturer identity itself unconfirmed) — the user's prompt invited "others if you find good
  sources," but this pass did not surface a fifth distinct classic-QSPI-PSRAM manufacturer with
  citable opcode-level detail (e.g., GigaDevice, Adesto/Renesas, Lyontek, Zentel/Etron were not
  found with usable datasheet text in the time available).

---

## Source-access notes (for the report writer)

Several primary manufacturer datasheets could not be opened despite multiple retrieval strategies
(direct WebFetch, JLCPCB/DigiKey/alldatasheet mirrors, and an `r.jina.ai` reader-proxy fallback):
ISSI's own issi.com-hosted PDFs consistently returned an Akamai-style "Pardon Our Interruption"
bot-detection page; several distributor-hosted mirrors returned HTTP 403; and a couple of PDFs
(Sipeed/IPUS, one DigiKey mirror) returned raw compressed PDF-stream bytes that could not be
decoded by the fetch tooling used. Where a fetch *did* succeed (the AP Memory APS6404L-3SQN
datasheet, via the `r.jina.ai` proxy) the extraction was performed by an automated summarization
step rather than by directly reading raw PDF text, so exact section/table numbers attributed to
that datasheet above should be treated as "as reported by the tool" rather than manually verified —
the underlying hex opcodes and numeric timing values are reported with reasonable confidence because
they are internally consistent and, where checkable, corroborated by independent secondary sources,
but a report writer citing exact table numbers from this file should flag them as needing a manual
spot-check against the original PDF if that level of precision is load-bearing. The ESP-IDF
source-code citations (Key Questions 2, 3, 4, 6, 7) were fetched directly from the official
espressif/esp-idf GitHub repository and are treated as primary/high-confidence.

