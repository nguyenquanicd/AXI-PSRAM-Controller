`timescale 1ns / 1ps
//--------------------------------------
// Project: AXI4 SRAM Controller
// Module : m_vlsi_axfsm
// Function:
//   AXI address channel FSM used by both AW and AR channels.
// Author: ltthinh
// Page: VLSI Technology
//--------------------------------------

module m_vlsi_axfsm #(
  parameter int PARA_ADDR_WD = 32,
  parameter int PARA_ID_WD   = 4,
  parameter int PARA_DATA_WD = 32,
  parameter int PARA_LEN_WD  = 8
) (
  input  logic                    i_clk,
  input  logic                    i_rst_n,
  input  logic [PARA_ADDR_WD-1:0] i_axaddr,
  input  logic                    i_axvalid,
  output logic                    o_axready,
  input  logic [1:0]              i_axburst,
  input  logic [PARA_LEN_WD-1:0]  i_axlen,
  input  logic [PARA_ID_WD-1:0]   i_axid,
  input  logic                    i_fifo_not_full,
  output logic [PARA_ADDR_WD-1:0] o_axaddr_out,
  output logic                    o_push_fifo,
  output logic [PARA_ID_WD-1:0]   o_id,
  output logic                    o_last
);

  localparam logic S_IDLE = 1'b0;
  localparam logic S_ADDR = 1'b1;
  localparam int   PARA_BEAT_BYTES = PARA_DATA_WD / 8;

  logic                   reg_state;
  logic [PARA_LEN_WD-1:0] reg_cnt_addr;
  logic [1:0]             reg_axburst;
  logic [PARA_LEN_WD-1:0] reg_axlen;
  logic [PARA_ADDR_WD-1:0] reg_axaddr;
  logic [PARA_ID_WD-1:0]  reg_id;

  logic                   w_hs;
  logic                   w_cnt_addr_done;
  logic                   w_beat_fire;
  logic                   w_nxt_state;

  logic [PARA_ADDR_WD-1:0] w_addr_fixed;
  logic [PARA_ADDR_WD-1:0] w_addr_incr;
  logic [PARA_ADDR_WD-1:0] w_addr_wrap;
  logic [PARA_ADDR_WD-1:0] w_addr_calc;
  logic [PARA_ADDR_WD-1:0] w_wrap_mask;
  logic [PARA_ADDR_WD-1:0] w_wrap_next;
  logic [PARA_ADDR_WD-1:0] w_wrap_base;
  logic [PARA_ADDR_WD-1:0] w_wrap_bytes;

  assign o_axready       = (reg_state == S_IDLE) & i_fifo_not_full;
  assign w_hs            = i_axvalid & o_axready;
  assign w_cnt_addr_done = (reg_cnt_addr == '0);
  assign w_beat_fire     = (reg_state == S_ADDR) & ~w_cnt_addr_done & i_fifo_not_full;

  always_comb begin
    case (reg_state)
      S_IDLE: w_nxt_state = w_hs ? S_ADDR : S_IDLE;
      S_ADDR: w_nxt_state = w_cnt_addr_done ? S_IDLE : S_ADDR;
      default: w_nxt_state = S_IDLE;
    endcase
  end

  always_ff @(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
      reg_state    <= S_IDLE;
      reg_cnt_addr <= '0;
      reg_axburst  <= 2'b01;
      reg_axlen    <= '0;
      reg_axaddr   <= '0;
      reg_id       <= '0;
    end else begin
      reg_state <= w_nxt_state;

      if (w_hs) begin
        reg_cnt_addr <= i_axlen + 1'b1;
        reg_axburst  <= i_axburst;
        reg_axlen    <= i_axlen;
        reg_axaddr   <= i_axaddr;
        reg_id       <= i_axid;
      end else if (w_beat_fire) begin
        reg_cnt_addr <= reg_cnt_addr - 1'b1;
        reg_axaddr   <= w_addr_calc;
      end
    end
  end

  assign w_addr_fixed = reg_axaddr;
  assign w_addr_incr  = reg_axaddr + PARA_BEAT_BYTES;
  assign w_wrap_bytes = (PARA_BEAT_BYTES * (reg_axlen + 1'b1));
  assign w_wrap_mask  = w_wrap_bytes - 1'b1;
  assign w_wrap_next  = reg_axaddr + PARA_BEAT_BYTES;
  assign w_wrap_base  = reg_axaddr & ~w_wrap_mask;
  assign w_addr_wrap  = w_wrap_base | (w_wrap_next & w_wrap_mask);

  assign w_addr_calc = (reg_axburst == 2'b00) ? w_addr_fixed :
                       (reg_axburst == 2'b01) ? w_addr_incr  :
                                                w_addr_wrap;

  assign o_axaddr_out = reg_axaddr;
  assign o_push_fifo  = w_beat_fire;
  assign o_id         = reg_id;
  assign o_last       = w_beat_fire & (reg_cnt_addr == 1);

endmodule : m_vlsi_axfsm
