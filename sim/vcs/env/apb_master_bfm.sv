`timescale 1ns/1ps
//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// Module : apb_master_bfm
// Function:
//   Simple APB master BFM for CSR register access.
//   Provides task-based API for APB read/write operations.
//--------------------------------------------------------------------

interface apb_master_bfm #(
  parameter int ADDR_WD = 16,
  parameter int DATA_WD = 32
) (
  input logic pclk,
  input logic presetn
);

  logic [ADDR_WD-1:0]  paddr;
  logic                psel;
  logic                penable;
  logic                pwrite;
  logic [DATA_WD-1:0]  pwdata;
  logic [3:0]          pstrb;
  logic                protect_en;
  logic                slverr_en;
  logic [2:0]          pprot;

  logic                pready;
  logic [DATA_WD-1:0]  prdata;
  logic                pslverr;

  int verbosity = 1;

  // =========================================================================
  // Initialization
  // =========================================================================
  initial begin
    paddr      = '0;
    psel       = 1'b0;
    penable    = 1'b0;
    pwrite     = 1'b0;
    pwdata     = '0;
    pstrb      = 4'hF;
    protect_en = 1'b0;
    slverr_en  = 1'b0;
    pprot      = 3'b000;
  end

  // =========================================================================
  // TASK: write
  //   Performs an APB write to the given address.
  // =========================================================================
  task automatic write(
    input logic [ADDR_WD-1:0] addr,
    input logic [DATA_WD-1:0] data
  );
    // Setup phase
    @(posedge pclk);
    paddr   <= addr;
    pwdata  <= data;
    pwrite  <= 1'b1;
    psel    <= 1'b1;
    penable <= 1'b0;

    // Access phase
    @(posedge pclk);
    penable <= 1'b1;

    // Wait for pready
    do @(posedge pclk); while (!pready);

    if (verbosity >= 2)
      $display("[APB_BFM] WRITE addr=0x%04h data=0x%08h", addr, data);

    // Cleanup
    psel    <= 1'b0;
    penable <= 1'b0;
    pwrite  <= 1'b0;
  endtask

  // =========================================================================
  // TASK: read
  //   Performs an APB read from the given address.
  // =========================================================================
  task automatic read(
    input  logic [ADDR_WD-1:0] addr,
    output logic [DATA_WD-1:0] data
  );
    // Setup phase
    @(posedge pclk);
    paddr   <= addr;
    pwrite  <= 1'b0;
    psel    <= 1'b1;
    penable <= 1'b0;

    // Access phase
    @(posedge pclk);
    penable <= 1'b1;

    // Wait for pready
    do @(posedge pclk); while (!pready);

    data = prdata;

    if (verbosity >= 2)
      $display("[APB_BFM] READ  addr=0x%04h data=0x%08h", addr, data);

    // Cleanup
    psel    <= 1'b0;
    penable <= 1'b0;
  endtask

  // =========================================================================
  // TASK: wait_cycles
  // =========================================================================
  task automatic wait_cycles(input int n);
    repeat (n) @(posedge pclk);
  endtask

endinterface : apb_master_bfm
