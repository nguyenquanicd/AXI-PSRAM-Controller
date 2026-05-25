# AXI QSPI PSRAM Controller

## Overview

This document describes the **AXI QSPI PSRAM Controller**, a hardware IP block that connects an AXI4 bus master to an external PSRAM device through a QSPI interface. The IP accepts AXI read and write transactions, translates them into PSRAM command/address/dummy/data phases, and exposes an APB CSR interface for software configuration.

The controller reuses the AXI controller architecture from `AXI_CONTROLLER`, but the FIFO boundary is changed to asynchronous FIFOs so AXI bus traffic can be decoupled from the QSPI/IP clock domain.

## Features

| Feature | Description |
|---------|-------------|
| AXI Protocol | AXI4 full interface for memory read/write transactions |
| APB Interface | APB CSR interface for controller configuration |
| QSPI Interface | Command, address, dummy, and data phases driven to PSRAM I/O pads |
| Burst Support | Uses AXI address generation for FIXED, INCR, and WRAP bursts |
| Clock Domains | AXI bus domain, APB CSR domain, and QSPI/IP domain |
| FIFO Boundary | AXI controller FIFOs are replaced with asynchronous FIFOs for bus-to-IP crossing |
| Software Control | Programmable read/write commands, data/address width, dummy cycles, independent commands, and enable control |
| XIP Mode | CSR field exists for Execute-In-Place enable |

## Top-Level Architecture

The QSPI PSRAM controller is built from these major blocks:

```text
                    +-----------------------------------------------+
                    |              QSPI PSRAM Controller             |
                    |                                               |
  AXI4 bus -------->|  AXI Controller                               |
                    |    - AW/AR address FSM                        |
                    |    - burst address generation                  |
                    |    - read/write arbitration                    |
                    |    - async FIFO crossing to IP domain          |
                    |                                               |
  APB bus --------->|  CSR                                          |
                    |    - command configuration                     |
                    |    - width/dummy configuration                 |
                    |    - request/acknowledge control bits          |
                    |                                               |
                    |  QSPI FSM                                     |
                    |    - command phase                             |
                    |    - address phase                             |
                    |    - dummy phase                               |
                    |    - read/write data phase                     |
                    |                                               |
                    |  Clock Generator / IOPAD                      |
                    +-------------------------+---------------------+
                                              |
                                              v
                                      PSRAM QSPI interface
```

The Draw.io overview shows the controller containing:

| Block | Function |
|-------|----------|
| AXI Controller | Accepts AXI read/write requests, generates burst beat addresses, and buffers requests/responses |
| CSR | Stores software-programmed control, command, width, dummy, and status fields |
| FSM | Executes QSPI transactions based on AXI requests and CSR configuration |
| Clock Generator | Generates or controls the QSPI serial clock |
| IOPAD | Drives and samples the QSPI pins |
| BUS | Internal connection between AXI, CSR, and QSPI FSM logic |

## Clock Domains

The Draw.io overview identifies these clocks:

| Clock | Domain |
|-------|--------|
| `ACLK` | AXI controller bus domain |
| `PCLK` | APB CSR bus domain |
| `QSPI_CLK` | QSPI transaction and I/O domain |

The AXI controller from `AXI_CONTROLLER` originally uses synchronous FIFOs. In this IP, those FIFOs should be replaced with asynchronous FIFOs at the bus/IP boundary. This allows AXI channel handshaking and QSPI command execution to run in separate clock domains while preserving the same logical buffering model.

## AXI Controller Function (refer https://github.com/nguyenquanicd/AXI4-SRAM-CONTROLLER)

The AXI Controller sheet describes the AXI-side logic reused by this IP. It contains:

| Block | Function |
|-------|----------|
| AXFSM | Handles AXI AW/AR handshakes and expands each burst into per-beat addresses |
| ARBITER | Selects between pending read and write requests before sending them to the IP domain |
| AWFIFO | Buffers write address, ID, and last-beat information |
| WFIFO | Buffers write data |
| BFIFO | Buffers write responses |
| ARFIFO | Buffers read address, ID, and last-beat information |
| RFIFO | Buffers read response data, ID, response code, and last flag |

### AXFSM Operation

Each AXFSM has two states:

| State | Description |
|-------|-------------|
| `S_IDLE` | Waits for an AXI address handshake when the downstream FIFO has space |
| `S_ADDR` | Generates one address per burst beat and pushes it into the address FIFO |

On an accepted AXI address transaction, the FSM captures:

| Signal | Purpose |
|--------|---------|
| `AXADDR` | Start address for the transaction |
| `AXLEN` | Number of beats minus one |
| `AXBURST` | Burst type: FIXED, INCR, or WRAP |
| `AXID` | AXI transaction ID |

The FSM initializes the address counter with `AXLEN + 1`. For each beat, it pushes `{last, id, addr}` into the corresponding address FIFO. The address update depends on `AXBURST`:

| Burst Type | Address Behavior |
|------------|------------------|
| FIXED | Address remains constant |
| INCR | Address increments by the transfer size |
| WRAP | Address increments and wraps inside the burst boundary |

### Async FIFO Replacement

The logical FIFO roles stay the same as the AXI controller reference design, but the implementation should be asynchronous where data crosses from the AXI bus domain into the QSPI/IP domain.

| FIFO | Direction | Clock-Crossing Role |
|------|-----------|---------------------|
| AWFIFO | AXI write address to IP | Carries write address beats into QSPI transaction logic |
| WFIFO | AXI write data to IP | Carries write payload into QSPI write data phase |
| BFIFO | IP to AXI write response | Carries write completion response back to AXI |
| ARFIFO | AXI read address to IP | Carries read address beats into QSPI transaction logic |
| RFIFO | IP to AXI read response | Carries read data from QSPI read phase back to AXI |

## CSR Interface (refer https://github.com/nguyenquanicd/APB-CSR-Generator)

The CSR block is generated from `doc/CSR.xlsx`.

### CSR Configuration

| Config | Value | Description |
|--------|-------|-------------|
| Module Name | `m_vlsi_csr` | CSR module name |
| Protocol | APB | APB CSR access |
| Data Width | 32 | Fixed 32-bit CSR data width |
| Address Width | 16 | Fixed 16-bit CSR address width |
| Write Strobe | 4 | Fixed 4-byte write strobe |
| Asynchronous | 1 | Enables asynchronous domain crossing between bus and register logic |

### Register Map

| Register | Offset | Field | Bits | Type | Reset | Description |
|----------|--------|-------|------|------|-------|-------------|
| `ctrl` | `0x00` | `reserved` | `[31:3]` | ro | `0x0` | Reserved |
| `ctrl` | `0x00` | `cmd_2bytes` | `[2]` | rw | `0x0` | `0`: 1-byte command, `1`: 2-byte command |
| `ctrl` | `0x00` | `xip_en` | `[1]` | rw | `0x0` | Enable XIP mode |
| `ctrl` | `0x00` | `en` | `[0]` | rw | `0x0` | Enable QSPI IP |
| `wd` | `0x04` | `req` | `[31]` | rwi | `0x0` | Software request to change address/data width |
| `wd` | `0x04` | `ack` | `[30]` | ro | `0x0` | IP acknowledge for width change request |
| `wd` | `0x04` | `reserved` | `[29:14]` | ro | `0x0` | Reserved |
| `wd` | `0x04` | `addr` | `[13:7]` | rw | `0x0` | Address width configuration. Address width = `addr + 1` |
| `wd` | `0x04` | `data` | `[6:0]` | rw | `0x0` | Data width configuration. Data width = `data + 1` |
| `read` | `0x08` | `req` | `[31]` | rwi | `0x0` | Software request to change read command value |
| `read` | `0x08` | `ack` | `[30]` | ro | `0x0` | IP acknowledge for read command request |
| `read` | `0x08` | `reserved` | `[29:16]` | ro | `0x0` | Reserved |
| `read` | `0x08` | `cmd` | `[15:0]` | rw | `0x0` | Read instruction value; configure before enabling IP |
| `write` | `0x0C` | `req` | `[31]` | rwi | `0x0` | Software request to change write command value |
| `write` | `0x0C` | `ack` | `[30]` | ro | `0x0` | IP acknowledge for write command request |
| `write` | `0x0C` | `reserved` | `[29:16]` | ro | `0x0` | Reserved |
| `write` | `0x0C` | `cmd` | `[15:0]` | rw | `0x0` | Write instruction value; configure before enabling IP |
| `wr_dummy` | `0x10` | `num` | `[31:0]` | rw | `0x0` | Number of dummy bytes for write transactions |
| `rd_dummy` | `0x14` | `num` | `[31:0]` | rw | `0x0` | Number of dummy bytes for read transactions |
| `mode_status` | `0x18` | `reserved` | `[31:2]` | ro | `0x0` | Reserved |
| `mode_status` | `0x18` | `current` | `[1:0]` | ro | `0x0` | Current mode: `00` SPI, `01` Dual future, `10` QSPI, `11` OSPI future |
| `independent` | `0x1C` | `req` | `[31]` | rwi | `0x0` | Software request for an independent command |
| `independent` | `0x1C` | `ack` | `[30]` | ro | `0x0` | IP acknowledge for independent command request |
| `independent` | `0x1C` | `reserved` | `[29:16]` | ro | `0x0` | Reserved |
| `independent` | `0x1C` | `cmd` | `[15:0]` | rw | `0x0` | Independent command value |

## QSPI FSM Function

The FSM sheet describes the QSPI transaction engine. The FSM combines AXI requests, CSR configuration, and QSPI I/O control.

### Main States

| State | Function |
|-------|----------|
| `idle` | Waits while software can configure CSR registers. Software should set `ctrl.en` last |
| `set_up` | Checks CSR request bits and FIFO status before starting a transaction |
| `wait_trans` | Waits for independent command, read request, or write request |
| `ind_cmd` | Sends only the independent command, then returns to setup |
| `write` | Prepares write data path from FIFO to QSPI output shift logic |
| `read` | Prepares read data path from QSPI input shift logic to internal register/FIFO |
| `cmd` | Drives the configured read/write command |
| `addr` | Drives the AXI-derived PSRAM address |
| `dummy` | Drives or waits dummy cycles/bytes based on CSR configuration |
| `data` | Shifts write data to PSRAM or samples read data from PSRAM |

### Transaction Flow

```text
idle
  |
  v
set_up
  |
  v
wait_trans
  |-- independent.req && independent.ack --> ind_cmd --> set_up
  |-- write request ---------------------> write -> cmd -> addr -> dummy -> data
  |-- read request ----------------------> read  -> cmd -> addr -> dummy -> data
```

### Phase Counters

The FSM uses counters loaded from CSR settings or transaction metadata:

| Counter | Function |
|---------|----------|
| `reg_cnt_cmd` | Counts command bits/bytes until command phase completes |
| `reg_cnt_addr` | Counts address bits/bytes until address phase completes |
| `reg_cnt_dummy` | Counts dummy cycles/bytes until dummy phase completes |
| `reg_cnt_data` | Counts data bits/bytes until data phase completes |

### QSPI Data Movement

For write transactions, the FSM loads `reg_data_out` from AXI write data and shifts it to QSPI outputs. In QSPI mode, data is driven across four serial output lanes.

For read transactions, the FSM samples QSPI input lanes into `reg_data_in` and returns the completed data word through the read response path.

The diagram shows these QSPI-related signals:

| Signal | Function |
|--------|----------|
| `CS` | PSRAM chip select |
| `si_clk` | Serial/QSPI clock |
| `SO0`..`SO3` | QSPI output lanes during write/command/address phases |
| `SI0`..`SI3` | QSPI input lanes during read phase |
| `we` | Write operation indication from AXI/IP control |
| `oe` | Read output-enable indication from AXI/IP control |

## Operating Behavior

### Normal Write

1. Software configures `read`, `write`, `wd`, `wr_dummy`, `rd_dummy`, and `ctrl`.
2. AXI master sends a write address transaction on AW.
3. AXI master sends write data on W.
4. AXI controller expands the burst into per-beat addresses and stores address/data in async FIFOs.
5. QSPI FSM selects the write request.
6. FSM sends write command, AXI-derived address, optional dummy phase, and write data to PSRAM.
7. When the final write beat completes, the controller returns an AXI write response.

### Normal Read

1. Software configures `read`, `write`, `wd`, `wr_dummy`, `rd_dummy`, and `ctrl`.
2. AXI master sends a read address transaction on AR.
3. AXI controller expands the burst into per-beat addresses and stores read commands in an async FIFO.
4. QSPI FSM selects the read request.
5. FSM sends read command, AXI-derived address, and optional dummy phase.
6. FSM samples read data from the QSPI interface.
7. Read data is pushed through the async response FIFO and returned on AXI R.

## Software Sequence

The Software Sequence sheet defines three software flows.

### Normal Read and Write Access

1. Configure the `read`, `write`, `wd`, dummy, and `ctrl` registers.
2. Drive a transaction from the CPU through the AXI interface.
3. The AXI address is used as the PSRAM access address.

### Independent Command

Independent commands are used for PSRAM control commands that are not normal memory reads or writes.

1. Configure normal controller registers if required.
2. Drive an AXI transaction only if the command sequence needs an AXI-derived address context.
3. Configure `independent.cmd`.
4. Set `independent.req`.
5. Poll `independent.ack`.
6. When `independent.ack` asserts, the IP starts sending the independent command to PSRAM.

### Special Read/Write Command

Special read/write commands allow software to temporarily replace the normal read or write instruction.

1. Configure the `read`, `write`, `wd`, dummy, and `ctrl` registers.
2. Drive a transaction from the CPU through the AXI interface.
3. The AXI address is used as the PSRAM access address.
4. Configure `read.cmd` and set `read.req`, or configure `write.cmd` and set `write.req`.
5. Configure `wd.data`, `wd.addr`, and set `wd.req` if the width changes.
6. Poll `read.ack` or `write.ack`, and poll `wd.ack` when width change is requested.
7. When the acknowledge bits assert, the IP is ready for the new read/write command behavior.
8. Reconfigure the command fields back to the normal PSRAM read/write commands before returning to normal memory accesses.

## Programming Notes

- Program command, width, and dummy registers before setting `ctrl.en`.
- The AXI address is the PSRAM address for normal transactions.
- Use `wd.req`/`wd.ack`, `read.req`/`read.ack`, `write.req`/`write.ack`, and `independent.req`/`independent.ack` as software-to-hardware handshakes.
- Keep normal read/write command values restored after special commands, otherwise subsequent AXI memory transactions will continue using the special command.
- The QSPI mode is reported by `mode_status.current = 2'b10`.
