#!/usr/bin/env bash

export QSPI_HOME="$PWD"

# Add RTL directory to search paths
export QSPI_RTL="$QSPI_HOME/rtl"

# Source the filelist for simulation/synthesis tools
export QSPI_FILELIST="$QSPI_RTL/filelist.f"

# Print status
echo "QSPIController Environment Loaded"
echo "  QSPI_HOME    = $QSPI_HOME"
echo "  QSPI_RTL     = $QSPI_RTL"
echo "  Filelist         = $QSPI_FILELIST"
