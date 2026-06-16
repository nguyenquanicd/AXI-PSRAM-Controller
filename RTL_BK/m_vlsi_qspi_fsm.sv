`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller
// Module : m_vlsi_qspi_fsm
// Function:
//   QSPI transaction FSM. This block consumes AXI-side requests from
//   async FIFO outputs, uses CSR configuration from m_vlsi_qspi_csr,
//   and drives a generic QSPI pad-side interface.
//--------------------------------------------------------------------
module m_vlsi_qspi_fsm #(
  parameter int PARA_ADDR_WD = 32,
  parameter int PARA_DATA_WD = 32
)(
  input  logic                     i_sclk,
  input  logic                     i_rstn_sclk,

  //------------------------------------------------------------------
  // CSR interface
  //------------------------------------------------------------------

  input  logic                     i_csr_ctrl_cmd_2bytes,
  input  logic                     i_csr_ctrl_xip_en,
  input  logic                     i_csr_ctrl_en,

  input  logic                     i_csr_wd_req,
  output logic                     o_csr_wd_ack,
  output logic                     o_csr_hw_wdata_wd_req,
  output logic                     o_csr_hw_we_wd_req,
  input  logic [5:0]               i_csr_wd_addr,
  input  logic [23:0]              i_csr_wd_data,

  input  logic                     i_csr_read_req,
  output logic                     o_csr_read_ack,
  output logic                     o_csr_hw_wdata_read_req,
  output logic                     o_csr_hw_we_read_req,
  input  logic [15:0]              i_csr_read_cmd,

  input  logic                     i_csr_write_req,
  output logic                     o_csr_write_ack,
  output logic                     o_csr_hw_wdata_write_req,
  output logic                     o_csr_hw_we_write_req,
  input  logic [15:0]              i_csr_write_cmd,

  input  logic [3:0]               i_csr_wr_dummy_num,
  input  logic [3:0]               i_csr_rd_dummy_num,

  output logic [1:0]               o_csr_mode_status_current,

  input  logic                     i_csr_independent_req,
  output logic                     o_csr_independent_ack,
  output logic                     o_csr_hw_wdata_independent_req,
  output logic                     o_csr_hw_we_independent_req,
  input  logic [1:0]               i_csr_independent_mode,
  input  logic [15:0]              i_csr_independent_cmd,

  //------------------------------------------------------------------
  // AXI controller interface
  //------------------------------------------------------------------
  input  logic [PARA_ADDR_WD-1:0] i_ax_addr,
  input  logic [PARA_DATA_WD-1:0] i_ax_wdata,
  input  logic                    i_ax_we,
  input  logic                    i_ax_oe,
  output logic [PARA_DATA_WD-1:0] o_ax_rdata

  //------------------------------------------------------------------
  // QSPI pad-side interface
  //------------------------------------------------------------------
  output logic                     o_qspi_cs_n,
  output logic                     o_qspi_sclk,
  output logic [3:0]               o_qspi_so,
  output logic [3:0]               o_qspi_oe,
  input  logic [3:0]               i_qspi_si
);

  typedef enum logic [3:0] {
    S_IDLE,
    S_SET_UP,
    S_WAIT_TRANS,
    S_IND_CMD,
    S_CMD,
    S_ADDR,
    S_DUMMY,
    S_DATA
  } state_e;

  state_e reg_state;
  state_e nxt_state;

  logic [4:0] reg_cnt_cmd;
  logic [7:0] reg_cnt_addr;
  logic [7:0] reg_cnt_data;
  logic [4:0] reg_cnt_wr_dummy;
  logic [4:0] reg_cnt_rd_dummy;
  logic [PARA_DATA_WD-1:0] reg_data_out;
  logic [PARA_DATA_WD-1:0] reg_data_in;
  logic reg_csn;
  logic reg_in_read;
  logic reg_in_write;
  
  logic [1:0]  reg_csr_mode_status_current;
  logic [1:0]  reg_csr_mode_status_nxt;
  logic        reg_csr_ctrl_cmd_2bytes;
  logic [5:0]  reg_csr_wd_addr;
  logic [23:0] reg_csr_wd_data;
  logic [3:0]  reg_csr_wr_dummy;
  logic [3:0]  reg_csr_rd_dummy;
  logic [15:0] reg_csr_write_cmd;
  logic [15:0] reg_csr_read_cmd;
  logic [15:0] reg_csr_independent_cmd;

  // Capture FFs----------------------------------------------------------------------------------//
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_mode_status_nxt <= '0;
    end else if (reg_state == S_IND_CMD) begin
      reg_csr_mode_status_nxt <= i_csr_independent_mode;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_mode_status_current <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_mode_status_current <= reg_csr_mode_status_nxt;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_ctrl_cmd_2bytes <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_ctrl_cmd_2bytes <= i_csr_ctrl_cmd_2bytes;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_wd_addr <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_wd_addr <= i_csr_wd_addr;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_wd_data <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_wd_data <= i_csr_wd_data;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_wr_dummy <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_wr_dummy <= i_csr_wr_dummy;
    end
  end
  
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_rd_dummy <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_rd_dummy <= i_csr_rd_dummy;
    end
  end
  
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_write_cmd <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_write_cmd <= i_csr_write_cmd;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_read_cmd <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_read_cmd <= i_csr_read_cmd;
    end
  end
  
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_csr_independent_cmd <= '0;
    end else if (reg_state == S_SET_UP) begin
      reg_csr_independent_cmd <= i_csr_independent_cmd;
    end
  end
  // Capture FFs----------------------------------------------------------------------------------//

  //ACK response----------------------------------------------------------------------------------//
  assign o_csr_wd_ack = ((reg_state == S_SET_UP) & i_csr_wd_req);
  assign o_csr_hw_we_wd_req = o_csr_wd_ack;
  assign o_csr_hw_wdata_wd_req = 1'b1;

  assign o_csr_read_ack = ((reg_state == S_SET_UP) & i_csr_read_req);
  assign o_csr_hw_we_read_req = o_csr_read_ack;
  assign o_csr_hw_wdata_read_req = 1'b1;

  assign o_csr_write_ack = ((reg_state == S_SET_UP) & i_csr_write_req);
  assign o_csr_hw_we_write_req = o_csr_write_ack;
  assign o_csr_hw_wdata_write_req = 1'b1;

  assign o_csr_independent_ack = ((reg_state == S_SET_UP) & i_csr_independent_req);
  assign o_csr_hw_we_independent_req = o_csr_independent_ack;
  assign o_csr_hw_wdata_independent_req = 1'b1;
  //ACK response----------------------------------------------------------------------------------//

  //FSM-------------------------------------------------------------------------------------------//
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_state <= S_IDLE;
    end else
      reg_state <= nxt_state;
  end

  always_comb begin
    case (reg_state):
      S_IDLE: begin
        nxt_state = i_csr_ctrl_en ? S_SET_UP : S_IDLE;
      end
      S_SET_UP: begin
        nxt_state = S_WAIT_TRANS;
      end
      S_WAIT_TRANS: begin
        if (i_csr_independent_req && o_csr_independent_ack)
          nxt_state = S_IND_CMD;
        else if (i_ax_we)
          nxt_state = S_WRITE;
        else if (i_ax_oe)
          nxt_state = S_READ;
        else
          nxt_state = S_WAIT_TRANS;
      end
      S_IND_CMD: begin
        nxt_state = (reg_cnt_cmd == 0) ? S_SET_UP : S_IND_CMD;
      end
      S_WRITE: begin
        nxt_state = S_CMD;
      end
      S_READ: begin
        nxt_state = S_CMD;
      end
      S_CMD: begin
        nxt_state = (reg_cnt_cmd == 0) ? S_SET_UP : S_CMD;
      end
      S_ADDR: begin
        if (reg_in_write) begin
          if (reg_wr_dummy_num > 0)
            nxt_state = (reg_cnt_addr == 0) ? S_DUMMY : S_ADDR;
          else
            nxt_state = (reg_cnt_addr == 0) ? S_DATA : S_ADDR;
        end else begin
          if (reg_rd_dummy_num > 0)
            nxt_state = (reg_cnt_addr == 0) ? S_DUMMY : S_ADDR;
          else
            nxt_state = (reg_cnt_addr == 0) ? S_DATA : S_ADDR;
        end
      end
      S_DUMMY: begin
        nxt_state = (reg_cnt_dummy == 0) ? S_DATA : S_DUMMY;
      end
      S_DATA: begin
        nxt_state = (reg_cnt_data == 0) ? S_SET_UP : S_DATA;
      end
      default: nxt_state = S_IDLE;
    endcase
  end
  //FSM-------------------------------------------------------------------------------------------//

  // Counter and FSM register
  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_cnt_cmd <= '0;
    end else begin
      if(nxt_state == S_CMD | nxt_state == S_IND_CMD) begin
        if (reg_csr_mode_status_current == 2'd2) begin
          if (reg_csr_cmd_2bytes)
            reg_cnt_cmd <= 'd4;
          else 
            reg_cnt_cmd <= 'd0;
        end
        else if (reg_csr_mode_status_current == 2'd0) begin 
          if (reg_csr_cmd_2bytes)
            reg_cnt_cmd <= 'd16;
          else 
            reg_cnt_cmd <= 'd8;
        end
      end 
      else if (reg_state == S_CMD | reg_state == S_IND_CMD) begin
        reg_cnt_cmd <= reg_cnt_cmd - 1;
      end
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_cnt_addr <= '0;
    end else begin
      if (nxt_state == S_ADDR)
        reg_cnt_addr <= reg_csr_wd_addr;
      else if (reg_state == S_ADDR) begin
        if (reg_csr_mode_status_current == 2'd2)
          reg_cnt_addr <= reg_cnt_addr - 4;
        else if (reg_csr_mode_status_current == 2'd0)
          reg_cnt_addr <= reg_cnt_addr - 1;
      end
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_cnt_data <= '0;
    end else begin
      if (nxt_state == S_DATA)
        reg_cnt_data <= reg_csr_wd_data;
      else if (reg_state == S_DATA) begin
        if (reg_csr_mode_status_current == 2'd2)
          reg_cnt_data <= reg_cnt_data - 4;
        else if (reg_csr_mode_status_current == 2'd0)
          reg_cnt_data <= reg_cnt_data - 1;
      end
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_rstn_sclk) begin
      reg_cnt_dummy <= '0;
    end else begin
      if (nxt_state == S_DUMMY)
        reg_cnt_dummy <= (reg_ax_we) ? reg_csr_wr_dummy : reg_csr_rd_dummy;
      else if (reg_state == S_DUMMY) begin
        if (reg_csr_mode_status_current == 2'd2)
          reg_cnt_data <= reg_cnt_data - 4;
        else if (reg_csr_mode_status_current == 2'd0)
          reg_cnt_data <= reg_cnt_data - 1;
      end
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin 
    if (!i_rstn_sclk) begin
      reg_in_write <= 1'b0;
    end else begin
      if (reg_state == S_WRITE)
        reg_in_write = 1'b1;
      else if (nxt_state == S_SET_UP)
        reg_in_write <= 1'b0;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin 
    if (!i_rstn_sclk) begin
      reg_in_read <= 1'b0;
    end else begin
      if (reg_state == S_READ)
        reg_in_read = 1'b1;
      else if (nxt_state == S_SET_UP)
        reg_in_read <= 1'b0;
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin 
    if (!i_rstn_sclk) begin
      reg_csn <= 1'b0;
    end else begin
      if (nxt_state == S_CMD | nxt_state == S_IND_CMD | (reg_state == S_DATA & nxt_state == S_SET_UP))
        reg_csn = ~ reg_csn;
    end
  end
  assign o_qspi_cs_n = reg_csn;

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin 
    if (!i_rstn_sclk) begin
      reg_data_out <= '0;
    end else begin
      case (reg_state)
        S_WRITE: begin
          if (reg_csr_cmd_2bytes)
            reg_data_out <= (reg_ax_we) ? reg_csr_write_cmd : reg_csr_read_cmd;
          else
            reg_data_out <= (reg_ax_we) ? {reg_csr_write_cmd[7:0],8'd0} : {reg_csr_read_cmd[7:0],'0};
        end 
        S_WAIT_TRANS: begin
          if (nxt_state == S_IND_CMD)
            reg_data_out <= (reg_csr_cmd_2bytes) ? reg_csr_independent_cmd : {reg_csr_independent_cmd[7:0],'0};
        end
        S_CMD: begin
          if (nxt_state == S_ADDR)
            reg_data_out <= {reg_ax_addr,'0};
          else begin
            if (reg_csr_mode_status_current == 2'd2)
              reg_data_out <= reg_data_out << 4;
            else if (reg_csr_mode_status_current == 2'd0)
              reg_data_out <= reg_data_out << 1;
          end        
        end
        S_ADDR: begin
          if (nxt_state == S_DATA)
            reg_data_out <= {reg_ax_wdata,'0};
          else begin
            if (reg_csr_mode_status_current == 2'd2)
              reg_data_out <= reg_data_out << 4;
            else if (reg_csr_mode_status_current == 2'd0)
              reg_data_out <= reg_data_out << 1;
          end        
        end
        S_DUMMY: begin
          if (nxt_state == S_DATA)
            reg_data_out <= {reg_ax_wdata,'0};
          else begin
            if (reg_csr_mode_status_current == 2'd2)
              reg_data_out <= reg_data_out << 4;
            else if (reg_csr_mode_status_current == 2'd0)
              reg_data_out <= reg_data_out << 1;
          end   
        end
        S_DATA: begin
          if (reg_csr_mode_status_current == 2'd2)
            reg_data_out <= reg_data_out << 4;
          else if (reg_csr_mode_status_current == 2'd0)
            reg_data_out <= reg_data_out << 1;
        end   
        default: reg_data_out <= reg_data_out;
      endcase
    end
  end
  assign o_qspi_so = reg_data_out[PARA_DATA_WD-1:PARA_DATA_WD-3];

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_sclk) begin 
      reg_data_out <= '0;
    end
    else if (reg_ỉn_read & reg_state == S_DATA) begin
      if (reg_csr_mode_status_current == 2'd2)
        reg_data_out <= {i_qspi_si,reg_data_out[PARA_DATA_WD-1:4]};
      else if (reg_csr_mode_status_current == 2'd0)
        reg_data_out <= {i_qspi_si[1],reg_data_out[PARA_DATA_WD-1:1]};
    end
  end

  always_ff @(posedge i_sclk, negedge i_rstn_sclk) begin
    if (!i_sclk) begin 
      reg_data_out_cnt <= '0;
    end
    else if (reg_data_out_cnt == PARA_DATA_WD) begin 
      reg_data_out_cnt <= '0;
    end 
    else if (reg_ỉn_read & reg_state == S_DATA) begin
      if (reg_csr_mode_status_current == 2'd2)
        reg_data_out_cnt <= reg_data_out_cnt + 4;
      else if (reg_csr_mode_status_current == 2'd0)
        reg_data_out_cnt <= reg_data_out_cnt + 1;
    end
  end

  assign o_ax_read_valid = (reg_data_out_cnt == PARA_DATA_WD);



endmodule: m_vlsi_qspi_fsm
