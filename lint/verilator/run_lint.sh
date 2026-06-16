#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
export QSPI_PSRAM_CTRL_HOME="$ROOT_DIR"

cd "$ROOT_DIR"

verilator --lint-only --sv -Wall \
  --top-module m_vlsi_qspi_top \
  -f filelist.f \
  "$@"
