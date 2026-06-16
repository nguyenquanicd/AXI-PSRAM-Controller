`timescale 1ns / 1ps
//--------------------------------------
// Project: AXI4 SRAM Controller
// Module : m_vlsi_axi4_sram
// Function:
//   AXI4 slave front-end with two clock domains:
//     - i_clk  : AXI bus side
//     - i_sclk : memory / QSPI FSM side
// Author: ltthinh
// Page: VLSI Technology
//--------------------------------------

module m_vlsi_axi4_sram #(
  parameter int PARA_DATA_WD    = 32,
  parameter int PARA_ADDR_WD    = 32,
  parameter int PARA_ID_WD      = 4,
  parameter int PARA_LEN_WD     = 8,
  parameter int PARA_FIFO_DEPTH = 8
) (
  input  logic                    i_clk,
  input  logic                    i_rst_n,
  input  logic                    i_sclk,
  input  logic                    i_slck_rst_n,
  input  logic [PARA_ADDR_WD-1:0] i_awaddr,
  input  logic                    i_awvalid,
  output logic                    o_awready,
  input  logic [1:0]              i_awburst,
  input  logic [PARA_LEN_WD-1:0]  i_awlen,
  input  logic [PARA_ID_WD-1:0]   i_awid,
  input  logic [PARA_DATA_WD-1:0] i_wdata,
  input  logic                    i_wvalid,
  output logic                    o_wready,
  input  logic                    i_wlast,
  output logic [PARA_ID_WD-1:0]   o_bid,
  output logic [1:0]              o_bresp,
  output logic                    o_bvalid,
  input  logic                    i_bready,
  input  logic [PARA_ADDR_WD-1:0] i_araddr,
  input  logic                    i_arvalid,
  output logic                    o_arready,
  input  logic [1:0]              i_arburst,
  input  logic [PARA_LEN_WD-1:0]  i_arlen,
  input  logic [PARA_ID_WD-1:0]   i_arid,
  output logic [PARA_ID_WD-1:0]   o_rid,
  output logic [PARA_DATA_WD-1:0] o_rdata,
  output logic [1:0]              o_rresp,
  output logic                    o_rvalid,
  output logic                    o_rlast,
  input  logic                    i_rready,
  output logic [PARA_ADDR_WD-1:0] o_sram_addr,
  output logic [PARA_DATA_WD-1:0] o_sram_wdata,
  output logic                    o_sram_we,
  output logic                    o_sram_oe,
  input  logic [PARA_DATA_WD-1:0] i_sram_rdata,
  input  logic                    i_sram_read_valid,
  input  logic                    i_sram_write_valid
);

  logic [PARA_ADDR_WD-1:0]            w_axaddr_wr;
  logic                               w_aw_push;
  logic [PARA_ID_WD-1:0]              w_aw_id;
  logic                               w_aw_last;

  logic [PARA_ADDR_WD-1:0]            w_axaddr_rd;
  logic                               w_ar_push;
  logic [PARA_ID_WD-1:0]              w_ar_id;
  logic                               w_ar_last;

  logic [PARA_ADDR_WD+PARA_ID_WD:0]   w_awfifo_wdata;
  logic [PARA_ADDR_WD+PARA_ID_WD:0]   w_awfifo_rdata;
  logic                               w_awfifo_write_valid;
  logic                               w_awfifo_read_valid;
  logic                               w_awfifo_full;
  logic                               w_awfifo_empty;
  logic                               w_awfifo_we;
  logic                               w_awfifo_re;

  logic [PARA_DATA_WD:0]              w_wfifo_wdata;
  logic [PARA_DATA_WD:0]              w_wfifo_rdata;
  logic                               w_wfifo_write_valid;
  logic                               w_wfifo_read_valid;
  logic                               w_wfifo_full;
  logic                               w_wfifo_empty;
  logic                               w_wfifo_we;
  logic                               w_wfifo_re;

  logic [PARA_ADDR_WD+PARA_ID_WD:0]   w_arfifo_wdata;
  logic [PARA_ADDR_WD+PARA_ID_WD:0]   w_arfifo_rdata;
  logic                               w_arfifo_write_valid;
  logic                               w_arfifo_read_valid;
  logic                               w_arfifo_full;
  logic                               w_arfifo_empty;
  logic                               w_arfifo_we;
  logic                               w_arfifo_re;

  logic [PARA_DATA_WD+PARA_ID_WD+2:0] w_rfifo_wdata;
  logic [PARA_DATA_WD+PARA_ID_WD+2:0] w_rfifo_rdata;
  logic                               w_rfifo_write_valid;
  logic                               w_rfifo_read_valid;
  logic                               w_rfifo_full;
  logic                               w_rfifo_empty;
  logic                               w_rfifo_we;
  logic                               w_rfifo_re;

  logic [PARA_ID_WD+1:0]              w_bfifo_wdata;
  logic [PARA_ID_WD+1:0]              w_bfifo_rdata;
  logic                               w_bfifo_write_valid;
  logic                               w_bfifo_read_valid;
  logic                               w_bfifo_full;
  logic                               w_bfifo_empty;
  logic                               w_bfifo_we;
  logic                               w_bfifo_re;

  logic                               w_req_write;
  logic                               w_req_read;
  logic                               w_arb_sel;
  logic                               w_arb_write_en;

  assign w_awfifo_full  = ~w_awfifo_write_valid;
  assign w_awfifo_empty = ~w_awfifo_read_valid;
  assign w_wfifo_full   = ~w_wfifo_write_valid;
  assign w_wfifo_empty  = ~w_wfifo_read_valid;
  assign w_arfifo_full  = ~w_arfifo_write_valid;
  assign w_arfifo_empty = ~w_arfifo_read_valid;
  assign w_rfifo_full   = ~w_rfifo_write_valid;
  assign w_rfifo_empty  = ~w_rfifo_read_valid;
  assign w_bfifo_full   = ~w_bfifo_write_valid;
  assign w_bfifo_empty  = ~w_bfifo_read_valid;

  m_vlsi_axfsm #(
    .PARA_ADDR_WD (PARA_ADDR_WD),
    .PARA_ID_WD   (PARA_ID_WD),
    .PARA_DATA_WD (PARA_DATA_WD),
    .PARA_LEN_WD  (PARA_LEN_WD)
  ) u_axfsm_wr (
    .i_clk          (i_clk),
    .i_rst_n        (i_rst_n),
    .i_axaddr       (i_awaddr),
    .i_axvalid      (i_awvalid),
    .o_axready      (o_awready),
    .i_axburst      (i_awburst),
    .i_axlen        (i_awlen),
    .i_axid         (i_awid),
    .i_fifo_not_full(~w_awfifo_full),
    .o_axaddr_out   (w_axaddr_wr),
    .o_push_fifo    (w_aw_push),
    .o_id           (w_aw_id),
    .o_last         (w_aw_last)
  );

  m_vlsi_axfsm #(
    .PARA_ADDR_WD (PARA_ADDR_WD),
    .PARA_ID_WD   (PARA_ID_WD),
    .PARA_DATA_WD (PARA_DATA_WD),
    .PARA_LEN_WD  (PARA_LEN_WD)
  ) u_axfsm_rd (
    .i_clk          (i_clk),
    .i_rst_n        (i_rst_n),
    .i_axaddr       (i_araddr),
    .i_axvalid      (i_arvalid),
    .o_axready      (o_arready),
    .i_axburst      (i_arburst),
    .i_axlen        (i_arlen),
    .i_axid         (i_arid),
    .i_fifo_not_full(~w_arfifo_full),
    .o_axaddr_out   (w_axaddr_rd),
    .o_push_fifo    (w_ar_push),
    .o_id           (w_ar_id),
    .o_last         (w_ar_last)
  );

  m_vlsi_axi_bus_logic #(
    .PARA_DATA_WD (PARA_DATA_WD),
    .PARA_ADDR_WD (PARA_ADDR_WD),
    .PARA_ID_WD   (PARA_ID_WD)
  ) u_axi_bus_logic (
    // .i_clk         (i_clk),
    // .i_rst_n       (i_rst_n),
    .i_axaddr_wr   (w_axaddr_wr),
    .i_id_wr       (w_aw_id),
    .i_awlast_wr   (w_aw_last),
    .i_aw_push     (w_aw_push),
    .i_axaddr_rd   (w_axaddr_rd),
    .i_id_rd       (w_ar_id),
    .i_arlast      (w_ar_last),
    .i_ar_push     (w_ar_push),
    .i_wdata       (i_wdata),
    .i_wvalid      (i_wvalid),
    .i_wlast       (i_wlast),
    .i_rready      (i_rready),
    .i_bready      (i_bready),
    .i_awfifo_full (w_awfifo_full),
    .i_wfifo_full  (w_wfifo_full),
    .i_arfifo_full (w_arfifo_full),
    .i_rfifo_rdata (w_rfifo_rdata),
    .i_rfifo_empty (w_rfifo_empty),
    .i_bfifo_rdata (w_bfifo_rdata),
    .i_bfifo_empty (w_bfifo_empty),
    .o_awfifo_wdata(w_awfifo_wdata),
    .o_awfifo_we   (w_awfifo_we),
    .o_wfifo_wdata (w_wfifo_wdata),
    .o_wfifo_we    (w_wfifo_we),
    .o_arfifo_wdata(w_arfifo_wdata),
    .o_arfifo_we   (w_arfifo_we),
    .o_rfifo_re    (w_rfifo_re),
    .o_bfifo_re    (w_bfifo_re),
    .o_rid         (o_rid),
    .o_rdata       (o_rdata),
    .o_rresp       (o_rresp),
    .o_rvalid      (o_rvalid),
    .o_rlast       (o_rlast),
    .o_bid         (o_bid),
    .o_bresp       (o_bresp),
    .o_bvalid      (o_bvalid),
    .o_wready      (o_wready)
  );

  m_vlsi_async_fifo #(
    .PARA_DATA_WD (PARA_ADDR_WD + PARA_ID_WD + 1),
    .PARA_DEPTH   (PARA_FIFO_DEPTH)
  ) u_awfifo (
    .i_wr_clk (i_clk),
    .i_wr_rstn(i_rst_n),
    .i_wdata  (w_awfifo_wdata),
    .i_we     (w_awfifo_we),
    .o_write_valid(w_awfifo_write_valid),
    .i_rd_clk (i_sclk),
    .i_rd_rstn(i_slck_rst_n),
    .o_rdata  (w_awfifo_rdata),
    .i_re     (w_awfifo_re),
    .o_read_valid(w_awfifo_read_valid)
  );

  m_vlsi_async_fifo #(
    .PARA_DATA_WD (PARA_DATA_WD + 1),
    .PARA_DEPTH   (PARA_FIFO_DEPTH)
  ) u_wfifo (
    .i_wr_clk (i_clk),
    .i_wr_rstn(i_rst_n),
    .i_wdata  (w_wfifo_wdata),
    .i_we     (w_wfifo_we),
    .o_write_valid(w_wfifo_write_valid),
    .i_rd_clk (i_sclk),
    .i_rd_rstn(i_slck_rst_n),
    .o_rdata  (w_wfifo_rdata),
    .i_re     (w_wfifo_re),
    .o_read_valid(w_wfifo_read_valid)
  );

  m_vlsi_async_fifo #(
    .PARA_DATA_WD (PARA_ADDR_WD + PARA_ID_WD + 1),
    .PARA_DEPTH   (PARA_FIFO_DEPTH)
  ) u_arfifo (
    .i_wr_clk (i_clk),
    .i_wr_rstn(i_rst_n),
    .i_wdata  (w_arfifo_wdata),
    .i_we     (w_arfifo_we),
    .o_write_valid(w_arfifo_write_valid),
    .i_rd_clk (i_sclk),
    .i_rd_rstn(i_slck_rst_n),
    .o_rdata  (w_arfifo_rdata),
    .i_re     (w_arfifo_re),
    .o_read_valid(w_arfifo_read_valid)
  );

  m_vlsi_async_fifo #(
    .PARA_DATA_WD (PARA_DATA_WD + PARA_ID_WD + 3),
    .PARA_DEPTH   (PARA_FIFO_DEPTH)
  ) u_rfifo (
    .i_wr_clk (i_sclk),
    .i_wr_rstn(i_slck_rst_n),
    .i_wdata  (w_rfifo_wdata),
    .i_we     (w_rfifo_we),
    .o_write_valid(w_rfifo_write_valid),
    .i_rd_clk (i_clk),
    .i_rd_rstn(i_rst_n),
    .o_rdata  (w_rfifo_rdata),
    .i_re     (w_rfifo_re),
    .o_read_valid(w_rfifo_read_valid)
  );

  m_vlsi_async_fifo #(
    .PARA_DATA_WD (PARA_ID_WD + 2),
    .PARA_DEPTH   (PARA_FIFO_DEPTH)
  ) u_bfifo (
    .i_wr_clk (i_sclk),
    .i_wr_rstn(i_slck_rst_n),
    .i_wdata  (w_bfifo_wdata),
    .i_we     (w_bfifo_we),
    .o_write_valid(w_bfifo_write_valid),
    .i_rd_clk (i_clk),
    .i_rd_rstn(i_rst_n),
    .o_rdata  (w_bfifo_rdata),
    .i_re     (w_bfifo_re),
    .o_read_valid(w_bfifo_read_valid)
  );

  m_vlsi_arbiter u_arbiter (
    .i_clk         (i_sclk),
    .i_rst_n       (i_slck_rst_n),
    .i_req_write   (w_req_write),
    .i_req_read    (w_req_read),
    .o_arb_sel     (w_arb_sel),
    .o_arb_write_en(w_arb_write_en)
  );

  m_vlsi_axi_sclk_logic #(
    .PARA_DATA_WD (PARA_DATA_WD),
    .PARA_ADDR_WD (PARA_ADDR_WD),
    .PARA_ID_WD   (PARA_ID_WD)
  ) u_axi_sclk_logic (
    .i_sclk         (i_sclk),
    .i_rst_n        (i_slck_rst_n),
    .i_awfifo_rdata (w_awfifo_rdata),
    .i_awfifo_empty (w_awfifo_empty),
    .i_wfifo_rdata  (w_wfifo_rdata),
    .i_wfifo_empty  (w_wfifo_empty),
    .i_arfifo_rdata (w_arfifo_rdata),
    .i_arfifo_empty (w_arfifo_empty),
    .i_rfifo_full   (w_rfifo_full),
    .i_bfifo_full   (w_bfifo_full),
    .i_sram_rdata   (i_sram_rdata),
    .i_sram_read_valid(i_sram_read_valid),
    .i_sram_write_valid(i_sram_write_valid),
    .i_arb_sel      (w_arb_sel),
    .i_arb_write_en (w_arb_write_en),
    .o_req_write    (w_req_write),
    .o_req_read     (w_req_read),
    .o_awfifo_re    (w_awfifo_re),
    .o_wfifo_re     (w_wfifo_re),
    .o_arfifo_re    (w_arfifo_re),
    .o_rfifo_wdata  (w_rfifo_wdata),
    .o_rfifo_we     (w_rfifo_we),
    .o_bfifo_wdata  (w_bfifo_wdata),
    .o_bfifo_we     (w_bfifo_we),
    .o_sram_addr    (o_sram_addr),
    .o_sram_wdata   (o_sram_wdata),
    .o_sram_we      (o_sram_we),
    .o_sram_oe      (o_sram_oe)
  );

endmodule : m_vlsi_axi4_sram
