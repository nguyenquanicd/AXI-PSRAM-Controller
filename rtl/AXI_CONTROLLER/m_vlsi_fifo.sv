`timescale 1ns / 1ps
//--------------------------------------
// Project: AXI4 SRAM Controller
// Module : m_vlsi_fifo
// Function:
//   Asynchronous FIFO used for crossing between AXI bus clock domain
//   and QSPI/SRAM clock domain.
// Author: ltthinh
// Page: VLSI Technology
//--------------------------------------

module m_vlsi_fifo #(
  parameter int PARA_DATA_WD = 32,
  parameter int PARA_DEPTH   = 8
) (
  input  logic                    i_wr_clk,
  input  logic                    i_wr_rstn,
  input  logic [PARA_DATA_WD-1:0] i_wdata,
  input  logic                    i_we,
  output logic                    o_full,

  input  logic                    i_rd_clk,
  input  logic                    i_rd_rstn,
  output logic [PARA_DATA_WD-1:0] o_rdata,
  input  logic                    i_re,
  output logic                    o_empty
);

  localparam int PARA_ADDR_WD = (PARA_DEPTH <= 2) ? 1 : $clog2(PARA_DEPTH);

  logic [PARA_DATA_WD-1:0] reg_mem [0:PARA_DEPTH-1];

  logic [PARA_ADDR_WD:0]   reg_wr_ptr_bin;
  logic [PARA_ADDR_WD:0]   reg_wr_ptr_gray;
  logic [PARA_ADDR_WD:0]   reg_rd_ptr_bin;
  logic [PARA_ADDR_WD:0]   reg_rd_ptr_gray;

  logic [PARA_ADDR_WD:0]   w_wr_ptr_bin_nxt;
  logic [PARA_ADDR_WD:0]   w_wr_ptr_gray_nxt;
  logic [PARA_ADDR_WD:0]   w_rd_ptr_bin_nxt;
  logic [PARA_ADDR_WD:0]   w_rd_ptr_gray_nxt;

  logic [PARA_ADDR_WD:0]   w_rd_ptr_gray_wr_clk;
  logic [PARA_ADDR_WD:0]   w_wr_ptr_gray_rd_clk;

  logic                    w_push;
  logic                    w_pop;

  function automatic logic [PARA_ADDR_WD:0] f_bin2gray(
    input logic [PARA_ADDR_WD:0] i_bin
  );
    f_bin2gray = (i_bin >> 1) ^ i_bin;
  endfunction

  assign w_push = i_we & ~o_full;
  assign w_pop  = i_re & ~o_empty;

  assign w_wr_ptr_bin_nxt  = reg_wr_ptr_bin + w_push;
  assign w_wr_ptr_gray_nxt = f_bin2gray(w_wr_ptr_bin_nxt);
  assign w_rd_ptr_bin_nxt  = reg_rd_ptr_bin + w_pop;
  assign w_rd_ptr_gray_nxt = f_bin2gray(w_rd_ptr_bin_nxt);

  always_ff @(posedge i_wr_clk or negedge i_wr_rstn) begin
    if (!i_wr_rstn) begin
      reg_wr_ptr_bin  <= '0;
      reg_wr_ptr_gray <= '0;
    end else begin
      reg_wr_ptr_bin  <= w_wr_ptr_bin_nxt;
      reg_wr_ptr_gray <= w_wr_ptr_gray_nxt;
      if (w_push) begin
        reg_mem[reg_wr_ptr_bin[PARA_ADDR_WD-1:0]] <= i_wdata;
      end
    end
  end

  always_ff @(posedge i_rd_clk or negedge i_rd_rstn) begin
    if (!i_rd_rstn) begin
      reg_rd_ptr_bin  <= '0;
      reg_rd_ptr_gray <= '0;
    end else begin
      reg_rd_ptr_bin  <= w_rd_ptr_bin_nxt;
      reg_rd_ptr_gray <= w_rd_ptr_gray_nxt;
    end
  end

  m_vlsi_multi_synch #(
    .PARA_WD     (PARA_ADDR_WD + 1),
    .PARA_LEVELS (2)
  ) u_rd_ptr_sync (
    .i_clk      (i_wr_clk),
    .i_rstn     (i_wr_rstn),
    .i_data_in  (reg_rd_ptr_gray),
    .o_data_out (w_rd_ptr_gray_wr_clk)
  );

  m_vlsi_multi_synch #(
    .PARA_WD     (PARA_ADDR_WD + 1),
    .PARA_LEVELS (2)
  ) u_wr_ptr_sync (
    .i_clk      (i_rd_clk),
    .i_rstn     (i_rd_rstn),
    .i_data_in  (reg_wr_ptr_gray),
    .o_data_out (w_wr_ptr_gray_rd_clk)
  );

  assign o_full = (w_wr_ptr_gray_nxt
                   == {~w_rd_ptr_gray_wr_clk[PARA_ADDR_WD:PARA_ADDR_WD-1],
                       w_rd_ptr_gray_wr_clk[PARA_ADDR_WD-2:0]});

  assign o_empty = (reg_rd_ptr_gray == w_wr_ptr_gray_rd_clk);
  assign o_rdata = reg_mem[reg_rd_ptr_bin[PARA_ADDR_WD-1:0]];

endmodule : m_vlsi_fifo
