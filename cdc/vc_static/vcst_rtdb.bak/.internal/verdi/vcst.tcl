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
set ::vcst::_rtdbDir {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb}
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
opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/signalnames.xml}

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
schGrayMode -win \$_nSchema1
srcSetBlackbox   -delim {/}
srcSetGlassbox  -delim {/}
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="124"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][27:24]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_id/Q[3:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4c1c69d0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4c1c69d0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="169"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q[7:0][23:0]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_addr/Q[23:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4c1c69d0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="117"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_rd_last/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4df35000"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="180"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_id/Q[3:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4dfeaa30"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="172"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][23:0]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_addr/Q[23:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4e01d7e0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="140"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_pending/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4f072460"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+385|CDC_UNSYNC_DATA,+385};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="225"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_rfifo/rd_comb_val[0]&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4e8897e0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+300|CDC_UNSYNC_DATA,+385};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="226"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/w_write_error&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4fc5bb30"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+300|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+300|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="227"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_bfifo/rd_comb_val[0]&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="50d4cbb0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="228"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/o_sram_addr[0]&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4fc2c5b0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ;opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml}
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+300|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="221"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arbiter/o_arb_sel&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="539a8010"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+360|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="223"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_bus_logic/o_awfifo_we&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="556829c0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+300|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="229"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_csr/reg_pready/D&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Same Source Diverging Paths" shape="box" style="solid" color="#FFD2A5" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="5632b2d0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_pclk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+300|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="222"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals from mutually asynchronous sources&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_csr/reg_prdata/D[30]&lt;/font&gt;" /><Legends><Legend name="Input Signals" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Synchronizers" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Converging Paths" shape="box" style="solid" color="#FF73FF" fill="1" /><Legend name="Convergence Net" shape="box" style="solid" color="#0101FF" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4a8c2010"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_pclk" icon="cipl,#ff0000" /></H_Ports><H_Pins><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_nxt_prdata/D1[31:0]" text="32'b00000..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_20/D1[31:0]" text="32'bxx000..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_19/D1[31:0]" text="32'bxx000..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_17/D0[31:0]" text="32'bxxxx0..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_16/OUT[31:0]" text="32'bxxxx0..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_16/D1[31:0]" text="32'b00000..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_16/D0[31:0]" text="32'bxxxx0..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_15/OUT[31:0]" text="32'bxxxx0..." icon="" /><H_Pin name="m_vlsi_qspi_top/u_csr/I_MUX_N_15/D1[31:0]" text="32'bxxxx0..." icon="" /></H_Pins></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+360|CDC_COHERENCY_RECONV_COMB,+360|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+353|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+360};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+353|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+353};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="136"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="59e55a70"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="136"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="582b8720"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+353|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+378};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="148"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q[7:0][32]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q[1]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4e029bd0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports><H_Pins><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/D[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/OUT[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D1[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D0[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_w_bresp/OUT[1:0]" text="2'bx0" icon="" /></H_Pins></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="185"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q[7:0][31:0]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_wdata/Q[31:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4e0d1290"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="127"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q[7:0][27:24]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_rd_id/Q[3:0]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="59ccf670"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="166"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q[7:0][32]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="54a4ac70"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiDockWidgetDisplay -dock widgetDock_ActivityView;
verdiSetRCValue -section appSetting -key font -value {Bitstream Vera Sans(11)};
setStyleFvProgress -css {font-family:Bitstream Vera Sans monospace;font-size:11px}
setStyleFvGoalProgress -css {font-family:Bitstream Vera Sans monospace;font-size:11px}
verdiSetFont -font "Bitstream Vera Sans" -size "11"
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="140"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_pending/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="4de756e0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetPrefEnv -bDockNewCreatedWindowInContainer on ; verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType "on" ; opVerdiComponents -xmlfile {/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml} ;set __fvactiveNSchema [schGetCurrentWindow] ;
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

opVerdiComponents -xmlstr {<?xml version="1.0"?><Command delimiter="/" born_src="Spyglass" name="schLegendInfo" id="154"><LegendInfo isShow="on"><Description description="&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q[7:0][28]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q[1]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;" /><Legends><Legend name="Source" shape="box" style="solid" color="#800080" fill="1" /><Legend name="Crossing Path" shape="box" style="solid" color="#FF8000" fill="1" /><Legend name="Destination" shape="box" style="solid" color="#BE8042" fill="1" /><Legend name="Potential Qualifier" shape="box" style="solid" color="#008000" fill="1" /><Legend name="Debug Info" shape="box" style="solid" color="#5BA5A5" fill="1" /><Legend name="Partially visible Net(s)" shape="line" style="dash" fill="0" /><Legend name="Diveable Instance" shape="box" style="dash-dot" color="white" fill="1" /><Legend name="Virtual Group" shape="box" style="dash" color="white" fill="1" /><Legend name="Blackbox Module" shape="box" style="solid" color="#A0A0A0" fill="1" /><Legend name="Encrypted Module" shape="box" style="solid" color="#BEBE42" fill="1" /><Legend name="Abstracted view of IP" shape="box" style="dash-dot" color="#800000" fill="1" /><Legend name="Constrained object" shape="icon" icon="constraint.png" fill="0" /></Legends></LegendInfo></Command>}
::vcst::dockCurrentSchematic
opVerdiComponents -xmlfile {vcst_rtdb/.internal/verdi/crmrln.xml}
opVerdiComponents -xmlstr { <Command name="schSession" delimiter="/" verdiWin="531afcf0"><HighlightObjs><H_Ports><H_Port name="m_vlsi_qspi_top/i_aclk" icon="cipl,#ff0000" /><H_Port name="m_vlsi_qspi_top/i_qspi_clk" icon="cipl,#ff0000" /></H_Ports><H_Pins><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/D[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_w_bresp/OUT[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/OUT[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D1[1:0]" text="2'bx0" icon="" /><H_Pin name="m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D0[1:0]" text="2'bx0" icon="" /></H_Pins></HighlightObjs></Command> } ;set __fvactiveNSchema [schGetCurrentWindow]
if {[info exists __fvactiveNSchema]} {unset __fvactiveNSchema}
verdiGetVcstCmdResult -xmlstr {<Command name="action" received="1"></Command>}

verdiGetVcstCmdResult -xmlstr {<Command name="action" status="1"></Command>}

verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+300};
verdiSetRCValue -section appSetting -key violColWidths -value {CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ,+385|CDC_COHERENCY_RECONV_COMB,+353|CDC_COHERENCY_RECONV_SEQ,+353|CDC_UNSYNC_DATA,+385};
