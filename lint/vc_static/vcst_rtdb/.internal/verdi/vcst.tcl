## VerdiPlay
source ./verdi_vcst.tcl
verdiToolBar -win $_nTrace1 -toolbar toolBarFormalVerification -moveToFirst
::vcst::createAddTraceToWaveAction
verdiWindowPrependTitle -win $_nTrace1 -preTitle {}
vcstVerdiRegisterColors -colors #a0a0a4,#c0c0c0,#000000,#ff0000,#ffff00,#0000ff,#008000,#ffffff,#b5e61d,#ffaec9,#efe4b0,#00cd00,#ff9307,#ff4343,#000000,#ffff00,#646464,#00007f,#660099,#ffc40d,#666600,#000000,#880000,#bf6f00,#008000,#4a766e,#0000ff,#000080,#000000,#00819b,#aaaaaa,#c0c0c0,#ff8c00,#e3f4ff,#ff0000,#808080,#000000,#000000,#ffff01,#01ff01,#ff0101,#ff9307,#01ffff,#f700ff,#999999,#ff80ff,#000000,#a8ffa8,#ce8902,#52d017,#f62817,#e6bf83,#b86500,#ff7722,#ffef00,#9afeff,#d891ef,#808080,#c7c7c7,#d6f0d6,#f1f0c8,#dbcaf0,#800000,#ffa500,#c4c4c4,#ebebeb,#be0000,#00be00,#bebe00,#0000be,#be00be,#00bebe,#bebebe
verdiAboutDlg -banner {
VC Static

Version X-2025.06 for linux64 - May 29, 2025

Copyright (c) 2010 - 2025 Synopsys, Inc.
}

verdiRunVcstCmd "action aaMonetView -hideiv \{[verdiGetRCValue -section appSetting -key hideIV]\}
" -no_wait
set ::vcst::_top "m_vlsi_qspi_top"
set ::vcst::_elab ""
set ::vcst::_elabOpts {}
set ::vcst::_rtdbDir {/home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb}
set ::vcst::_hiddenDir {.internal}
set ::vcst::_masterMode false
set ::vcst::_workLib ""
set ::vcst::_upfOpts " -upf "
set ::vcst::_enableKdb "true"
set ::vcst::_simBinPath "m_vlsi_qspi_top.exe"
set ::vcst::_goldenUpfConfig {}
set ::vcst::_nldmNschema {true}
set ::vcst::_kdbAlias {false}
set ::vcst::_covDut {}
set ::vcst::_splitbus {false}
set ::vcst::_enableVerdiLog {1}
set ::vcst::_fml_max_proof_depth {}
set ::vcst::_smartLoad {true}
set ::vcst::_compositeTrace {1}
set ::vcst::_strategyFilePath {}
set ::vcst::_enableVnrWriteKdb {false}
set ::vcst::_bIsFormalFlow {false}
set ::vcst::_bGlobalFsdbPresent {false}
set ::vcst::_sRunModes {}
set ::vcst::_enableVnrWriteKdbResolve {true}
set ::vcst::_disableSymbolLibraryImportMessage {false}
set ::vcst::_enableKdbRemoval {false}
set ::vcst::_diucFlow {false}
set ::vcst::_libArgs ""
set ::vcst::_seqXmlFile ""
srcSetPreference -vhdlcase {original} 
schUnifiedNetList -skipKdb
schSetPreference -turboLibs {} -turboLibPaths {}
verdiSetPrefEnv -bSpecifyWindowTitleForDockContainer off
schSetPreference -detailRTL on
paSetPreference -brightenPowerColor on
schSetPreference -showPassThroughNet on
paSetPreference -AnnotateSignal off
paSetPreference -highlightPowerObject off
srcAssertSetOpt -addSigToWave 0 -addSigWithExpGrp 1 -maskWave 0 -ShowCycleInfo 1
srcBlockFilelocateDlg on
verdiRunVcst -on
schSetOptions -hierFlatten on
schSetVCSTDelimiter -hierDelim /
set ::vcst::_vcstAppHierDelim "/"
set ::vcst::_powerDbDir ""
set ::vcst::_bRestore ""
srcSetPreference -delimiterforFindSignal_Inst_Instport "/"
srcSetPreference -skipTopLevelName on
srcSetPreference -copyScopeNameDelimiter "/"
::vcst::loadMainWin "1"
srcBlockFilelocateDlg off

verdiSetFont -font "Bitstream Vera Sans" -size "11"
verdiSetPrefEnv -monoFontSize "11"
schGrayMode -win \$_nSchema1

srcSetDecoration -type sambox -reset

srcSetDecoration -type sambox -inst 1

schResetDisplayAttr -white

srcSetPreference -tabNum 16
verdiSetStatusMsg -win Verdi_1 -color black { Design import ready }
opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/verdi/signalnames.xml}

::vcst::hideUnrelatedMenus

verdiRaiseWindow -lower;verdiShowWindow -min
verdiToolBar -win $_Verdi_1 -toolbar HB_POWER_TRACE_COMMAND_PANEL -hide; verdiToolBar -win $_Verdi_1 -toolbar PDML_COMMAND_PANEL -hide; verdiToolBar -win $_Verdi_1 -toolbar HB_PA_DOMAIN_PANEL -hide

verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on"
set ::vcst::_bRestore ""
verdiLayoutFreeze -off
verdiToolBar -rm ABV_ADD_TEMPORARY_ASSERT_PANEL
verdiToolBar -rm toolbarHB_TOGGLE_PANEL toolbarHB_EMULATION_PANEL toolbarHB_PRODTYPE_PANEL UVM_AWARE_DEBUG AMS_CONFIG_TOOLBAR NOVAS_TBBR_INTERACTIVEVIEW_PANEL NOVAS_TBBR_DEBUG_REWIND_COMMAND NOVAS_TBBR_DEBUG_REWIND_UNDO_REDO_COMMAND NOVAS_TBBR_DEBUG_REVERSE_COMMAND NOVAS_TBBR_DEBUG_VSIM_COMMAND NOVAS_EMULATION_DEBUG_COMMAND CVG_CER_PANEL NOVAS_TBBR_DEBUG_COMMAND
verdiLayoutFreeze -off
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1;
verdiVcstSyncMsgColor -errorColor "default_red" -warningColor "default_none" -infoColor "default_none"
srcSetBlackbox   -delim {/}
srcSetGlassbox  -delim {/}
