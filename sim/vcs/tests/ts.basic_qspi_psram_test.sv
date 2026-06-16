//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Test   : ts.basic_qspi_psram_test
// Function:
//   Basic QSPI PSRAM test with proper init flow:
//     1. IP starts in SPI mode. Send independent cmd to switch PSRAM to QSPI.
//     2. Reconfigure CSR for QSPI mode.
//     3. Single-beat write + read verify.
//     4. Burst write + read verify.
//     5. FIXED burst test.
// Note: counters count one extra, so configure N-1 for N bits.
//--------------------------------------------------------------------

task automatic basic_qspi_psram_test();
  logic [31:0]                          rdata;
  logic [31:0]                          rd_data_arr [];
  logic [31:0]                          wr_data_arr [];
  int                                   mismatch;
  int                                   b;
  int                                   errors;

  // =========================================================================
  // CSR Register Offsets
  // =========================================================================
  localparam CTRL_OFFSET        = 16'h00;
  localparam WD_OFFSET          = 16'h04;
  localparam READ_OFFSET        = 16'h08;
  localparam WRITE_OFFSET       = 16'h0C;
  localparam WR_DUMMY_OFFSET    = 16'h10;
  localparam RD_DUMMY_OFFSET    = 16'h14;
  localparam MODE_STATUS_OFFSET = 16'h18;
  localparam INDEPENDENT_OFFSET = 16'h1C;

  // QSPI PSRAM Commands
  localparam QSPI_READ_CMD  = 16'h00EB;
  localparam QSPI_WRITE_CMD = 16'h0038;
  localparam QPI_ENTER_CMD  = 16'h0035;   // Enter Quad mode

  $display("------------------------------------------------------------");
  $display(" TEST: basic_qspi_psram_test");
  $display("------------------------------------------------------------");

  errors = 0;

  // =========================================================================
  // Step 1: Wait for reset to fully propagate
  // =========================================================================
  u_apb_bfm.wait_cycles(20);
  u_axi_bfm.wait_cycles(20);

  $display("[TEST] Configuring CSR registers...");

  // =========================================================================
  // Step 2: Configure SPI-mode commands (IP starts in SPI mode)
  //   write register: [31]=req, [15:0]=cmd
  // =========================================================================
  u_apb_bfm.write(WRITE_OFFSET, {1'b0, 15'd0, QSPI_WRITE_CMD});
  u_apb_bfm.write(WRITE_OFFSET, {1'b1, 15'd0, QSPI_WRITE_CMD});
  u_apb_bfm.wait_cycles(5);

  u_apb_bfm.write(READ_OFFSET, {1'b0, 15'd0, QSPI_READ_CMD});
  u_apb_bfm.write(READ_OFFSET, {1'b1, 15'd0, QSPI_READ_CMD});
  u_apb_bfm.wait_cycles(5);

  // =========================================================================
  // Step 3: Configure width/data (counter counts N+1, so configure N-1)
  //   wd: [31]=req, [29:24]=addr_width, [23:0]=data_width
  //   For QSPI: 3-byte addr=24 bits -> configure 23
  //             4-byte data=32 bits -> configure 31
  // =========================================================================
  u_apb_bfm.write(WD_OFFSET, {1'b0, 1'b0, 6'd23, 24'd31});
  u_apb_bfm.write(WD_OFFSET, {1'b1, 1'b0, 6'd23, 24'd31});
  u_apb_bfm.wait_cycles(5);

  // =========================================================================
  // Step 4: Configure dummy cycles (N-1)
  //   write dummy = 0 (no dummy)
  //   read dummy  = 6 QSPI cycles -> configure 5
  // =========================================================================
  u_apb_bfm.write(WR_DUMMY_OFFSET, 32'd0);
  u_apb_bfm.write(RD_DUMMY_OFFSET, 32'd5);
  u_apb_bfm.wait_cycles(5);

  // =========================================================================
  // Step 5: Enable controller (still in SPI mode initially)
  //   ctrl: [2]=cmd_2bytes, [1]=xip_en, [0]=en
  // =========================================================================
  u_apb_bfm.write(CTRL_OFFSET, 32'h0000_0005);  // cmd_2bytes=1, xip=0, en=1
  u_apb_bfm.wait_cycles(10);

  $display("[TEST] CSR configuration complete. Controller enabled.");

  // =========================================================================
  // Step 6: Send independent command to switch PSRAM to QSPI mode
  //   independent: [31]=req, [29:28]=mode, [15:0]=cmd
  //   Mode 2'b10 = QSPI. Command 0x35 = Enter QPI.
  //   The independent cmd is sent in current (SPI) mode.
  //   After ack, the IP switches to QSPI mode.
  // =========================================================================
  $display("[TEST] Sending independent command to enter QSPI mode...");
  u_apb_bfm.write(INDEPENDENT_OFFSET, {1'b0, 1'b0, 2'b10, 12'd0, QPI_ENTER_CMD});
  u_apb_bfm.write(INDEPENDENT_OFFSET, {1'b1, 1'b0, 2'b10, 12'd0, QPI_ENTER_CMD});
  // Wait for ack (poll mode_status or independent ack)
  u_apb_bfm.wait_cycles(50);
  $display("[TEST] QSPI mode switch complete.");

  // =========================================================================
  // Step 7: Single-beat write test
  // =========================================================================
  $display("[TEST] Single-beat write test...");
  u_axi_bfm.write_single(32'h0000_0100, 32'hDEAD_BEEF, 4'h0);
  u_axi_bfm.wait_cycles(50);

  // =========================================================================
  // Step 8: Single-beat read test
  // =========================================================================
  $display("[TEST] Single-beat read test...");
  u_axi_bfm.read_single(32'h0000_0100, 4'h1, rdata);
  $display("[TEST] Read data: 0x%08h (expected: 0xDEAD_BEEF)", rdata);
  if (rdata !== 32'hDEAD_BEEF) begin
    $display("[TEST] ERROR: Single-beat read mismatch!");
    errors++;
  end else begin
    $display("[TEST] Single-beat read OK");
  end

  // =========================================================================
  // Step 9: Burst write test (4 beats)
  // =========================================================================
  $display("[TEST] Burst write test (4 beats, INCR)...");
  wr_data_arr = new[4];
  for (b = 0; b < 4; b++)
    wr_data_arr[b] = 32'hA500_0000 + b;
  u_axi_bfm.write_burst(32'h0000_0200, 2'b01, 8'd3, wr_data_arr, 4'h2);
  u_axi_bfm.wait_cycles(50);

  // =========================================================================
  // Step 10: Burst read test (4 beats) with data verification
  // =========================================================================
  $display("[TEST] Burst read test (4 beats, INCR) with verification...");
  u_axi_bfm.read_burst(32'h0000_0200, 2'b01, 8'd3, 4'h3, rd_data_arr, 1'b1, wr_data_arr, mismatch);
  if (mismatch > 0) begin
    $display("[TEST] ERROR: Burst read had %0d mismatches!", mismatch);
    errors += mismatch;
  end else begin
    $display("[TEST] Burst read OK");
  end

  // =========================================================================
  // Step 11: FIXED burst test
  // =========================================================================
  $display("[TEST] FIXED burst write/read test...");
  wr_data_arr = new[4];
  for (b = 0; b < 4; b++)
    wr_data_arr[b] = 32'hCAFE_0000 + b;
  u_axi_bfm.write_burst(32'h0000_0300, 2'b00, 8'd3, wr_data_arr, 4'h4);
  u_axi_bfm.wait_cycles(50);
  u_axi_bfm.read_burst(32'h0000_0300, 2'b00, 8'd3, 4'h5, rd_data_arr, 1'b1, wr_data_arr, mismatch);
  if (mismatch > 0) begin
    $display("[TEST] ERROR: FIXED burst had %0d mismatches!", mismatch);
    errors += mismatch;
  end else begin
    $display("[TEST] FIXED burst OK");
  end

  // =========================================================================
  // Summary
  // =========================================================================
  if (errors == 0) begin
    $display("------------------------------------------------------------");
    $display(" TEST basic_qspi_psram_test: PASSED (0 errors)");
    $display("------------------------------------------------------------");
  end else begin
    $display("------------------------------------------------------------");
    $display(" TEST basic_qspi_psram_test: FAILED (%0d errors)", errors);
    $display("------------------------------------------------------------");
  end

endtask : basic_qspi_psram_test
