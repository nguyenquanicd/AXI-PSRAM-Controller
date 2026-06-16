`timescale 1ns / 1ps
//--------------------------------------
// Project: AXI4 SRAM Controller
// Module : m_vlsi_axi_bus_logic
// Function:
//   AXI-side logic in i_clk domain. Packs requests into async FIFOs and
//   unpacks AXI R/B responses from async FIFOs.
// Author: ltthinh
// Page: VLSI Technology
//--------------------------------------

module m_vlsi_axi_bus_logic #(
  parameter int PARA_DATA_WD = 32,
  parameter int PARA_ADDR_WD = 32,
  parameter int PARA_ID_WD   = 4
) (
  // input  logic                               i_clk,
  // input  logic                               i_rst_n,
  input  logic [PARA_ADDR_WD-1:0]            i_axaddr_wr,
  input  logic [PARA_ID_WD-1:0]              i_id_wr,
  input  logic                               i_awlast_wr,
  input  logic                               i_aw_push,
  input  logic [PARA_ADDR_WD-1:0]            i_axaddr_rd,
  input  logic [PARA_ID_WD-1:0]              i_id_rd,
  input  logic                               i_arlast,
  input  logic                               i_ar_push,
  input  logic [PARA_DATA_WD-1:0]            i_wdata,
  input  logic                               i_wvalid,
  input  logic                               i_wlast,
  input  logic                               i_rready,
  input  logic                               i_bready,
  input  logic                               i_awfifo_full,
  input  logic                               i_wfifo_full,
  input  logic                               i_arfifo_full,
  input  logic [PARA_DATA_WD+PARA_ID_WD+2:0] i_rfifo_rdata,
  input  logic                               i_rfifo_empty,
  input  logic [PARA_ID_WD+1:0]              i_bfifo_rdata,
  input  logic                               i_bfifo_empty,
  output logic [PARA_ADDR_WD+PARA_ID_WD:0]   o_awfifo_wdata,
  output logic                               o_awfifo_we,
  output logic [PARA_DATA_WD:0]              o_wfifo_wdata,
  output logic                               o_wfifo_we,
  output logic [PARA_ADDR_WD+PARA_ID_WD:0]   o_arfifo_wdata,
  output logic                               o_arfifo_we,
  output logic                               o_rfifo_re,
  output logic                               o_bfifo_re,
  output logic [PARA_ID_WD-1:0]              o_rid,
  output logic [PARA_DATA_WD-1:0]            o_rdata,
  output logic [1:0]                         o_rresp,
  output logic                               o_rvalid,
  output logic                               o_rlast,
  output logic [PARA_ID_WD-1:0]              o_bid,
  output logic [1:0]                         o_bresp,
  output logic                               o_bvalid,
  output logic                               o_wready
);

  assign o_awfifo_wdata = {i_awlast_wr, i_id_wr, i_axaddr_wr};
  assign o_awfifo_we    = i_aw_push & ~i_awfifo_full;

  assign o_arfifo_wdata = {i_arlast, i_id_rd, i_axaddr_rd};
  assign o_arfifo_we    = i_ar_push & ~i_arfifo_full;

  assign o_wready       = ~i_wfifo_full;
  assign o_wfifo_wdata  = {i_wlast, i_wdata};
  assign o_wfifo_we     = i_wvalid & o_wready;

  assign o_rfifo_re     = i_rready & ~i_rfifo_empty;
  assign o_bfifo_re     = i_bready & ~i_bfifo_empty;

  assign o_rid          = i_rfifo_rdata[PARA_DATA_WD+PARA_ID_WD+2:PARA_DATA_WD+3];
  assign o_rresp        = i_rfifo_rdata[PARA_DATA_WD+2:PARA_DATA_WD+1];
  assign o_rdata        = i_rfifo_rdata[PARA_DATA_WD:1];
  assign o_rlast        = i_rfifo_rdata[0];
  assign o_rvalid       = ~i_rfifo_empty;

  assign o_bid          = i_bfifo_rdata[PARA_ID_WD+1:2];
  assign o_bresp        = i_bfifo_rdata[1:0];
  assign o_bvalid       = ~i_bfifo_empty;

endmodule : m_vlsi_axi_bus_logic
