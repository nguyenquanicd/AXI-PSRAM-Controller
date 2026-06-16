verdiWindowResize -win $_Verdi_1 -2 -1 "2056" "1242"
verdiWindowResize -win $_Verdi_1 -2 -1 "2056" "1242"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave2
wvRestoreSignal -win $_nWave2 "/home/ltthinh/PSRAM_CTRL/sim/vcs/signal.rc" \
           -overWriteAutoAlias on -appendSignals on
wvSetFileTimeRange -win $_nWave2 -time_unit 1p 0 9935000
wvSetCursor -win $_nWave2 3531519.865732 -snap {("G2" 13)}
wvZoomAll -win $_nWave2
verdiDockWidgetMaximize -dock windowDock_nWave_2
wvZoom -win $_nWave2 7950083.795670 9416538.193505
wvSetCursor -win $_nWave2 8975014.372776 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 9077209.773978 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 8564248.391244 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 8376724.790980 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 9075225.397255 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 8966084.677525 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 7993740.083561 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 7827350.095390 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 7739045.331245 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 7936490.815121 -snap {("G2" 13)}
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 6305531.587002 -snap {("G2" 13)}
wvZoom -win $_nWave2 6204328.374160 6627000.616026
wvSetCursor -win $_nWave2 6275250.374148 -snap {("G2" 13)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 4953756.172754 -snap {("G2" 13)}
wvSetCursor -win $_nWave2 5659773.243605 -snap {("G2" 13)}
wvZoom -win $_nWave2 4934538.598563 6195119.953194
wvZoom -win $_nWave2 5185290.234735 5801934.564503
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G2" 20 )} 
wvSelectSignal -win $_nWave2 {( "G2" 21 )} 
wvSelectSignal -win $_nWave2 {( "G2" 20 )} 
wvSelectSignal -win $_nWave2 {( "G2" 21 )} 
wvGetSignalOpen -win $_nWave2
wvGetSignalSetSignalFilter -win $_nWave2 "*reg_rdata*"
wvSetPosition -win $_nWave2 {("G3" 15)}
wvSetPosition -win $_nWave2 {("G3" 15)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSetPosition -win $_nWave2 {("G3" 15)}
wvGetSignalSetScope -win $_nWave2 "/test_top/u_dut_wrapper/u_dut/u_qspi_fsm"
wvSetPosition -win $_nWave2 {("G3" 16)}
wvSetPosition -win $_nWave2 {("G3" 16)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_rdata\[31:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 16 )} 
wvSetPosition -win $_nWave2 {("G3" 16)}
wvGetSignalClose -win $_nWave2
wvZoom -win $_nWave2 7045653.608509 7643106.030856
wvSetCursor -win $_nWave2 7263937.984738 -snap {("G2" 12)}
wvSetCursor -win $_nWave2 7277277.585507 -snap {("G3" 16)}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 16 )} 
wvSelectSignal -win $_nWave2 {( "G3" 16 )} 
wvSetRadix -win $_nWave2 -format Bin
wvSetPosition -win $_nWave2 {("G3" 9)}
wvSetPosition -win $_nWave2 {("G3" 8)}
wvSetPosition -win $_nWave2 {("G3" 16)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvZoom -win $_nWave2 7250598.383968 7375505.554811
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSetCursor -win $_nWave2 7294801.457832 -snap {("G3" 1)}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSetRadix -win $_nWave2 -format Hex
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G3" 6 )} 
wvSelectSignal -win $_nWave2 {( "G3" 5 )} 
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvScrollDown -win $_nWave2 0
wvZoom -win $_nWave2 7057830.224360 7562946.444497
wvSetCursor -win $_nWave2 7219402.133224 -snap {("G2" 13)}
wvGetSignalOpen -win $_nWave2
wvGetSignalSetSignalFilter -win $_nWave2 "*reg_cnt_data*"
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvGetSignalSetScope -win $_nWave2 "/test_top/u_dut_wrapper/u_dut/u_qspi_fsm"
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_data\[23:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvSetPosition -win $_nWave2 {("G3" 2)}
wvGetSignalClose -win $_nWave2
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoom -win $_nWave2 4250109.369952 9487448.869144
wvZoom -win $_nWave2 4960830.723638 7469507.882782
wvZoom -win $_nWave2 5358004.167250 6504943.805437
wvZoomIn -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G3" 2 )} 
wvZoom -win $_nWave2 5611433.357900 5814788.164509
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/test_top/u_dut_wrapper/u_dut/u_qspi_fsm"
wvGetSignalSetSignalFilter -win $_nWave2 "*reg_csr*_data*"
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_data\[23:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSetPosition -win $_nWave2 {("G3" 2)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvSetPosition -win $_nWave2 {("G3" 3)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_clk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_sclk} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_araddr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arburst\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arid\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arlen\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_arvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_arready} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G2" \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/o_rvalid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/i_rready} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_wr_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/reg_rd_cnt\[2:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/i_re} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_sel} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_arb_write_en} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/o_req_read} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_read_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_axi_sclk_logic/i_sram_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_state\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_cmd\[4:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_addr\[7:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_we} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_ax_oe} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_axi_ctrl/u_arfifo/o_write_valid} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[31\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[30\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_data_out\[29\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_write_cmd\[15:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G3" \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_rdata\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_cnt_data\[23:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_data\[23:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_qspi_si\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_cs_n} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_oe\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[3\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[2\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[1\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_qspi_so\[0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/o_csr_mode_status_current\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_csr/o_independent_mode\[1:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/i_csr_independent_cmd\[15:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_ctrl_cmd_2bytes} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_ax_addr\[31:0\]} -height 16 \
{/test_top/u_dut_wrapper/u_dut/u_qspi_fsm/reg_csr_wd_addr\[5:0\]} -height 16 \
}
wvAddSignal -win $_nWave2 -group {"G4" \
}
wvSelectSignal -win $_nWave2 {( "G3" 3 )} 
wvSetPosition -win $_nWave2 {("G3" 3)}
wvGetSignalClose -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G3" 3 )} 
wvSetRadix -win $_nWave2 -format UDec
debExit
