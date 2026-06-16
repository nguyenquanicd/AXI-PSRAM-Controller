`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Module : axi_master_bfm
// Function:
//   Simple AXI4 master BFM for testbench use.
//   Provides task-based API for issuing AXI write/read transactions.
//   Supports FIXED, INCR, and WRAP burst types.
//--------------------------------------------------------------------

interface axi_master_bfm #(
  parameter int ADDR_WD = 32,
  parameter int DATA_WD = 32,
  parameter int ID_WD   = 4,
  parameter int LEN_WD  = 8
) (
  input logic aclk,
  input logic aresetn
);

  // AXI Write Address Channel
  logic [ADDR_WD-1:0] awaddr;
  logic               awvalid;
  logic               awready;
  logic [1:0]         awburst;
  logic [LEN_WD-1:0]  awlen;
  logic [ID_WD-1:0]   awid;

  // AXI Write Data Channel
  logic [DATA_WD-1:0] wdata;
  logic               wvalid;
  logic               wready;
  logic               wlast;

  // AXI Write Response Channel
  logic [ID_WD-1:0]   bid;
  logic [1:0]         bresp;
  logic               bvalid;
  logic               bready;

  // AXI Read Address Channel
  logic [ADDR_WD-1:0] araddr;
  logic               arvalid;
  logic               arready;
  logic [1:0]         arburst;
  logic [LEN_WD-1:0]  arlen;
  logic [ID_WD-1:0]   arid;

  // AXI Read Data Channel
  logic [ID_WD-1:0]   rid;
  logic [DATA_WD-1:0] rdata;
  logic [1:0]         rresp;
  logic               rvalid;
  logic               rready;
  logic               rlast;

  // =========================================================================
  // BFM state
  // =========================================================================
  int                  beat_bytes;
  logic [ID_WD-1:0]    next_id;
  int                  verbosity = 1;  // 0=silent, 1=normal, 2=verbose

  // =========================================================================
  // Initialization
  // =========================================================================
  initial begin
    awaddr  = '0;
    awvalid = 1'b0;
    awburst = 2'b01;  // INCR
    awlen   = '0;
    awid    = '0;
    wdata   = '0;
    wvalid  = 1'b0;
    wlast   = 1'b0;
    bready  = 1'b1;
    araddr  = '0;
    arvalid = 1'b0;
    arburst = 2'b01;
    arlen   = '0;
    arid    = '0;
    rready  = 1'b1;
    next_id = '0;
    beat_bytes = DATA_WD / 8;
  end

  // =========================================================================
  // Utility: compute next address for given burst type
  // =========================================================================
  function automatic logic [ADDR_WD-1:0] next_burst_addr(
    input logic [ADDR_WD-1:0] curr_addr,
    input logic [1:0]         burst_type,
    input logic [LEN_WD-1:0]  total_len    // awlen (beats-1)
  );
    logic [ADDR_WD-1:0] wrap_bytes;
    logic [ADDR_WD-1:0] wrap_mask;
    logic [ADDR_WD-1:0] wrap_base;
    logic [ADDR_WD-1:0] wrap_next;
    case (burst_type)
      2'b00: next_burst_addr = curr_addr;                                // FIXED
      2'b01: next_burst_addr = curr_addr + beat_bytes;                   // INCR
      2'b10: begin                                                       // WRAP
        wrap_bytes = beat_bytes * (total_len + 1);
        wrap_mask  = wrap_bytes - 1;
        wrap_next  = curr_addr + beat_bytes;
        wrap_base  = curr_addr & ~wrap_mask;
        next_burst_addr = wrap_base | (wrap_next & wrap_mask);
      end
      default: next_burst_addr = curr_addr + beat_bytes;
    endcase
  endfunction

  // =========================================================================
  // TASK: write_burst
  //   Issues a complete AXI write burst transaction.
  // =========================================================================
  task automatic write_burst(
    input logic [ADDR_WD-1:0]       addr,
    input logic [1:0]               burst_type,
    input logic [LEN_WD-1:0]        length,     // awlen (number of beats - 1)
    input logic [DATA_WD-1:0]       data [],    // data for each beat
    input logic [ID_WD-1:0]         id
  );
    int b;
    logic [ADDR_WD-1:0] beat_addr;

    if (verbosity >= 1)
      $display("[AXI_BFM] WRITE BURST: addr=0x%08h burst=%0d len=%0d id=%0d",
               addr, burst_type, length, id);

    // --- Write Address Phase ---
    @(posedge aclk);
    awaddr  <= addr;
    awburst <= burst_type;
    awlen   <= length;
    awid    <= id;
    awvalid <= 1'b1;

    // Wait for AW handshake
    do @(posedge aclk); while (!awready);
    awvalid <= 1'b0;

    // --- Write Data Phase ---
    beat_addr = addr;
    for (b = 0; b <= length; b++) begin
      @(posedge aclk);
      wdata  <= data[b];
      wlast  <= (b == length);
      wvalid <= 1'b1;

      do @(posedge aclk); while (!wready);
      wvalid <= 1'b0;
      wlast  <= 1'b0;
      beat_addr = next_burst_addr(beat_addr, burst_type, length);
    end

    // --- Write Response Phase ---
    bready <= 1'b1;
    do @(posedge aclk); while (!bvalid);
    if (verbosity >= 1) begin
      if (bresp != 2'b00)
        $display("[AXI_BFM] WARNING: Write response error: bresp=%0d id=%0d", bresp, bid);
      else
        $display("[AXI_BFM] WRITE BURST complete: id=%0d OK", bid);
    end
  endtask

  // =========================================================================
  // TASK: write_single
  //   Issues a single-beat write transaction.
  // =========================================================================
  task automatic write_single(
    input logic [ADDR_WD-1:0] addr,
    input logic [DATA_WD-1:0] data,
    input logic [ID_WD-1:0]   id
  );
    logic [DATA_WD-1:0] tmp [0:0];
    tmp[0] = data;
    write_burst(addr, 2'b01, '0, tmp, id);
  endtask

  // =========================================================================
  // TASK: read_burst
  //   Issues a complete AXI read burst transaction.
  //   Optionally compares against expected data.
  // =========================================================================
  task automatic read_burst(
    input  logic [ADDR_WD-1:0]       addr,
    input  logic [1:0]               burst_type,
    input  logic [LEN_WD-1:0]        length,
    input  logic [ID_WD-1:0]         id,
    output logic [DATA_WD-1:0]       rdata_out [],
    input  logic                     check_en,
    input  logic [DATA_WD-1:0]       expected [],
    output int                       mismatch_count
  );
    int b;
    logic [ADDR_WD-1:0] beat_addr;

    mismatch_count = 0;
    rdata_out = new[length+1];

    if (verbosity >= 1)
      $display("[AXI_BFM] READ BURST: addr=0x%08h burst=%0d len=%0d id=%0d",
               addr, burst_type, length, id);

    // --- Read Address Phase ---
    @(posedge aclk);
    araddr  <= addr;
    arburst <= burst_type;
    arlen   <= length;
    arid    <= id;
    arvalid <= 1'b1;

    if (verbosity >= 1)
      $display("[AXI_BFM]   READ: waiting for AR ready...");
    do @(posedge aclk); while (!arready);
    if (verbosity >= 1)
      $display("[AXI_BFM]   READ: AR accepted, waiting for R data...");
    arvalid <= 1'b0;

    // --- Read Data Phase ---
    rready <= 1'b1;
    beat_addr = addr;
    for (b = 0; b <= length; b++) begin
      if (verbosity >= 1)
        $display("[AXI_BFM]   READ: waiting for R valid (beat %0d)...", b);
      do @(posedge aclk); while (!rvalid);
      rdata_out[b] = rdata;
      if (verbosity >= 2)
        $display("[AXI_BFM]   READ beat[%0d] addr=0x%08h data=0x%08h resp=%0d last=%0d",
                 b, beat_addr, rdata, rresp, rlast);

      // Check against expected
      if (check_en) begin
        logic [DATA_WD-1:0] exp_val;
        if (burst_type == 2'b00)
          exp_val = expected[0];  // FIXED: all same
        else
          exp_val = expected[b];
        if (rdata_out[b] !== exp_val) begin
          if (verbosity >= 1)
            $display("[AXI_BFM] MISMATCH beat[%0d] addr=0x%08h exp=0x%08h got=0x%08h",
                     b, beat_addr, exp_val, rdata_out[b]);
          mismatch_count++;
        end
      end

      beat_addr = next_burst_addr(beat_addr, burst_type, length);
    end

    if (verbosity >= 1)
      $display("[AXI_BFM] READ BURST complete: id=%0d mismatches=%0d", rid, mismatch_count);
  endtask

  // =========================================================================
  // TASK: read_single
  // =========================================================================
  task automatic read_single(
    input  logic [ADDR_WD-1:0] addr,
    input  logic [ID_WD-1:0]   id,
    output logic [DATA_WD-1:0] data
  );
    logic [DATA_WD-1:0] tmp [];
    int mismatch;
    logic [DATA_WD-1:0] exp_empty [0:0];
    exp_empty[0] = '0;
    read_burst(addr, 2'b01, '0, id, tmp, 1'b0, exp_empty, mismatch);
    data = tmp[0];
  endtask

  // =========================================================================
  // TASK: wait_cycles
  // =========================================================================
  task automatic wait_cycles(input int n);
    repeat (n) @(posedge aclk);
  endtask

endinterface : axi_master_bfm
