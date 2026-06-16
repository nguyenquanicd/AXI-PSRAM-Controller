`timescale 1ns / 1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller
// Module : m_vlsi_qspi_top
// Function:
//   Top-level template for integrating:
//     1. APB CSR block
//     2. AXI controller with async FIFO boundary
//     3. QSPI transaction FSM
// Author: ltthinh
// Page: VLSI Technology
//
// Notes:
//   - This file is written as an Emacs/verilog-mode friendly template.
//   - Some child RTLs in the current workspace still have port/type
//     inconsistencies, so this top keeps glue logic minimal and explicit.
//--------------------------------------------------------------------
module m_vlsi_qspi_top #(
  parameter int PARA_AXI_DATA_WD    = 32,
  parameter int PARA_AXI_ADDR_WD    = 24,
  parameter int PARA_AXI_ID_WD      = 4,
  parameter int PARA_AXI_LEN_WD     = 8,
  parameter int PARA_AXI_FIFO_DEPTH = 8
) (
  //------------------------------------------------------------------
  // AXI clock / reset
  //------------------------------------------------------------------
  input  logic                          i_aclk,
  input  logic                          i_aresetn,

  //------------------------------------------------------------------
  // APB clock / reset
  //------------------------------------------------------------------
  input  logic                          i_pclk,
  input  logic                          i_presetn,

  //------------------------------------------------------------------
  // QSPI clock / reset
  //------------------------------------------------------------------
  input  logic                          i_qspi_clk,
  input  logic                          i_qspi_rstn,

  //------------------------------------------------------------------
  // APB CSR interface
  //------------------------------------------------------------------
  input  logic [15:0]                   i_paddr,
  input  logic                          i_protect_en,
  input  logic                          i_slverr_en,
  input  logic [2:0]                    i_pprot,
  input  logic [31:0]                   i_pwdata,
  input  logic                          i_pwrite,
  input  logic                          i_penable,
  input  logic                          i_psel,
  input  logic [3:0]                    i_pstrb,
  output logic                          o_pslverr,
  output logic                          o_pready,
  output logic [31:0]                   o_prdata,

  //------------------------------------------------------------------
  // AXI4 slave interface
  //------------------------------------------------------------------
  input  logic [PARA_AXI_ADDR_WD-1:0]   i_awaddr,
  input  logic                          i_awvalid,
  output logic                          o_awready,
  input  logic [1:0]                    i_awburst,
  input  logic [PARA_AXI_LEN_WD-1:0]    i_awlen,
  input  logic [PARA_AXI_ID_WD-1:0]     i_awid,

  input  logic [PARA_AXI_DATA_WD-1:0]   i_wdata,
  input  logic                          i_wvalid,
  output logic                          o_wready,
  input  logic                          i_wlast,

  output logic [PARA_AXI_ID_WD-1:0]     o_bid,
  output logic [1:0]                    o_bresp,
  output logic                          o_bvalid,
  input  logic                          i_bready,

  input  logic [PARA_AXI_ADDR_WD-1:0]   i_araddr,
  input  logic                          i_arvalid,
  output logic                          o_arready,
  input  logic [1:0]                    i_arburst,
  input  logic [PARA_AXI_LEN_WD-1:0]    i_arlen,
  input  logic [PARA_AXI_ID_WD-1:0]     i_arid,

  output logic [PARA_AXI_ID_WD-1:0]     o_rid,
  output logic [PARA_AXI_DATA_WD-1:0]   o_rdata,
  output logic [1:0]                    o_rresp,
  output logic                          o_rvalid,
  output logic                          o_rlast,
  input  logic                          i_rready,

  //------------------------------------------------------------------
  // QSPI pad-side interface
  //------------------------------------------------------------------
  output logic                          o_qspi_cs_n,
  output logic                          o_qspi_sclk,
  output logic [3:0]                    o_qspi_so,
  output logic [3:0]                    o_qspi_oe,
  input  logic [3:0]                    i_qspi_si
);

  /*AUTOWIRE*/
  // CSR -> FSM
  logic         w_ctrl_cmd_2bytes;
  logic         w_ctrl_en;
  logic         w_wd_req;
  logic         w_wd_ack;
  logic         w_wd_req_clr_data;
  logic         w_wd_req_clr_we;
  logic [5:0]   w_wd_addr;
  logic [23:0]  w_wd_data;
  logic         w_read_req;
  logic         w_read_ack;
  logic         w_read_req_clr_data;
  logic         w_read_req_clr_we;
  logic [15:0]  w_read_cmd;
  logic         w_write_req;
  logic         w_write_ack;
  logic         w_write_req_clr_data;
  logic         w_write_req_clr_we;
  logic [15:0]  w_write_cmd;
  logic [31:0]  w_wr_dummy_num;
  logic [31:0]  w_rd_dummy_num;
  logic [1:0]   w_mode_status_current;
  logic         w_independent_req;
  logic         w_independent_ack;
  logic         w_ctrl_auto_data_wd;
  logic         w_independent_req_clr_data;
  logic         w_independent_req_clr_we;
  logic [1:0]   w_independent_mode;
  logic [15:0]  w_independent_cmd;

  // AXI controller -> FSM
  logic [PARA_AXI_ADDR_WD-1:0] w_qspi_addr;
  logic [PARA_AXI_DATA_WD-1:0] w_qspi_wdata;
  logic                        w_qspi_we;
  logic                        w_qspi_oe;
  logic [PARA_AXI_DATA_WD-1:0] w_qspi_rdata;

  // Minimal bridging for current AXI controller interface.
  // The present AXI RTL exposes read/write-valid qualifiers expected
  // from the memory-side target; keep them asserted in the template.
  logic                        w_qspi_read_accept;
  logic                        w_qspi_write_accept;

  assign o_qspi_sclk         = i_qspi_clk;

  /* m_vlsi_qspi_csr AUTO_TEMPLATE (
   .i_bus_clk                  (i_pclk),
   .i_bus_rstn                 (i_presetn),
   .i_reg_clk                  (i_qspi_clk),
   .i_reg_rstn                 (i_qspi_rstn),
   .o_ctrl_cmd_2bytes          (w_ctrl_cmd_2bytes),
   .o_ctrl_en                  (w_ctrl_en),
   .o_wd_req                   (w_wd_req),
   .i_hw_wdata_wd_req          (w_wd_req_clr_data),
   .i_hw_we_wd_req             (w_wd_req_clr_we),
   .i_wd_ack                   (w_wd_ack),
   .o_wd_addr                  (w_wd_addr),
   .o_wd_data                  (w_wd_data),
   .o_read_reqq                (w_read_req),
   .i_hw_wdata_read_req        (w_read_req_clr_data),
   .i_hw_we_read_req           (w_read_req_clr_we),
   .i_read_ack                 (w_read_ack),
   .o_read_cmd                 (w_read_cmd),
   .o_write_req                (w_write_req),
   .i_hw_wdata_write_req       (w_write_req_clr_data),
   .i_hw_we_write_req          (w_write_req_clr_we),
   .i_write_ack                (w_write_ack),
   .o_write_cmd                (w_write_cmd),
   .o_wr_dummy_num             (w_wr_dummy_num),
   .o_rd_dummy_num             (w_rd_dummy_num),
   .i_mode_status_current      (w_mode_status_current),
   .o_independent_req          (w_independent_req),
   .i_hw_wdata_independent_req (w_independent_req_clr_data),
   .i_hw_we_independent_req    (w_independent_req_clr_we),
   .i_independent_ack          (w_independent_ack),
   .o_independent_mode         (w_independent_mode),
   .o_independent_cmd          (w_independent_cmd));
   */
  m_vlsi_qspi_csr u_csr (/*AUTOINST*/
                         // Outputs
                         .o_pslverr              (o_pslverr),
                         .o_pready               (o_pready),
                         .o_prdata               (o_prdata[31:0]),
                         .o_ctrl_cmd_2bytes      (w_ctrl_cmd_2bytes),
                         .o_ctrl_en              (w_ctrl_en),
                         .o_wd_req               (w_wd_req),
                         .o_wd_addr              (w_wd_addr[5:0]),
                         .o_wd_data              (w_wd_data[23:0]),
                         .o_read_reqq            (w_read_req),
                         .o_read_cmd             (w_read_cmd[15:0]),
                         .o_write_reqq           (w_write_req),
                         .o_write_cmd            (w_write_cmd[15:0]),
                         .o_wr_dummy_num         (w_wr_dummy_num[31:0]),
                         .o_rd_dummy_num         (w_rd_dummy_num[31:0]),
                         .o_independent_req      (w_independent_req),
                         .o_independent_mode     (w_independent_mode[1:0]),
                         .o_independent_cmd      (w_independent_cmd[15:0]),
                         // Inputs
                         .i_bus_clk              (i_pclk),
                         .i_bus_rstn             (i_presetn),
                         .i_paddr                (i_paddr[15:0]),
                         .i_protect_en           (i_protect_en),
                         .i_slverr_en            (i_slverr_en),
                         .i_pprot                (i_pprot[2:0]),
                         .i_pwdata               (i_pwdata[31:0]),
                         .i_pwrite               (i_pwrite),
                         .i_penable              (i_penable),
                         .i_psel                 (i_psel),
                         .i_pstrb                (i_pstrb[3:0]),
                         .i_reg_clk              (i_qspi_clk),
                         .i_reg_rstn             (i_qspi_rstn),
                         .i_hw_wdata_wd_req      (w_wd_req_clr_data),
                         .i_hw_we_wd_req         (w_wd_req_clr_we),
                         .i_wd_ack               (w_wd_ack),
                         .i_hw_wdata_read_reqq   (w_read_req_clr_data),
                         .i_hw_we_read_reqq      (w_read_req_clr_we),
                         .i_read_ack             (w_read_ack),
                         .i_hw_wdata_write_reqq  (w_write_req_clr_data),
                         .i_hw_we_write_reqq     (w_write_req_clr_we),
                         .i_write_ack            (w_write_ack),
                         .i_mode_status_current  (w_mode_status_current[1:0]),
                         .i_hw_wdata_independent_req(w_independent_req_clr_data),
                         .i_hw_we_independent_req(w_independent_req_clr_we),
                         .i_independent_ack      (w_independent_ack),
                         .o_ctrl_auto_data_wd    (w_ctrl_auto_data_wd));

  /* m_vlsi_axi4_sram AUTO_TEMPLATE (
   .i_clk              (i_aclk),
   .i_rst_n            (i_aresetn),
   .i_sclk             (i_qspi_clk),
   .i_slck_rst_n       (i_qspi_rstn),
   .o_sram_addr        (w_qspi_addr),
   .o_sram_wdata       (w_qspi_wdata),
   .o_sram_we          (w_qspi_we),
   .o_sram_oe          (w_qspi_oe),
   .i_sram_rdata       (w_qspi_rdata),
   .i_sram_read_valid  (w_qspi_read_accept),
   .i_sram_write_valid (w_qspi_write_accept));
   */
  m_vlsi_axi4_sram #(
    .PARA_DATA_WD    (PARA_AXI_DATA_WD),
    .PARA_ADDR_WD    (PARA_AXI_ADDR_WD),
    .PARA_ID_WD      (PARA_AXI_ID_WD),
    .PARA_LEN_WD     (PARA_AXI_LEN_WD),
    .PARA_FIFO_DEPTH (PARA_AXI_FIFO_DEPTH)
  ) u_axi_ctrl (/*AUTOINST*/
                // Outputs
                .o_awready          (o_awready),
                .o_wready           (o_wready),
                .o_bid              (o_bid[PARA_AXI_ID_WD-1:0]),
                .o_bresp            (o_bresp[1:0]),
                .o_bvalid           (o_bvalid),
                .o_arready          (o_arready),
                .o_rid              (o_rid[PARA_AXI_ID_WD-1:0]),
                .o_rdata            (o_rdata[PARA_AXI_DATA_WD-1:0]),
                .o_rresp            (o_rresp[1:0]),
                .o_rvalid           (o_rvalid),
                .o_rlast            (o_rlast),
                .o_sram_addr        (w_qspi_addr[PARA_AXI_ADDR_WD-1:0]),
                .o_sram_wdata       (w_qspi_wdata[PARA_AXI_DATA_WD-1:0]),
                .o_sram_we          (w_qspi_we),
                .o_sram_oe          (w_qspi_oe),
                // Inputs
                .i_clk              (i_aclk),
                .i_rst_n            (i_aresetn),
                .i_sclk             (i_qspi_clk),
                .i_slck_rst_n       (i_qspi_rstn),
                .i_awaddr           (i_awaddr[PARA_AXI_ADDR_WD-1:0]),
                .i_awvalid          (i_awvalid),
                .i_awburst          (i_awburst[1:0]),
                .i_awlen            (i_awlen[PARA_AXI_LEN_WD-1:0]),
                .i_awid             (i_awid[PARA_AXI_ID_WD-1:0]),
                .i_wdata            (i_wdata[PARA_AXI_DATA_WD-1:0]),
                .i_wvalid           (i_wvalid),
                .i_wlast            (i_wlast),
                .i_bready           (i_bready),
                .i_araddr           (i_araddr[PARA_AXI_ADDR_WD-1:0]),
                .i_arvalid          (i_arvalid),
                .i_arburst          (i_arburst[1:0]),
                .i_arlen            (i_arlen[PARA_AXI_LEN_WD-1:0]),
                .i_arid             (i_arid[PARA_AXI_ID_WD-1:0]),
                .i_rready           (i_rready),
                .i_sram_rdata       (w_qspi_rdata[PARA_AXI_DATA_WD-1:0]),
                .i_sram_read_valid  (w_qspi_read_accept),
                .i_sram_write_valid (w_qspi_write_accept));

  /* m_vlsi_qspi_fsm AUTO_TEMPLATE (
   .i_sclk                       (i_qspi_clk),
   .i_rstn_sclk                  (i_qspi_rstn),
   .i_csr_ctrl_cmd_2bytes        (w_ctrl_cmd_2bytes),
   .i_csr_ctrl_en                (w_ctrl_en),
   .i_csr_wd_req                 (w_wd_req),
   .o_csr_wd_ack                 (w_wd_ack),
   .o_csr_hw_wdata_wd_req        (w_wd_req_clr_data),
   .o_csr_hw_we_wd_req           (w_wd_req_clr_we),
   .i_csr_wd_addr                (w_wd_addr),
   .i_csr_wd_data                (w_wd_data),
   .i_csr_read_req               (w_read_req),
   .o_csr_read_ack               (w_read_ack),
   .o_csr_hw_wdata_read_req      (w_read_req_clr_data),
   .o_csr_hw_we_read_req         (w_read_req_clr_we),
   .i_csr_read_cmd               (w_read_cmd),
   .i_csr_write_req              (w_write_req),
   .o_csr_write_ack              (w_write_ack),
   .o_csr_hw_wdata_write_req     (w_write_req_clr_data),
   .o_csr_hw_we_write_req        (w_write_req_clr_we),
   .i_csr_write_cmd              (w_write_cmd),
   .i_csr_wr_dummy_num           (w_wr_dummy_num[3:0]),
   .i_csr_rd_dummy_num           (w_rd_dummy_num[3:0]),
   .o_csr_mode_status_current    (w_mode_status_current),
   .i_csr_independent_req        (w_independent_req),
   .o_csr_independent_ack        (w_independent_ack),
   .o_csr_hw_wdata_independent_req(w_independent_req_clr_data),
   .o_csr_hw_we_independent_req  (w_independent_req_clr_we),
   .i_csr_independent_mode       ({1'b0, w_independent_mode}),
   .i_csr_independent_cmd        (w_independent_cmd),
   .i_ax_addr                    (w_qspi_addr),
   .i_ax_wdata                   (w_qspi_wdata),
   .i_ax_we                      (w_qspi_we),
   .i_ax_oe                      (w_qspi_oe),
   .o_ax_rdata                   (w_qspi_rdata));
   */
  m_vlsi_qspi_fsm #(
    .PARA_ADDR_WD (PARA_AXI_ADDR_WD),
    .PARA_DATA_WD (PARA_AXI_DATA_WD),
    .PARA_LEN_WD (PARA_AXI_LEN_WD)
  ) u_qspi_fsm (/*AUTOINST*/
                // Outputs
                .o_csr_wd_ack             (w_wd_ack),
                .o_csr_hw_wdata_wd_req    (w_wd_req_clr_data),
                .o_csr_hw_we_wd_req       (w_wd_req_clr_we),
                .o_csr_read_ack           (w_read_ack),
                .o_csr_hw_wdata_read_req  (w_read_req_clr_data),
                .o_csr_hw_we_read_req     (w_read_req_clr_we),
                .o_csr_write_ack          (w_write_ack),
                .o_csr_hw_wdata_write_req (w_write_req_clr_data),
                .o_csr_hw_we_write_req    (w_write_req_clr_we),
                .o_csr_mode_status_current(w_mode_status_current[1:0]),
                .o_csr_independent_ack    (w_independent_ack),
                .o_csr_hw_wdata_independent_req(w_independent_req_clr_data),
                .o_csr_hw_we_independent_req(w_independent_req_clr_we),
                .o_ax_rdata               (w_qspi_rdata[PARA_AXI_DATA_WD-1:0]),
                .o_qspi_cs_n              (o_qspi_cs_n),
                // .o_qspi_sclk              (),
                .o_qspi_so                (o_qspi_so[3:0]),
                .o_qspi_oe                (o_qspi_oe[3:0]),
                // Inputs
                .i_sclk                   (i_qspi_clk),
                .i_rstn_sclk              (i_qspi_rstn),
                .i_csr_ctrl_cmd_2bytes    (w_ctrl_cmd_2bytes),
                .i_csr_ctrl_en            (w_ctrl_en),
                .i_csr_wd_req             (w_wd_req),
                .i_csr_wd_addr            (w_wd_addr[5:0]),
                .i_csr_wd_data            (w_wd_data[23:0]),
                .i_csr_read_req           (w_read_req),
                .i_csr_read_cmd           (w_read_cmd[15:0]),
                .i_csr_write_req          (w_write_req),
                .i_csr_write_cmd          (w_write_cmd[15:0]),
                .i_csr_wr_dummy_num       (w_wr_dummy_num[3:0]),
                .i_csr_rd_dummy_num       (w_rd_dummy_num[3:0]),
                .i_csr_independent_req    (w_independent_req),
                .i_csr_independent_mode   (w_independent_mode[1:0]),
                .i_csr_independent_cmd    (w_independent_cmd[15:0]),
                .i_ax_addr                (w_qspi_addr[PARA_AXI_ADDR_WD-1:0]),
                .i_ax_wdata               (w_qspi_wdata[PARA_AXI_DATA_WD-1:0]),
                .i_ax_we                  (w_qspi_we),
                .i_ax_oe                  (w_qspi_oe),
                .i_qspi_si                (i_qspi_si[3:0]),
                .o_ax_read_valid          (w_qspi_read_accept),
                .o_ax_write_valid         (w_qspi_write_accept),
                .i_ax_awlen               (i_awlen[PARA_AXI_LEN_WD-1:0]),
                .i_ax_arlen               (i_arlen[PARA_AXI_LEN_WD-1:0]),
                .i_csr_ctrl_auto_data_wd  (w_ctrl_auto_data_wd));

endmodule : m_vlsi_qspi_top
