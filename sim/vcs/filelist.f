//--------------------------------------------------------------------
// Project: QSPI PSRAM Controller - Simulation Environment
// File  : filelist.f
// Function: RTL + Testbench file list for simulation
//--------------------------------------------------------------------

+incdir+.
+incdir+./env
+incdir+./tests

// Design RTL
-f $QSPI_RTL/filelist.f

// Simulation environment
./env/m_vlsi_psram_sp.sv
./env/axi_master_bfm.sv
./env/apb_master_bfm.sv
./env/qspi_dut_wrapper.sv
./env/top.sv
