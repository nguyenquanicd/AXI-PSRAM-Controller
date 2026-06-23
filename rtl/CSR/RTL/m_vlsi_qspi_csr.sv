`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: APB-CSR-Generator
// Generator: ltthinh
// Date and time: 2026-06-07 17:09:14.051989
// Module: m_vlsi_qspi_csr
// Function: Control & Status register via APB interface
// Page: VLSI Technology
//--------------------------------------------------------------------
module m_vlsi_qspi_csr # (
  localparam PARA_CTRL_OFFSET = 16'h0,
  localparam PARA_WD_OFFSET = 16'h4,
  localparam PARA_READ_OFFSET = 16'h8,
  localparam PARA_WRITE_OFFSET = 16'hC,
  localparam PARA_WR_DUMMY_OFFSET = 16'h10,
  localparam PARA_RD_DUMMY_OFFSET = 16'h14,
  localparam PARA_MODE_STATUS_OFFSET = 16'h18,
  localparam PARA_INDEPENDENT_OFFSET = 16'h1C

)(
  input i_bus_clk,
  input i_bus_rstn,
  input [15:0] i_paddr,
  input i_protect_en,
  input i_slverr_en,
  input [2:0] i_pprot,
  input [31:0] i_pwdata,
  input i_pwrite,
  input i_penable,
  input i_psel,
  input [3:0] i_pstrb,
  output o_pslverr,
  output o_pready,
  output [31:0] o_prdata,
  input i_reg_clk,
  input i_reg_rstn,
  output o_ctrl_cmd_2bytes,
  output o_ctrl_auto_data_wd,
  output o_ctrl_en,
  output o_wd_req,
  input i_hw_wdata_wd_req,
  input i_hw_we_wd_req,
  input i_wd_ack,
  output [5:0] o_wd_addr,
  output [23:0] o_wd_data,
  output o_read_reqq,
  input i_hw_wdata_read_reqq,
  input i_hw_we_read_reqq,
  input i_read_ack,
  output [15:0] o_read_cmd,
  output o_write_reqq,
  input i_hw_wdata_write_reqq,
  input i_hw_we_write_reqq,
  input i_write_ack,
  output [15:0] o_write_cmd,
  output [31:0] o_wr_dummy_num,
  output [31:0] o_rd_dummy_num,
  input [1:0] i_mode_status_current,
  output o_independent_req,
  input i_hw_wdata_independent_req,
  input i_hw_we_independent_req,
  input i_independent_ack,
  output [1:0] o_independent_mode,
  output [15:0] o_independent_cmd
);
  //Logic signal declaration
  logic apb_setup;
  logic apb_protect;
  logic apb_slverr;
  logic apb_complete;
  logic apb_write;
  logic apb_read;
  logic [15:0] reg_address;
  logic [31:0] reg_pwdata;
  logic reg_slverr;
  logic apb_read_en;
  logic apb_write_en;
  logic [31:0] nxt_prdata;
  logic reg_pready;
  logic [31:0] reg_prdata;
  logic read_ack;
  logic read_ack_bus_clk;
  logic reg_read_req;
  logic reg_read_ack_reg_clk_dly;
  logic read_aclk_bus_clk_falling;
  logic write_ack;
  logic write_ack_bus_clk;
  logic reg_write_req;
  logic reg_write_ack_reg_clk_dly;
  logic write_aclk_bus_clk_falling;
  logic read_req_reg_clk;
  logic reg_read_req_reg_clk_dly;
  logic write_req_reg_clk;
  logic reg_write_req_reg_clk_dly;
  logic reg_read_ack_bus_clk_dly;
  logic reg_write_ack_bus_clk_dly;
  logic we_ctrl;
  logic reg_ctrl_cmd_2bytes;
  logic nxt_ctrl_cmd_2bytes;
  logic reg_ctrl_auto_data_wd;
  logic nxt_ctrl_auto_data_wd;
  logic reg_ctrl_en;
  logic nxt_ctrl_en;
  logic [31:0] ctrl_value;
  logic we_wd;
  logic reg_wd_req;
  logic nxt_wd_req;
  logic [5:0] reg_wd_addr;
  logic [5:0] nxt_wd_addr;
  logic [23:0] reg_wd_data;
  logic [23:0] nxt_wd_data;
  logic [31:0] wd_value;
  logic we_read;
  logic reg_read_reqq;
  logic nxt_read_reqq;
  logic [15:0] reg_read_cmd;
  logic [15:0] nxt_read_cmd;
  logic [31:0] read_value;
  logic we_write;
  logic reg_write_reqq;
  logic nxt_write_reqq;
  logic [15:0] reg_write_cmd;
  logic [15:0] nxt_write_cmd;
  logic [31:0] write_value;
  logic we_wr_dummy;
  logic [31:0] reg_wr_dummy_num;
  logic [31:0] nxt_wr_dummy_num;
  logic [31:0] wr_dummy_value;
  logic we_rd_dummy;
  logic [31:0] reg_rd_dummy_num;
  logic [31:0] nxt_rd_dummy_num;
  logic [31:0] rd_dummy_value;
  logic we_mode_status;
  logic [31:0] mode_status_value;
  logic we_independent;
  logic reg_independent_req;
  logic nxt_independent_req;
  logic [1:0] reg_independent_mode;
  logic [1:0] nxt_independent_mode;
  logic [15:0] reg_independent_cmd;
  logic [15:0] nxt_independent_cmd;
  logic [31:0] independent_value;
  //end of logic signal declaration

  //APB general access phase assignment - START
  assign apb_setup = i_psel & ~i_penable;
  assign apb_protect = i_protect_en ? ~i_pprot[1] : 1'b1;
  assign apb_slverr = i_slverr_en ? (~apb_protect      //error in protection
                      | (|i_paddr[1:0]) //error in address 
                      | (~&i_pstrb & i_pwrite)) : 1'b0;    //error in pstrb signal
  assign apb_complete = apb_setup & (~apb_slverr);
  assign apb_write = i_pwrite & apb_complete;
  assign apb_read = ~i_pwrite & apb_complete; 
  
  //APB capture FF phase
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin //address capture FF
    if(!i_bus_rstn) 
      reg_address <= '0;
    else if (apb_complete)
      reg_address <= i_paddr;
  end
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin //write data capture FF
    if(!i_bus_rstn) 
      reg_pwdata <= '0;
    else if (apb_write)
      reg_pwdata <= i_pwdata;
  end
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin //slverr output FF
    if(!i_bus_rstn) 
      reg_slverr <= '0;
    else if (apb_setup & i_slverr_en)
      reg_slverr <= apb_slverr;
  end
  assign o_pslverr = reg_slverr;
  //--------------------------------------------------------------------
  assign we_ctrl = apb_write_en & (reg_address == PARA_CTRL_OFFSET);
  assign we_wd = apb_write_en & (reg_address == PARA_WD_OFFSET);
  assign we_read = apb_write_en & (reg_address == PARA_READ_OFFSET);
  assign we_write = apb_write_en & (reg_address == PARA_WRITE_OFFSET);
  assign we_wr_dummy = apb_write_en & (reg_address == PARA_WR_DUMMY_OFFSET);
  assign we_rd_dummy = apb_write_en & (reg_address == PARA_RD_DUMMY_OFFSET);
  assign we_mode_status = apb_write_en & (reg_address == PARA_MODE_STATUS_OFFSET);
  assign we_independent = apb_write_en & (reg_address == PARA_INDEPENDENT_OFFSET);


  //APB handshake synchronization (appear when option Async is selected) - START
  //--------------------------------------------------------------------
  //Bus clock - reading phase
  //--------------------------------------------------------------------
  m_vlsi_synch #(
    .PARA_LEVELS (2)
  ) u_read_ack_reg2bus (
    .i_clk (i_bus_clk),
    .i_rstn (i_bus_rstn),
    .i_data_in (read_ack),
    .o_data_out (read_ack_bus_clk)
  );
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_read_req <= '0;
    else begin
      casez ({read_ack_bus_clk, apb_read})
        2'b1?: reg_read_req <= '0;
        2'b01: reg_read_req <= '1;
        2'b00: reg_read_req <= reg_read_req;
        default: reg_read_req <= 'x;
      endcase
    end
  end
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_read_ack_bus_clk_dly <= '0;
    else
      reg_read_ack_bus_clk_dly <= read_ack_bus_clk;
  end
  assign read_aclk_bus_clk_falling = reg_read_ack_bus_clk_dly & ~read_ack_bus_clk;

  //--------------------------------------------------------------------
  //Bus clock - writing phase
  //--------------------------------------------------------------------
  m_vlsi_synch #(
    .PARA_LEVELS (2)
  ) u_write_ack_reg2bus (
    .i_clk (i_bus_clk),
    .i_rstn (i_bus_rstn),
    .i_data_in (write_ack),
    .o_data_out (write_ack_bus_clk)
  );
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_write_req <= '0;
    else begin
      casez ({write_ack_bus_clk, apb_write})
        2'b1?: reg_write_req <= '0;
        2'b01: reg_write_req <= '1;
        2'b00: reg_write_req <= reg_write_req;
        default: reg_write_req <= 'x;
      endcase
    end
  end
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_write_ack_bus_clk_dly <= '0;
    else
      reg_write_ack_bus_clk_dly <= write_ack_bus_clk;
  end
  assign write_aclk_bus_clk_falling = reg_write_ack_bus_clk_dly & ~write_ack_bus_clk;

  //--------------------------------------------------------------------
  //Reg clock - reading handshake
  //--------------------------------------------------------------------
  m_vlsi_synch #(
    .PARA_LEVELS (2)
  ) u_rd_ack_reg2bus (
    .i_clk (i_reg_clk),
    .i_rstn (i_reg_rstn),
    .i_data_in (reg_read_req),
    .o_data_out (read_req_reg_clk)
  );
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin
    if(!i_reg_rstn) 
      reg_read_req_reg_clk_dly <= '0;
    else
      reg_read_req_reg_clk_dly <= read_req_reg_clk;
  end
  assign apb_read_en = ~reg_read_req_reg_clk_dly & read_req_reg_clk;
  assign read_ack = reg_read_req_reg_clk_dly;

  //--------------------------------------------------------------------
  //Reg clock - writing handshake
  //--------------------------------------------------------------------
  m_vlsi_synch #(
    .PARA_LEVELS (2)
  ) u_wr_ack_reg2bus (
    .i_clk (i_reg_clk),
    .i_rstn (i_reg_rstn),
    .i_data_in (reg_write_req),
    .o_data_out (write_req_reg_clk)
  );
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin
    if(!i_reg_rstn) 
      reg_write_req_reg_clk_dly <= '0;
    else
      reg_write_req_reg_clk_dly <= write_req_reg_clk;
  end
  assign apb_write_en = ~reg_write_req_reg_clk_dly & write_req_reg_clk;
  assign write_ack = reg_write_req_reg_clk_dly;

  //--------------------------------------------------------------------
  //PREADY phase
  //--------------------------------------------------------------------
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_pready <= '0;
    else
      reg_pready <= read_aclk_bus_clk_falling // reading complete
                | write_aclk_bus_clk_falling // writing complete
                | (apb_slverr & apb_setup);//slverr assert
  end
  assign o_pready = reg_pready;
  //--------------------------------------------------------------------

  //Assignment for next value of ctrl_cmd_2bytes rw
  assign nxt_ctrl_cmd_2bytes = (we_ctrl) ? reg_pwdata[2] : reg_ctrl_cmd_2bytes;
  //FF for bit ctrl_cmd_2bytes
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_ctrl_cmd_2bytes <= 1'h0;
    else
      reg_ctrl_cmd_2bytes <= nxt_ctrl_cmd_2bytes;
  end 
  assign o_ctrl_cmd_2bytes = reg_ctrl_cmd_2bytes;
  //Assignment for next value of ctrl_auto_data_wd rw
  assign nxt_ctrl_auto_data_wd = (we_ctrl) ? reg_pwdata[1] : reg_ctrl_auto_data_wd;
  //FF for bit ctrl_auto_data_wd
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_ctrl_auto_data_wd <= 1'h0;
    else
      reg_ctrl_auto_data_wd <= nxt_ctrl_auto_data_wd;
  end 
  assign o_ctrl_auto_data_wd = reg_ctrl_auto_data_wd;
  //Assignment for next value of ctrl_en rw
  assign nxt_ctrl_en = (we_ctrl) ? reg_pwdata[0] : reg_ctrl_en;
  //FF for bit ctrl_en
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_ctrl_en <= 1'h0;
    else
      reg_ctrl_en <= nxt_ctrl_en;
  end 
  assign o_ctrl_en = reg_ctrl_en;

  //--------------------------------------------------------------------
  //Combine the value of ctrl
  //--------------------------------------------------------------------
  always_comb begin
    ctrl_value[31:3] = '0;
    ctrl_value[2] = reg_ctrl_cmd_2bytes;
    ctrl_value[1] = reg_ctrl_auto_data_wd;
    ctrl_value[0] = reg_ctrl_en;
  end  //Assignment for next value of wd_req rwi
  assign nxt_wd_req = (we_wd) ? reg_pwdata[31]
                    : (i_hw_we_wd_req) ? i_hw_wdata_wd_req
                    : reg_wd_req;
  //FF for bit wd_req
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_wd_req <= 1'h0;
    else
      reg_wd_req <= nxt_wd_req;
  end 
  assign o_wd_req = reg_wd_req;
  //Assignment for next value of wd_addr rw
  assign nxt_wd_addr = (we_wd) ? reg_pwdata[29:24] : reg_wd_addr;
  //FF for bit wd_addr
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_wd_addr <= 6'h0;
    else
      reg_wd_addr <= nxt_wd_addr;
  end 
  assign o_wd_addr = reg_wd_addr;
  //Assignment for next value of wd_data rw
  assign nxt_wd_data = (we_wd) ? reg_pwdata[23:0] : reg_wd_data;
  //FF for bit wd_data
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_wd_data <= 24'h0;
    else
      reg_wd_data <= nxt_wd_data;
  end 
  assign o_wd_data = reg_wd_data;

  //--------------------------------------------------------------------
  //Combine the value of wd
  //--------------------------------------------------------------------
  always_comb begin
    wd_value[31] = reg_wd_req;
    wd_value[30] = i_wd_ack;
    wd_value[29:24] = reg_wd_addr;
    wd_value[23:0] = reg_wd_data;
  end  //Assignment for next value of read_reqq rwi
  assign nxt_read_reqq = (we_read) ? reg_pwdata[31]
                       : (i_hw_we_read_reqq) ? i_hw_wdata_read_reqq
                       : reg_read_reqq;
  //FF for bit read_reqq
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_read_reqq <= 1'h0;
    else
      reg_read_reqq <= nxt_read_reqq;
  end 
  assign o_read_reqq = reg_read_reqq;
  //Assignment for next value of read_cmd rw
  assign nxt_read_cmd = (we_read) ? reg_pwdata[15:0] : reg_read_cmd;
  //FF for bit read_cmd
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_read_cmd <= 16'h0;
    else
      reg_read_cmd <= nxt_read_cmd;
  end 
  assign o_read_cmd = reg_read_cmd;

  //--------------------------------------------------------------------
  //Combine the value of read
  //--------------------------------------------------------------------
  always_comb begin
    read_value[31] = reg_read_reqq;
    read_value[30] = i_read_ack;
    read_value[29:16] = '0;
    read_value[15:0] = reg_read_cmd;
  end  //Assignment for next value of write_reqq rwi
  assign nxt_write_reqq = (we_write) ? reg_pwdata[31]
                        : (i_hw_we_write_reqq) ? i_hw_wdata_write_reqq
                        : reg_write_reqq;
  //FF for bit write_reqq
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_write_reqq <= 1'h0;
    else
      reg_write_reqq <= nxt_write_reqq;
  end 
  assign o_write_reqq = reg_write_reqq;
  //Assignment for next value of write_cmd rw
  assign nxt_write_cmd = (we_write) ? reg_pwdata[15:0] : reg_write_cmd;
  //FF for bit write_cmd
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_write_cmd <= 16'h0;
    else
      reg_write_cmd <= nxt_write_cmd;
  end 
  assign o_write_cmd = reg_write_cmd;

  //--------------------------------------------------------------------
  //Combine the value of write
  //--------------------------------------------------------------------
  always_comb begin
    write_value[31] = reg_write_reqq;
    write_value[30] = i_write_ack;
    write_value[29:16] = '0;
    write_value[15:0] = reg_write_cmd;
  end  //Assignment for next value of wr_dummy_num rw
  assign nxt_wr_dummy_num = (we_wr_dummy) ? reg_pwdata[31:0] : reg_wr_dummy_num;
  //FF for bit wr_dummy_num
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_wr_dummy_num <= 32'h0;
    else
      reg_wr_dummy_num <= nxt_wr_dummy_num;
  end 
  assign o_wr_dummy_num = reg_wr_dummy_num;

  //--------------------------------------------------------------------
  //Combine the value of wr_dummy
  //--------------------------------------------------------------------
  always_comb begin
    wr_dummy_value[31:0] = reg_wr_dummy_num;
  end  //Assignment for next value of rd_dummy_num rw
  assign nxt_rd_dummy_num = (we_rd_dummy) ? reg_pwdata[31:0] : reg_rd_dummy_num;
  //FF for bit rd_dummy_num
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_rd_dummy_num <= 32'h0;
    else
      reg_rd_dummy_num <= nxt_rd_dummy_num;
  end 
  assign o_rd_dummy_num = reg_rd_dummy_num;

  //--------------------------------------------------------------------
  //Combine the value of rd_dummy
  //--------------------------------------------------------------------
  always_comb begin
    rd_dummy_value[31:0] = reg_rd_dummy_num;
  end
  //--------------------------------------------------------------------
  //Combine the value of mode_status
  //--------------------------------------------------------------------
  always_comb begin
    mode_status_value[31:2] = '0;
    mode_status_value[1:0] = i_mode_status_current;
  end  //Assignment for next value of independent_req rwi
  assign nxt_independent_req = (we_independent) ? reg_pwdata[31]
                             : (i_hw_we_independent_req) ? i_hw_wdata_independent_req
                             : reg_independent_req;
  //FF for bit independent_req
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_independent_req <= 1'h0;
    else
      reg_independent_req <= nxt_independent_req;
  end 
  assign o_independent_req = reg_independent_req;
  //Assignment for next value of independent_mode rw
  assign nxt_independent_mode = (we_independent) ? reg_pwdata[29:28] : reg_independent_mode;
  //FF for bit independent_mode
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_independent_mode <= 2'h0;
    else
      reg_independent_mode <= nxt_independent_mode;
  end 
  assign o_independent_mode = reg_independent_mode;
  //Assignment for next value of independent_cmd rw
  assign nxt_independent_cmd = (we_independent) ? reg_pwdata[15:0] : reg_independent_cmd;
  //FF for bit independent_cmd
  always_ff @ (posedge i_reg_clk, negedge i_reg_rstn) begin //FF for each bit
    if(!i_reg_rstn) 
      reg_independent_cmd <= 16'h0;
    else
      reg_independent_cmd <= nxt_independent_cmd;
  end 
  assign o_independent_cmd = reg_independent_cmd;

  //--------------------------------------------------------------------
  //Combine the value of independent
  //--------------------------------------------------------------------
  always_comb begin
    independent_value[31] = reg_independent_req;
    independent_value[30] = i_independent_ack;
    independent_value[29:28] = reg_independent_mode;
    independent_value[27:16] = '0;
    independent_value[15:0] = reg_independent_cmd;
  end
  //--------------------------------------------------------------------
  //O_PRDATA phase
  //--------------------------------------------------------------------
  always_comb begin
    case (reg_address)
      PARA_CTRL_OFFSET: nxt_prdata = ctrl_value;
      PARA_WD_OFFSET: nxt_prdata = wd_value;
      PARA_READ_OFFSET: nxt_prdata = read_value;
      PARA_WRITE_OFFSET: nxt_prdata = write_value;
      PARA_WR_DUMMY_OFFSET: nxt_prdata = wr_dummy_value;
      PARA_RD_DUMMY_OFFSET: nxt_prdata = rd_dummy_value;
      PARA_MODE_STATUS_OFFSET: nxt_prdata = mode_status_value;
      PARA_INDEPENDENT_OFFSET: nxt_prdata = independent_value;
      default nxt_prdata = '0;
    endcase
  end
  always_ff @ (posedge i_bus_clk, negedge i_bus_rstn) begin
    if(!i_bus_rstn) 
      reg_prdata <= '0;
    else if (apb_read_en)
      reg_prdata <= nxt_prdata;
  end
  assign o_prdata = reg_prdata;

endmodule: m_vlsi_qspi_csr