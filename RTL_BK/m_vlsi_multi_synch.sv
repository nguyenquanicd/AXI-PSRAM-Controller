`timescale 1ns / 1ps
module m_vlsi_multi_synch #(
  parameter int PARA_WD    = 1,
  parameter int PARA_LEVELS = 2
)(
  input  logic                 i_clk,
  input  logic                 i_rstn,
  input  logic [PARA_WD-1:0]   i_data_in,
  output logic [PARA_WD-1:0]   o_data_out
);
  generate
    for (int i = 0; i < PARA_WD; i = i + 1) begin: sync_multi
        m_vlsi_synch #(
        .PARA_LEVELS (PARA_LEVELS)
      ) u_wval_sync (
        .i_clk (i_clk),
        .i_rstn (i_rstn),
        .i_data_in (i_data_in[i]),
        .o_data_out (o_data_out[i])
      );
    end
  endgenerate

endmodule: m_vlsi_multi_synch