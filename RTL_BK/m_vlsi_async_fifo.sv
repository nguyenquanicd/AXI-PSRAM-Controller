module m_vlsi_async_fifo #(
  parameter PARA_DATA_WD = 32,
  parameter PARA_DEPTH = 1024
  localparam PARA_CNT_WD = $clog2(PARA_DEPTH+1)
)(
  input i_wr_clk,
  input i_wr_rstn,
  input [PARA_DATA_WD-1: 0] i_wdata,
  input i_we,
  output o_full,

  input i_rd_clk,
  input i_rd_rstn,
  output [PARA_DATA_WD-1:0] o_rdata,
  input i_re,
  output o_empty 
);
  logic [PARA_DATA_WD-1:0] reg_mem [PARA_DEPTH-1:0];
  logic write_en;
  logic [PARA_CNT_WD-1:0] reg_wr_cnt;
  logic [PARA_DEPTH-1:0] reg_wval;
  logic [PARA_DEPTH-1:0] wr_comb_val;

  logic read_en;
  logic [PARA_CNT_WD-1:0] reg_rd_cnt;
  logic [PARA_DEPTH-1:0] reg_rval;
  logic [PARA_DEPTH-1:0] rd_comb_val;

  logic [PARA_DEPTH-1:0] wval_sync;
  logic [PARA_DEPTH-1:0] rval_sync;  

  // Write Phase
  assign write_en = we & o_full;
  
  always_ff @(posedge i_wr_clk, negedge i_wr_rstn) begin
    if (!i_wr_rstn) begin
      reg_wr_cnt <= '0;
    end else if (write_en) begin
      reg_wr_cnt <= reg_wr_cnt + 1;
    end
  end

  always_ff @(posedge i_wr_clk, negedge i_wr_rstn) begin
    if (!i_wr_rstn) begin
      reg_mem <= '0;
    end else if (write_en) begin
      reg_mem[reg_wr_cnt] <= i_wdata;
    end
  end

  always_ff @(posedge i_wr_clk, negedge i_wr_rstn) begin
    if (!i_wr_rstn) begin
      reg_wval <= '0;
    end else if (write_en) begin
      reg_wval <= {reg_wval[PARA_DEPTH-2:0],~reg_wval[PARA_DEPTH-1]}; 
    end
  end

  assign wr_comb_val = wval ~^ rval_sync;
  assign o_full = wr_comb_val[reg_wr_cnt];

  // Read Phase
  assign read_en = i_re & o_empty;

  always_ff @(posedge i_rd_clk, negedge i_rd_rstn) begin
    if (!i_rd_rstn) begin
      reg_rd_cnt <= '0;
    end else if (read_en) begin
      reg_rd_cnt <= reg_rd_cnt + 1;
    end
  end

  always_ff @(posedge i_rd_clk, negedge i_rd_rstn) begin
    if (!i_rd_rstn) begin
      reg_rval <= '0;
    end else if (read_en) begin
      reg_rval <= {reg_rval[PARA_DEPTH-2:0],~reg_rval[PARA_DEPTH-1]};
    end
  end

  assign o_rdata = reg_mem[reg_rd_cnt];

  assign wr_comb_val = rval ~^ wval_sync;
  assign o_empty = rd_comb_val[reg_rd_cnt];
  
  // Sync phase
  m_vlsi_multi_synch #(
    .PARA_WD (PARA_DEPTH),
    .PARA_LEVELS (PARA_LEVELS)
  ) u_rval_sync (
    .i_clk (i_wr_clk),
    .i_rstn (i_wr_rstn),
    .i_data_in (reg_rval),
    .o_data_out (rval_sync)
  );

  m_vlsi_multi_synch #(
    .PARA_WD (PARA_DEPTH),
    .PARA_LEVELS (PARA_LEVELS)
  ) u_wval_sync (
    .i_clk (i_rd_clk),
    .i_rstn (i_rd_rstn),
    .i_data_in (reg_wval),
    .o_data_out (wval_sync)
  );

endmodule: m_vlsi_async_fifo


