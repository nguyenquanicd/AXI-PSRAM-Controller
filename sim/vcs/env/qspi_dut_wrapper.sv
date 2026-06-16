`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Module : qspi_dut_wrapper
// Function:
//   Wraps m_vlsi_qspi_top DUT and m_vlsi_psram_sp behavioral model.
//   Connects AXI and APB interfaces to external BFMs.
//--------------------------------------------------------------------

module qspi_dut_wrapper #(
  parameter int PARA_AXI_DATA_WD    = 32,
  parameter int PARA_AXI_ADDR_WD    = 32,
  parameter int PARA_AXI_ID_WD      = 4,
  parameter int PARA_AXI_LEN_WD     = 8,
  parameter int PARA_AXI_FIFO_DEPTH = 8,
  parameter int PARA_PSRAM_DEPTH    = 1024
) (
  //------------------------------------------------------------------
  // Clock & Reset
  //------------------------------------------------------------------
  input  logic i_aclk,
  input  logic i_aresetn,
  input  logic i_pclk,
  input  logic i_presetn,
  input  logic i_qspi_clk,
  input  logic i_qspi_rstn,

  //------------------------------------------------------------------
  // AXI4 slave interface
  //------------------------------------------------------------------
  input  logic [PARA_AXI_ADDR_WD-1:0]  i_awaddr,
  input  logic                         i_awvalid,
  output logic                         o_awready,
  input  logic [1:0]                   i_awburst,
  input  logic [PARA_AXI_LEN_WD-1:0]   i_awlen,
  input  logic [PARA_AXI_ID_WD-1:0]    i_awid,

  input  logic [PARA_AXI_DATA_WD-1:0]  i_wdata,
  input  logic                         i_wvalid,
  output logic                         o_wready,
  input  logic                         i_wlast,

  output logic [PARA_AXI_ID_WD-1:0]    o_bid,
  output logic [1:0]                   o_bresp,
  output logic                         o_bvalid,
  input  logic                         i_bready,

  input  logic [PARA_AXI_ADDR_WD-1:0]  i_araddr,
  input  logic                         i_arvalid,
  output logic                         o_arready,
  input  logic [1:0]                   i_arburst,
  input  logic [PARA_AXI_LEN_WD-1:0]   i_arlen,
  input  logic [PARA_AXI_ID_WD-1:0]    i_arid,

  output logic [PARA_AXI_ID_WD-1:0]    o_rid,
  output logic [PARA_AXI_DATA_WD-1:0]  o_rdata,
  output logic [1:0]                   o_rresp,
  output logic                         o_rvalid,
  output logic                         o_rlast,
  input  logic                         i_rready,

  //------------------------------------------------------------------
  // APB interface
  //------------------------------------------------------------------
  input  logic [15:0]  i_paddr,
  input  logic         i_protect_en,
  input  logic         i_slverr_en,
  input  logic [2:0]   i_pprot,
  input  logic [31:0]  i_pwdata,
  input  logic         i_pwrite,
  input  logic         i_penable,
  input  logic         i_psel,
  input  logic [3:0]   i_pstrb,
  output logic         o_pslverr,
  output logic         o_pready,
  output logic [31:0]  o_prdata
);

  // =========================================================================
  // QSPI pad signals
  // =========================================================================
  logic        qspi_cs_n;
  logic        qspi_sclk;
  logic [3:0]  qspi_so;
  logic [3:0]  qspi_oe;
  logic [3:0]  qspi_si;

  // =========================================================================
  // DUT: QSPI PSRAM Controller Top
  // =========================================================================
  m_vlsi_qspi_top #(
    .PARA_AXI_DATA_WD    (PARA_AXI_DATA_WD),
    .PARA_AXI_ADDR_WD    (PARA_AXI_ADDR_WD),
    .PARA_AXI_ID_WD      (PARA_AXI_ID_WD),
    .PARA_AXI_LEN_WD     (PARA_AXI_LEN_WD),
    .PARA_AXI_FIFO_DEPTH (PARA_AXI_FIFO_DEPTH)
  ) u_dut (
    .i_aclk       (i_aclk),
    .i_aresetn    (i_aresetn),
    .i_pclk       (i_pclk),
    .i_presetn    (i_presetn),
    .i_qspi_clk   (i_qspi_clk),
    .i_qspi_rstn  (i_qspi_rstn),

    // APB
    .i_paddr      (i_paddr),
    .i_protect_en (i_protect_en),
    .i_slverr_en  (i_slverr_en),
    .i_pprot      (i_pprot),
    .i_pwdata     (i_pwdata),
    .i_pwrite     (i_pwrite),
    .i_penable    (i_penable),
    .i_psel       (i_psel),
    .i_pstrb      (i_pstrb),
    .o_pslverr    (o_pslverr),
    .o_pready     (o_pready),
    .o_prdata     (o_prdata),

    // AXI
    .i_awaddr     (i_awaddr),
    .i_awvalid    (i_awvalid),
    .o_awready    (o_awready),
    .i_awburst    (i_awburst),
    .i_awlen      (i_awlen),
    .i_awid       (i_awid),
    .i_wdata      (i_wdata),
    .i_wvalid     (i_wvalid),
    .o_wready     (o_wready),
    .i_wlast      (i_wlast),
    .o_bid        (o_bid),
    .o_bresp      (o_bresp),
    .o_bvalid     (o_bvalid),
    .i_bready     (i_bready),
    .i_araddr     (i_araddr),
    .i_arvalid    (i_arvalid),
    .o_arready    (o_arready),
    .i_arburst    (i_arburst),
    .i_arlen      (i_arlen),
    .i_arid       (i_arid),
    .o_rid        (o_rid),
    .o_rdata      (o_rdata),
    .o_rresp      (o_rresp),
    .o_rvalid     (o_rvalid),
    .o_rlast      (o_rlast),
    .i_rready     (i_rready),

    // QSPI pad-side
    .o_qspi_cs_n  (qspi_cs_n),
    .o_qspi_sclk  (qspi_sclk),
    .o_qspi_so    (qspi_so),
    .o_qspi_oe    (qspi_oe),
    .i_qspi_si    (qspi_si)
  );

  // =========================================================================
  // PSRAM Behavioral Model
  // =========================================================================
  m_vlsi_psram_sp #(
    .PARA_MEM_DEPTH (PARA_PSRAM_DEPTH)
  ) u_psram (
    .i_sclk  (qspi_sclk),
    .i_rstn  (i_qspi_rstn),
    .i_cs_n  (qspi_cs_n),
    .i_so    (qspi_so),
    .i_oe    (qspi_oe),
    .o_si    (qspi_si)
  );

endmodule : qspi_dut_wrapper
