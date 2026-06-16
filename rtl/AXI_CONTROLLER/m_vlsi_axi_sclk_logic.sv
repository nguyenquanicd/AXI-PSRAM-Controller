`timescale 1ns / 1ps
//--------------------------------------
// Project: AXI4 SRAM Controller
// Module : m_vlsi_axi_sclk_logic
// Function:
//   Memory/QSPI-side logic in i_sclk domain. Arbitrates read/write
//   requests, drives target-side interface, and pushes responses into
//   async FIFOs back to AXI clock domain.
// Author: ltthinh
// Page: VLSI Technology
//--------------------------------------

module m_vlsi_axi_sclk_logic #(
  parameter int PARA_DATA_WD = 32,
  parameter int PARA_ADDR_WD = 32,
  parameter int PARA_ID_WD   = 4
) (
  input  logic                               i_sclk,
  input  logic                               i_rst_n,
  input  logic [PARA_ADDR_WD+PARA_ID_WD:0]   i_awfifo_rdata,
  input  logic                               i_awfifo_empty,
  input  logic [PARA_DATA_WD:0]              i_wfifo_rdata,
  input  logic                               i_wfifo_empty,
  input  logic [PARA_ADDR_WD+PARA_ID_WD:0]   i_arfifo_rdata,
  input  logic                               i_arfifo_empty,
  input  logic                               i_rfifo_full,
  input  logic                               i_bfifo_full,
  input  logic [PARA_DATA_WD-1:0]            i_sram_rdata,
  input  logic                               i_sram_read_valid,
  input  logic                               i_sram_write_valid,
  input  logic                               i_arb_sel,
  input  logic                               i_arb_write_en,
  output logic                               o_req_write,
  output logic                               o_req_read,
  output logic                               o_awfifo_re,
  output logic                               o_wfifo_re,
  output logic                               o_arfifo_re,
  output logic [PARA_DATA_WD+PARA_ID_WD+2:0] o_rfifo_wdata,
  output logic                               o_rfifo_we,
  output logic [PARA_ID_WD+1:0]              o_bfifo_wdata,
  output logic                               o_bfifo_we,
  output logic [PARA_ADDR_WD-1:0]            o_sram_addr,
  output logic [PARA_DATA_WD-1:0]            o_sram_wdata,
  output logic                               o_sram_we,
  output logic                               o_sram_oe
);

  logic                      reg_rd_pending;
  logic [PARA_ID_WD-1:0]     reg_rd_id;
  logic                      reg_rd_last;
  logic                      reg_wr_err;

  logic                      w_aw_last;
  logic [PARA_ID_WD-1:0]     w_aw_id;
  logic [PARA_ADDR_WD-1:0]   w_aw_addr;
  logic                      w_w_last;
  logic [PARA_DATA_WD-1:0]   w_w_data;
  logic                      w_ar_last;
  logic [PARA_ID_WD-1:0]     w_ar_id;
  logic [PARA_ADDR_WD-1:0]   w_ar_addr;

  logic                      w_write_issue;
  logic                      w_read_issue;
  logic                      w_read_complete;
  logic [1:0]                w_bresp;

  assign w_aw_last = i_awfifo_rdata[PARA_ADDR_WD+PARA_ID_WD];
  assign w_aw_id   = i_awfifo_rdata[PARA_ADDR_WD+PARA_ID_WD-1:PARA_ADDR_WD];
  assign w_aw_addr = i_awfifo_rdata[PARA_ADDR_WD-1:0];

  assign w_w_last  = i_wfifo_rdata[PARA_DATA_WD];
  assign w_w_data  = i_wfifo_rdata[PARA_DATA_WD-1:0];

  assign w_ar_last = i_arfifo_rdata[PARA_ADDR_WD+PARA_ID_WD];
  assign w_ar_id   = i_arfifo_rdata[PARA_ADDR_WD+PARA_ID_WD-1:PARA_ADDR_WD];
  assign w_ar_addr = i_arfifo_rdata[PARA_ADDR_WD-1:0];

  assign o_req_write = ~i_awfifo_empty & ~i_wfifo_empty
                       & (~w_aw_last | ~i_bfifo_full);
  assign o_req_read  = ~i_arfifo_empty & ~reg_rd_pending & ~i_rfifo_full;

  assign w_write_issue   = i_arb_write_en & i_sram_write_valid & o_req_write;
  assign w_read_issue    = i_arb_sel & ~i_arb_write_en & o_req_read & i_sram_write_valid;
  assign w_read_complete = reg_rd_pending & i_sram_read_valid & ~i_rfifo_full;

  assign o_awfifo_re = w_write_issue;
  assign o_wfifo_re  = w_write_issue;
  assign o_arfifo_re = w_read_issue;

  assign o_sram_addr  = i_arb_write_en ? w_aw_addr : w_ar_addr;
  assign o_sram_wdata = w_w_data;
  assign o_sram_we    = w_write_issue;
  assign o_sram_oe    = w_read_issue;

  assign w_bresp      = (reg_wr_err | (w_aw_last ^ w_w_last)) ? 2'b10 : 2'b00;
  assign o_bfifo_wdata = {w_aw_id, w_bresp};
  assign o_bfifo_we    = w_write_issue & w_aw_last & ~i_bfifo_full;

  assign o_rfifo_wdata = {reg_rd_id, 2'b00, i_sram_rdata, reg_rd_last};
  assign o_rfifo_we    = w_read_complete;

  always_ff @(posedge i_sclk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      reg_rd_pending <= 1'b0;
      reg_rd_id      <= '0;
      reg_rd_last    <= 1'b0;
      reg_wr_err     <= 1'b0;
    end else begin
      if (w_read_issue) begin
        reg_rd_pending <= 1'b1;
        reg_rd_id      <= w_ar_id;
        reg_rd_last    <= w_ar_last;
      end else if (w_read_complete) begin
        reg_rd_pending <= 1'b0;
      end

      if (w_write_issue) begin
        if (w_aw_last) begin
          reg_wr_err <= 1'b0;
        end else if (w_aw_last ^ w_w_last) begin
          reg_wr_err <= 1'b1;
        end
      end
    end
  end

endmodule : m_vlsi_axi_sclk_logic
