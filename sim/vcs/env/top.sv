`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Module : test_top
// Function:
//   Top-level testbench:
//     - Clock/reset generation for all 3 clock domains
//     - Instantiation of DUT wrapper and BFM interfaces
//     - Test program entry point
//--------------------------------------------------------------------

module test_top;

  // =========================================================================
  // Parameters
  // =========================================================================
  localparam int PARA_AXI_DATA_WD    = 32;
  localparam int PARA_AXI_ADDR_WD    = 32;
  localparam int PARA_AXI_ID_WD      = 4;
  localparam int PARA_AXI_LEN_WD     = 8;
  localparam int PARA_AXI_FIFO_DEPTH = 8;
  localparam int PARA_PSRAM_DEPTH    = 1024;

  localparam real ACLK_PERIOD     = 10.0;   // 100 MHz
  localparam real PCLK_PERIOD     = 20.0;   // 50 MHz
  localparam real QSPI_CLK_PERIOD = 10.0;   // 100 MHz

  // =========================================================================
  // Clock & Reset signals
  // =========================================================================
  logic aclk;
  logic aresetn;
  logic pclk;
  logic presetn;
  logic qspi_clk;
  logic qspi_rstn;

  // =========================================================================
  // AXI interface signals (for BFM connection)
  // =========================================================================
  logic [PARA_AXI_ADDR_WD-1:0]   bfm_awaddr;
  logic                          bfm_awvalid;
  logic                          bfm_awready;
  logic [1:0]                    bfm_awburst;
  logic [PARA_AXI_LEN_WD-1:0]    bfm_awlen;
  logic [PARA_AXI_ID_WD-1:0]     bfm_awid;

  logic [PARA_AXI_DATA_WD-1:0]   bfm_wdata;
  logic                          bfm_wvalid;
  logic                          bfm_wready;
  logic                          bfm_wlast;

  logic [PARA_AXI_ID_WD-1:0]     bfm_bid;
  logic [1:0]                    bfm_bresp;
  logic                          bfm_bvalid;
  logic                          bfm_bready;

  logic [PARA_AXI_ADDR_WD-1:0]   bfm_araddr;
  logic                          bfm_arvalid;
  logic                          bfm_arready;
  logic [1:0]                    bfm_arburst;
  logic [PARA_AXI_LEN_WD-1:0]    bfm_arlen;
  logic [PARA_AXI_ID_WD-1:0]     bfm_arid;

  logic [PARA_AXI_ID_WD-1:0]     bfm_rid;
  logic [PARA_AXI_DATA_WD-1:0]   bfm_rdata;
  logic [1:0]                    bfm_rresp;
  logic                          bfm_rvalid;
  logic                          bfm_rlast;
  logic                          bfm_rready;

  // =========================================================================
  // APB interface signals
  // =========================================================================
  logic [15:0]   bfm_paddr;
  logic          bfm_psel;
  logic          bfm_penable;
  logic          bfm_pwrite;
  logic [31:0]   bfm_pwdata;
  logic [3:0]    bfm_pstrb;
  logic          bfm_protect_en;
  logic          bfm_slverr_en;
  logic [2:0]    bfm_pprot;

  logic          bfm_pready;
  logic [31:0]   bfm_prdata;
  logic          bfm_pslverr;

  // =========================================================================
  // Clock Generation
  // =========================================================================
  initial begin
    aclk = 1'b0;
    forever #(ACLK_PERIOD/2.0) aclk = ~aclk;
  end

  initial begin
    pclk = 1'b0;
    forever #(PCLK_PERIOD/2.0) pclk = ~pclk;
  end

  initial begin
    qspi_clk = 1'b0;
    forever #(QSPI_CLK_PERIOD/2.0) qspi_clk = ~qspi_clk;
  end

  // =========================================================================
  // Reset Generation
  // =========================================================================
  initial begin
    aresetn  = 1'b0;
    presetn  = 1'b0;
    qspi_rstn = 1'b0;

    repeat (20) @(posedge aclk);
    aresetn  = 1'b1;
    presetn  = 1'b1;
    qspi_rstn = 1'b1;
  end

  // =========================================================================
  // BFM Interfaces
  // =========================================================================
  axi_master_bfm #(
    .ADDR_WD (PARA_AXI_ADDR_WD),
    .DATA_WD (PARA_AXI_DATA_WD),
    .ID_WD   (PARA_AXI_ID_WD),
    .LEN_WD  (PARA_AXI_LEN_WD)
  ) u_axi_bfm (
    .aclk    (aclk),
    .aresetn (aresetn)
  );

  apb_master_bfm #(
    .ADDR_WD (16),
    .DATA_WD (32)
  ) u_apb_bfm (
    .pclk    (pclk),
    .presetn (presetn)
  );

  // =========================================================================
  // Connect BFM signals to DUT wrapper
  // =========================================================================
  // AXI interface
  assign bfm_awaddr  = u_axi_bfm.awaddr;
  assign bfm_awvalid = u_axi_bfm.awvalid;
  assign bfm_awburst = u_axi_bfm.awburst;
  assign bfm_awlen   = u_axi_bfm.awlen;
  assign bfm_awid    = u_axi_bfm.awid;
  assign u_axi_bfm.awready = bfm_awready;

  assign bfm_wdata  = u_axi_bfm.wdata;
  assign bfm_wvalid = u_axi_bfm.wvalid;
  assign bfm_wlast  = u_axi_bfm.wlast;
  assign u_axi_bfm.wready = bfm_wready;

  assign u_axi_bfm.bid    = bfm_bid;
  assign u_axi_bfm.bresp  = bfm_bresp;
  assign u_axi_bfm.bvalid = bfm_bvalid;
  assign bfm_bready = u_axi_bfm.bready;

  assign bfm_araddr  = u_axi_bfm.araddr;
  assign bfm_arvalid = u_axi_bfm.arvalid;
  assign bfm_arburst = u_axi_bfm.arburst;
  assign bfm_arlen   = u_axi_bfm.arlen;
  assign bfm_arid    = u_axi_bfm.arid;
  assign u_axi_bfm.arready = bfm_arready;

  assign u_axi_bfm.rid    = bfm_rid;
  assign u_axi_bfm.rdata  = bfm_rdata;
  assign u_axi_bfm.rresp  = bfm_rresp;
  assign u_axi_bfm.rvalid = bfm_rvalid;
  assign u_axi_bfm.rlast  = bfm_rlast;
  assign bfm_rready = u_axi_bfm.rready;

  // APB interface
  assign bfm_paddr      = u_apb_bfm.paddr;
  assign bfm_psel       = u_apb_bfm.psel;
  assign bfm_penable    = u_apb_bfm.penable;
  assign bfm_pwrite     = u_apb_bfm.pwrite;
  assign bfm_pwdata     = u_apb_bfm.pwdata;
  assign bfm_pstrb      = u_apb_bfm.pstrb;
  assign bfm_protect_en = u_apb_bfm.protect_en;
  assign bfm_slverr_en  = u_apb_bfm.slverr_en;
  assign bfm_pprot      = u_apb_bfm.pprot;

  assign u_apb_bfm.pready  = bfm_pready;
  assign u_apb_bfm.prdata  = bfm_prdata;
  assign u_apb_bfm.pslverr = bfm_pslverr;

  // =========================================================================
  // DUT Wrapper
  // =========================================================================
  qspi_dut_wrapper #(
    .PARA_AXI_DATA_WD    (PARA_AXI_DATA_WD),
    .PARA_AXI_ADDR_WD    (PARA_AXI_ADDR_WD),
    .PARA_AXI_ID_WD      (PARA_AXI_ID_WD),
    .PARA_AXI_LEN_WD     (PARA_AXI_LEN_WD),
    .PARA_AXI_FIFO_DEPTH (PARA_AXI_FIFO_DEPTH),
    .PARA_PSRAM_DEPTH    (PARA_PSRAM_DEPTH)
  ) u_dut_wrapper (
    .i_aclk       (aclk),
    .i_aresetn    (aresetn),
    .i_pclk       (pclk),
    .i_presetn    (presetn),
    .i_qspi_clk   (qspi_clk),
    .i_qspi_rstn  (qspi_rstn),

    // AXI
    .i_awaddr     (bfm_awaddr),
    .i_awvalid    (bfm_awvalid),
    .o_awready    (bfm_awready),
    .i_awburst    (bfm_awburst),
    .i_awlen      (bfm_awlen),
    .i_awid       (bfm_awid),
    .i_wdata      (bfm_wdata),
    .i_wvalid     (bfm_wvalid),
    .o_wready     (bfm_wready),
    .i_wlast      (bfm_wlast),
    .o_bid        (bfm_bid),
    .o_bresp      (bfm_bresp),
    .o_bvalid     (bfm_bvalid),
    .i_bready     (bfm_bready),
    .i_araddr     (bfm_araddr),
    .i_arvalid    (bfm_arvalid),
    .o_arready    (bfm_arready),
    .i_arburst    (bfm_arburst),
    .i_arlen      (bfm_arlen),
    .i_arid       (bfm_arid),
    .o_rid        (bfm_rid),
    .o_rdata      (bfm_rdata),
    .o_rresp      (bfm_rresp),
    .o_rvalid     (bfm_rvalid),
    .o_rlast      (bfm_rlast),
    .i_rready     (bfm_rready),

    // APB
    .i_paddr      (bfm_paddr),
    .i_protect_en (bfm_protect_en),
    .i_slverr_en  (bfm_slverr_en),
    .i_pprot      (bfm_pprot),
    .i_pwdata     (bfm_pwdata),
    .i_pwrite     (bfm_pwrite),
    .i_penable    (bfm_penable),
    .i_psel       (bfm_psel),
    .i_pstrb      (bfm_pstrb),
    .o_pslverr    (bfm_pslverr),
    .o_pready     (bfm_pready),
    .o_prdata     (bfm_prdata)
  );

  // =========================================================================
  // Waveform dumping
  // =========================================================================
`ifdef WAVES_FSDB
  initial begin
    $fsdbDumpfile("test_top.fsdb");
    $fsdbDumpvars(0, test_top);
  end
`elsif WAVES_VCD
  initial begin
    $dumpfile("test_top.vcd");
    $dumpvars(0, test_top);
  end
`endif

  // =========================================================================
  // Test execution
  // =========================================================================
  initial begin
    // Wait for reset release
    wait (aresetn === 1'b1 && presetn === 1'b1 && qspi_rstn === 1'b1);
    repeat (10) @(posedge aclk);

    $display("============================================================");
    $display(" QSPI PSRAM Controller Testbench");
    $display(" ACLK period  = %0.1f ns", ACLK_PERIOD);
    $display(" PCLK period  = %0.1f ns", PCLK_PERIOD);
    $display(" QSPI period  = %0.1f ns", QSPI_CLK_PERIOD);
    $display("============================================================");

    // Run the basic test
    basic_qspi_psram_test();

    $display("============================================================");
    $display(" ALL TESTS PASSED");
    $display("============================================================");
    $finish;
  end

  // =========================================================================
  // Timeout watchdog
  // =========================================================================
  initial begin
    #10_000_000;  // 10ms timeout
    $display("ERROR: Simulation timeout!");
    $finish;
  end

  // =========================================================================
  // Include test implementations
  // =========================================================================
  `include "ts.basic_qspi_psram_test.sv"

endmodule : test_top
