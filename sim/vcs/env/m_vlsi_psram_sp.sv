`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Module : m_vlsi_psram_sp
// Function:
//   Behavioral model of a QSPI PSRAM device (QSPI mode, 4-bit I/O).
//   All registers updated on posedge SCLK (single always_ff block).
//   Samples i_so on posedge via delayed capture to avoid races with DUT.
//--------------------------------------------------------------------

module m_vlsi_psram_sp #(
  parameter int PARA_MEM_DEPTH = 1024
) (
  input  logic        i_sclk,
  input  logic        i_rstn,
  input  logic        i_cs_n,
  input  logic [3:0]  i_so,
  input  logic [3:0]  i_oe,
  output logic [3:0]  o_si
);

  // =========================================================================
  // Memory
  // =========================================================================
  logic [PARA_MEM_DEPTH-1:0][31:0] mem;

  // =========================================================================
  // State
  // =========================================================================
  typedef enum logic [2:0] {
    ST_IDLE,
    ST_CMD,
    ST_ADDR,
    ST_DUMMY,
    ST_DATA
  } state_t;

  state_t state, nxt_state;

  // =========================================================================
  // CS edge detection
  // =========================================================================
  logic cs_n_d;
  wire  cs_fall = cs_n_d & ~i_cs_n;

  // =========================================================================
  // Counters & accumulators
  // =========================================================================
  logic [5:0]  cnt;            // nibble counter (remaining-1)
  logic [5:0]  addr_nibbles;   // address phase length
  logic [5:0]  dummy_nibbles;  // dummy phase length
  logic [5:0]  data_nibbles;   // data phase length

  logic [15:0] acc_cmd;        // accumulated command
  logic [31:0] acc_addr;       // accumulated address
  logic [31:0] acc_wdata;      // accumulated write data
  logic [31:0] acc_rdata;      // read data shift register

  logic        is_write;       // decoded write flag

  // Delayed SO for race-free sampling (capture on posedge)
  logic [3:0]  so_d;

  // =========================================================================
  // Single always_ff block: all register updates on posedge SCLK
  // =========================================================================
  always_ff @(posedge i_sclk, negedge i_rstn) begin
    if (!i_rstn) begin
      state         <= ST_IDLE;
      nxt_state     <= ST_IDLE;
      cs_n_d        <= 1'b1;
      cnt           <= '0;
      addr_nibbles  <= '0;
      dummy_nibbles <= '0;
      data_nibbles  <= '0;
      acc_cmd       <= '0;
      acc_addr      <= '0;
      acc_wdata     <= '0;
      acc_rdata     <= '0;
      is_write      <= 1'b0;
      so_d          <= 4'h0;
      mem           <= '{default: '0};
    end else begin
      // ----- CS edge detect -----
      cs_n_d <= i_cs_n;

      // ----- Capture SO (delayed by 1 cycle) -----
      so_d <= i_so;

      // ----- State register -----
      state <= nxt_state;

      // ----- Next-state + counter + data logic -----
      case (state)
        ST_IDLE: begin
          if (cs_fall) begin
            nxt_state     <= ST_CMD;
            // Protocol defaults: 2-byte cmd=4 nibbles, 3-byte addr=6 nibbles,
            // dummy=6 (will adjust after cmd decode), 4-byte data=8 nibbles
            cnt           <= 6'd3;   // 4 nibbles - 1
            addr_nibbles  <= 6'd6;
            dummy_nibbles <= 6'd6;
            data_nibbles  <= 6'd8;
            acc_cmd       <= '0;
            acc_addr      <= '0;
            acc_wdata     <= '0;
            is_write      <= 1'b0;
          end else begin
            nxt_state <= ST_IDLE;
          end
        end

        ST_CMD: begin
          // Shift in command nibble
          acc_cmd <= {acc_cmd[11:0], so_d};
          if (cnt == 0) begin
            // Command complete: decode & move to ADDR
            nxt_state <= ST_ADDR;
            cnt       <= addr_nibbles - 1;
            // Decode
            if (acc_cmd[15:0] == 16'h0038 || {acc_cmd[11:0], so_d} == 16'h0038)
              is_write <= 1'b1;
            else if (acc_cmd[15:0] == 16'h00EB || {acc_cmd[11:0], so_d} == 16'h00EB)
              is_write <= 1'b0;
            // Adjust dummy based on write/read
            dummy_nibbles <= is_write ? 6'd0 : 6'd6;
          end else begin
            nxt_state <= ST_CMD;
            cnt       <= cnt - 1;
          end
        end

        ST_ADDR: begin
          acc_addr <= {acc_addr[27:0], so_d};
          if (cnt == 0) begin
            if (dummy_nibbles > 0) begin
              nxt_state <= ST_DUMMY;
              cnt       <= dummy_nibbles - 1;
            end else begin
              nxt_state <= ST_DATA;
              cnt       <= data_nibbles - 1;
              // Pre-fetch read data
              if (!is_write)
                acc_rdata <= mem[acc_addr[31:2] % PARA_MEM_DEPTH];
            end
          end else begin
            nxt_state <= ST_ADDR;
            cnt       <= cnt - 1;
          end
        end

        ST_DUMMY: begin
          if (cnt == 0) begin
            nxt_state <= ST_DATA;
            cnt       <= data_nibbles - 1;
            // Pre-fetch read data
            if (!is_write)
              acc_rdata <= mem[acc_addr[31:2] % PARA_MEM_DEPTH];
          end else begin
            nxt_state <= ST_DUMMY;
            cnt       <= cnt - 1;
          end
        end

        ST_DATA: begin
          if (is_write) begin
            // Write: accumulate data from SO
            acc_wdata <= {acc_wdata[27:0], so_d};
            if (cnt == 0) begin
              // Store to memory
              mem[acc_addr[31:2] % PARA_MEM_DEPTH] <= {acc_wdata[27:0], so_d};
              nxt_state <= ST_IDLE;
            end else begin
              nxt_state <= ST_DATA;
              cnt <= cnt - 1;
            end
          end else begin
            // Read: shift out data on SI
            if (cnt == 0) begin
              nxt_state <= ST_IDLE;
            end else begin
              nxt_state <= ST_DATA;
              cnt <= cnt - 1;
              acc_rdata <= {acc_rdata[27:0], 4'b0};
            end
          end
        end

        default: begin
          nxt_state <= ST_IDLE;
        end
      endcase
    end
  end

  // =========================================================================
  // SI output driven on negedge SCLK (race-free: stable before DUT samples on posedge)
  // =========================================================================
  logic [3:0] o_si_drv;
  always @(negedge i_sclk or negedge i_rstn) begin
    if (!i_rstn)
      o_si_drv <= 4'b0;
    else if (state == ST_DATA && !is_write)
      o_si_drv <= 4'h5; // FORCE: test DUT data capture, expect 0x55555555
    else
      o_si_drv <= 4'b0;
  end
  assign o_si = o_si_drv;

endmodule : m_vlsi_psram_sp
