#--------------------------------------------------------------------
# Project: QSPI PSRAM Controller - Simulation Environment
# File  : Makefile
# Function: Build and run simulation
#--------------------------------------------------------------------

# -------------------------------------------------------------------
# Environment setup
# -------------------------------------------------------------------
QSPI_PSRAM_CTRL_HOME ?= $(abspath $(CURDIR)/../..)

TOP           ?= test_top
TEST          ?= basic_qspi_psram_test

# -------------------------------------------------------------------
# Simulator selection (detect what's available)
# -------------------------------------------------------------------
SIM ?= vcs

# Detect available simulators
VCS_EXISTS := $(shell which vcs 2>/dev/null)
IVERILOG_EXISTS := $(shell which iverilog 2>/dev/null)
VERILATOR_EXISTS := $(shell which verilator 2>/dev/null)

# Auto-detect if SIM not set
ifeq ($(SIM),auto)
  ifneq ($(VCS_EXISTS),)
    SIM=vcs
  else ifneq ($(IVERILOG_EXISTS),)
    SIM=iverilog
  else ifneq ($(VERILATOR_EXISTS),)
    SIM=verilator
  else
    $(error No simulator found! Install vcs, iverilog, or verilator)
  endif
endif

# -------------------------------------------------------------------
# Common flags
# -------------------------------------------------------------------
SV_FLAGS = -sverilog -timescale=1ns/1ps
INC_DIRS = +incdir+. +incdir+./env +incdir+./tests

# -------------------------------------------------------------------
# VCS
# -------------------------------------------------------------------
ifeq ($(SIM),vcs)
  VCS ?= vcs
  VERDI_HOME ?= /tools/Synopsys/verdi/X-2025.06

  VCS_FLAGS = -full64 $(SV_FLAGS) \
              -kdb \
              -debug_access+all \
              +define+WAVES_FSDB \
              $(INC_DIRS) \
              -l comp.log

  RUN_FLAGS = +vmm_test=$(TEST) -l sim.log

  build:
	$(VCS) $(VCS_FLAGS) -f filelist.f -top $(TOP)

  run: build
	./simv $(RUN_FLAGS)

  waves:
	verdi -ssf test_top.fsdb &

  clean:
	rm -rf simv simv.daidir csrc ucli.key *.log *.vpd *.vcd *.fsdb novas* verdiLog
endif

# -------------------------------------------------------------------
# Icarus Verilog (free, open source)
# -------------------------------------------------------------------
ifeq ($(SIM),iverilog)
  IVERILOG ?= iverilog
  VVP ?= vvp

  IVL_FLAGS = -g2012 -Wall \
              -I . -I ./env -I ./tests \
              -I $(QSPI_PSRAM_CTRL_HOME)/rtl \
              -I $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER \
              -I $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL \
              -I $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/models \
              -o sim.vvp

  RTL_FILES = \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/models/m_vlsi_synch.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_multi_synch.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_async_fifo.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/m_vlsi_qspi_csr.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axfsm.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_arbiter.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi_bus_logic.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi_sclk_logic.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi4_sram.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_qspi_fsm.sv \
    $(QSPI_PSRAM_CTRL_HOME)/m_vlsi_qspi_top.sv

  TB_FILES = \
    ./env/m_vlsi_psram_sp.sv \
    ./env/axi_master_bfm.sv \
    ./env/apb_master_bfm.sv \
    ./env/qspi_dut_wrapper.sv \
    ./env/top.sv

  build:
	$(IVERILOG) $(IVL_FLAGS) $(RTL_FILES) $(TB_FILES)

  run: build
	$(VVP) sim.vvp -l sim.log

  waves:
	gtkwave test_top.vcd &

  clean:
	rm -rf sim.vvp *.log *.vcd
endif

# -------------------------------------------------------------------
# Verilator (lint + sim)
# -------------------------------------------------------------------
ifeq ($(SIM),verilator)
  VERILATOR ?= verilator

  VERILATOR_FLAGS = --sv --timing --binary --build \
                    -Wno-fatal -Wno-UNUSEDSIGNAL -Wno-UNDRIVEN \
                    -I./env -I./tests \
                    -I$(QSPI_PSRAM_CTRL_HOME)/rtl \
                    -I$(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER \
                    -I$(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL \
                    -I$(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/models \
                    --top-module $(TOP) \
                    -o V$(TOP)

  RTL_FILES = \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/models/m_vlsi_synch.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_multi_synch.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_async_fifo.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/CSR/RTL/m_vlsi_qspi_csr.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axfsm.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_arbiter.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi_bus_logic.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi_sclk_logic.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/AXI_CONTROLLER/m_vlsi_axi4_sram.sv \
    $(QSPI_PSRAM_CTRL_HOME)/rtl/m_vlsi_qspi_fsm.sv \
    $(QSPI_PSRAM_CTRL_HOME)/m_vlsi_qspi_top.sv \
    ./env/m_vlsi_psram_sp.sv \
    ./env/axi_master_bfm.sv \
    ./env/apb_master_bfm.sv \
    ./env/qspi_dut_wrapper.sv \
    ./env/top.sv

  build:
	$(VERILATOR) $(VERILATOR_FLAGS) $(RTL_FILES)

  run: build
	./obj_dir/V$(TOP)

  lint:
	$(VERILATOR) --lint-only $(VERILATOR_FLAGS) $(RTL_FILES)

  clean:
	rm -rf obj_dir V$(TOP)
endif

# -------------------------------------------------------------------
# Common targets
# -------------------------------------------------------------------
.PHONY: build run waves clean lint
