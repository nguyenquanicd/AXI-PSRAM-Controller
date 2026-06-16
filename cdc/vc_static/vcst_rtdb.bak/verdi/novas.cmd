#
# Verdi - VC Static integration
#================================================================================

# Setup Verdi Namespace:
#--------------------------------------------------------------------------------
namespace eval ::vcst {

    # State:
    #--------------------------------
    variable _masterMode false
    variable _minimized  false
    variable _rtdbDir    ""
    variable _hiddenDir  ""
    variable _top        ""
    variable _v2kConfig  ""
    variable _libArgs    ""
    variable _elab       ""
    variable _switches   ""
    variable _sva        ""
    variable _fsdb       ""
    # Exception: no "_" for actualFsdb:
    variable actualFsdb ""
    variable _propClass  ""
    variable _propType   ""
    variable _propLoc    ""
    variable _propExpr   ""
    variable _traceType  ""
    variable _curWaveVw  ""
    variable _wvContainer "x"
    variable _marker     ""
    variable _assrtInfo  ""
    variable _elabOpts   ""
    variable _workLib    ""
    variable _seqXmlFile ""
    variable _upfOpts    ""
    variable _enableKdb  ""
    variable _simBinPath ""
    variable _goldenUpfConfig  ""
    variable _powerDbDir ""
    variable _saveLpLib ""
    variable _strategyFilePath ""
    variable _bRestore ""
    variable _seq_saved ""
    variable _cov_seq_1src_saved ""
    variable _cov_seq_2src_saved ""
    variable _resetEnd 0
    variable _traceCount 0;
    variable _nldmNschema  ""
    variable _analyzerStartTime true
    variable _analyzerStartTimePlus1 false
    variable _kdbAlias ""
    variable _covDut ""
    variable dockSchematicInContainer 1
    variable _splitbus ""
    variable _navTarget ""
    variable _navLastTarget ""
    variable _sysWarnEnable 1
    variable _primaryFsdbAutoChange 1
    variable _smartLoad ""
    variable _currentActWinIsUDW 0
    variable _noVDACgroupSuffix ""
    variable _noVDACnewWin 0
    variable _noVDACstartTime -1
    variable _enableVnrWriteKdb ""
    variable _enableVnrWriteKdbResolve ""
    variable _bIsFormalFlow ""
    variable _bGlobalFsdbPresent 0
    variable _sRunModes ""
    variable _isAssertMatch 0
    variable _signalsCC ""
    variable _latencyParamsCC ""
    variable _schWinList {}
    variable _constRegList ""
    variable _prevConstRegList ""
    variable _winRegMap ""
    variable _schWindowList {}
    variable _unusedRegList ""
    variable _scenarioList ""
    variable _prevUnusedRegList ""
    variable _windowRegMap ""
    variable _windowScenarioMap ""
    variable _windowViolIdMap ""
    variable _disableSymbolLibraryImportMessage ""
    variable _enableKdbRemoval ""
    variable _lintImplMode ""
    # Functions:
    #--------------------------------
    proc vars {} {
        return "
  _masterMode: $::vcst::_masterMode
  _minimized:  $::vcst::_minimized
  _rtdbDir:    $::vcst::_rtdbDir
  _hiddenDir:  $::vcst::_hiddenDir
  _top:        $::vcst::_top
  _v2kConfig:  $::vcst::_v2kConfig
  _libArgs:    $::vcst::_libArgs
  _elab:       $::vcst::_elab
  _switches:  $::vcst::_switches
  _sva:        $::vcst::_sva
  _fsdb:       $::vcst::_fsdb
  _bGlobalFsdbPresent: $::vcst::_bGlobalFsdbPresent 
  _sRunModes: $::vcst::_sRunModes 
  _schWinList: $::vcst::_schWinList
  _constRegList: $::vcst::_constRegList
  _winRegMap: $::vcst::_winRegMap
  _prevConstRegList: $::vcst::_prevConstRegList
  _schWindowList: $::vcst::_schWindowList
  _unusedRegList: $::vcst::_unusedRegList
  _scenarioList: $::vcst::_scenarioList
  _prevUnusedRegList: $::vcst::_prevUnusedRegList
  _windowRegMap: $::vcst::_windowRegMap
  _windowScenarioMap: $::vcst::_windowScenarioMap
  actualFsdb: $::vcst::actualFsdb
  _propClass:  $::vcst::_propClass
  _propType:   $::vcst::_propType
  _propLoc:    $::vcst::_propLoc
  _propExpr:   $::vcst::_propExpr
  _traceType:  $::vcst::_traceType
  _curWaveVw:  $::vcst::_curWaveVw
  _wvContainer:  $::vcst::_wvContainer
  _marker      $::vcst::_marker
  _assrtInfo:  $::vcst::_assrtInfo
  _elabOpts:   $::vcst::_elabOpts
  _workLib:    $::vcst::_worklib
  _seqXmlFile: $::vcst::_seqXmlFile
  _upfOpts:    $::vcst::_upfOpts
  _enableKdb:  $::vcst::_enableKdb
  _simBinPath: $::vcst::_simBinPath
  _goldenUpfConfig:  $_goldenUpfConfig
  _powerDbDir:  $::vcst::_powerDbDir
  _saveLpLib: $::vcst::_saveLpLib
  _strategyFilePath: $::vcst::_strategyFilePath
  _bRestore: $::vcst::_bRestore
  _seq_saved $::vcst::_seq_saved
  _cov_seq_1src_saved $::vcst::_cov_seq_1src_saved
  _cov_seq_2src_saved $::vcst::_cov_seq_2src_saved
  _resetEnd  $::vcst::_resetEnd
  _traceCount $::vcst::_traceCount
  _nldmNschema: $::vcst::_nldmNschema
  _analyzerStartTime: $::vcst::_analyzerStartTime
  _analyzerStartTimePlus1 $::vcst::_analyzerStartTimePlus1
  _kdbAlias: $::vcst::_kdbAlias
  _covDut: $::vcst::_covDut
  dockSchematicInContainer: $::vcst::dockSchematicInContainer
  _splitbus: $::vcst::_splitbus
  _smartLoad: $::vcst::_smartLoad
  _noVDACgroupSuffix $::vcst::_noVDACgroupSuffix
  _noVDACnewWin $::vcst::_noVDACnewWin
  _noVDACstartTime $::vcst::_noVDACstartTime
  _enableVnrWriteKdb $::vcst::_enableVnrWriteKdb
  _enableVnrWriteKdbResolve $::vcst::_enableVnrWriteKdbResolve
  _bIsFormalFlow $::vcst::_bIsFormalFlow 
  _isAssertMatch $::vcst::_isAssertMatch
  _latencyParamsCC $::vcst::_latencyParamsCC
  _signalsCC $::vcst::_signalsCC
  _sysWarnEnable $::vcst::_sysWarnEnable
  _disableSymbolLibraryImportMessage $::vcst::_disableSymbolLibraryImportMessage
  _enableKdbRemoval $::vcst::_enableKdbRemoval
  _lintImplMode: $::vcst::_lintImplMode

  Procedures:
    loadMainWin
    setupMenus
    hideUnrelatedMenus
    setupNWConeMenus
    dupWaveVw
    testTracePath
    cleanOldFsdb
    wvOpenFsdb
    schRegisterGlobalWfMenu
    showDebugViews
    setupSvaDebug
    analyzerShowFirstSuccess
    addMarker
    removeMarker
    addResetMarker
    removeResetMarker
    dockCurrentSchematic
    createNewWvWin
    dockWvWin
    constRegTrace
    addConstRegList
    addSchWinList
    schematicPrint
    llmClientLoad
    llmClearChatHistory
    sendVcfCmd
    sendCmdToStaticUnode
    sendCmdToStaticUnodeForRegr

  Event Callbacks:
    dblClkCB
        "
    }

    #===============================================================================
    # Verdi Actions:
    #       qwAction ... -invisible/-enabled/-disabled

    proc showSourceCodeFromInfoView { instName } {
        #fix blackbox signal linking usability:
        #if instance is in blackbox, find the scope and use "srcShowCalling"
        if { [info commands srcIsBlackbox] != "" && [srcIsBlackbox -inst $instName] } {
            #instName is in BlackBox -> get scope name"
            set scopeName [srcGetObjScope $instName]
            if { $scopeName != "" } {
                srcShowCalling $scopeName
                return 1
            }
        }

        while { [ srcShowDefine -incrSearch $instName ] == 0 }  {   
            set idx [ string last "." $instName ]
            if { $idx <= 0 } {
                return 0
            }
            set idx [expr $idx-1]
            set instName [string range $instName 0 $idx]
        }
        verdiRunVcstCmd "___vcstCommandLog {verdi_cmd srcShowDefine -incrSearch $instName}"
        return 1
    }
    
    proc showSourceForFsmProperty { instName reg line signal } {
        # fsm property needs special process because verdi may can't recognize its name
        while { [ srcShowDefine -incrSearch $instName ] == 0 }  {   
            set idx [ string last "." $instName ]
            if { $idx <= 0 } {
                return 0
            }
            set idx [expr $idx-1]
            set instName [string range $instName 0 $idx]
        }
        set instName "$instName.$reg"
        srcShowDefine -incrSearch $instName
        srcDeselectAll -win $::_nTrace1 
        srcGotoLine $line -win $::_nTrace1
        if { [srcSelect -signal $signal -line $line -pos 1 -win $::_nTrace1] == 0 } {
            srcSelect -win $::_nTrace1 -range "$line $line"
        }
    }

    proc isCurrentFileCorrect { absPath relPath } {
        set currentFile [ srcGetCaretFile ]
        if { [string equal $currentFile $absPath] } {
            return 1
        } elseif { [string equal $currentFile $relPath] } {
            return 1  
        } else {
            return 0
        }
    }

    #===============================================================================
    # Verdi Actions:

    proc trySrcShowDefine { instName } {
        while { [ srcShowDefine -incrSearch $instName ] == 0 }  {
            set idx [ string last "." $instName ]
            if { $idx <= 0 } {
                return 0
            }
            set idx [expr $idx-1]
            set instName [string range $instName 0 $idx]
        }
        return 1
    }

    proc schematicPrint { win paper color file super signLoc printRegion design designer version descript copy header footer date autoDiv pageMode orientation scaleFac rowPage colPage thinBus sameAs printer } {
        set cmd "schPrint"
        set curSchWin [schGetCurrentWindow]

        if {$win ne "345234"} {
            append cmd " -win "
            append cmd $win
        } else {
            append cmd " -win "
            append cmd $curSchWin
        }

        if {$paper ne "345234"} {
            append cmd " -paper "
            append cmd $paper
        } else {
            append cmd " -paper A0"            
        }

        if {$color eq "1"} {
            append cmd " -color"
        }

        if { $file ne "345234" } {
            append cmd " -file \""
            append cmd $file
            append cmd "\""
        }

        if { $super eq "1"} {
            append cmd " -super"
        }

        if {$signLoc ne "345234"} {
            append cmd " -signLoc "
            append cmd $signLoc
        }

        if {$printRegion ne "345234"} {
            append cmd " -printRegion "
            append cmd $printRegion
        }

        if {$design ne "345234"} {
            append cmd " -design \""
            append cmd $design
            append cmd "\""
        }

        if {$designer ne "345234"} {
            append cmd " -designer \""
            append cmd $designer
            append cmd "\""
        }

        if {$version ne "345234"} {
            append cmd " -ver \""
            append cmd $version
            append cmd "\""
        }

        if {$descript ne "345234"} {
            append cmd " -descript \""
            append cmd $descript
            append cmd "\""
        }

        if {$copy ne "345234"} {
            append cmd " -copy "
            append cmd $copy
        }

        if {$header ne "345234"} {
            append cmd " -header \""
            append cmd $header
            append cmd "\""
        }

        if {$footer ne "345234"} {
            append cmd " -footer \""
            append cmd $footer
            append cmd "\""
        }

        if {$date ne "345234"} {
            append cmd " -date \""
            append cmd $date
            append cmd "\""
        }

        if {$autoDiv ne "345234"} {
            append cmd " -autoDiv "
            append cmd $autoDiv
        }

        if {$pageMode ne "345234"} {
            append cmd " -pageMode "
            append cmd $pageMode
        }

        if {$orientation ne "345234"} {
            append cmd " -orientation "
            append cmd $orientation
        }

        if {$scaleFac ne "345234"} {
            append cmd " -scaleFac "
            append cmd $scaleFac
        }

        if {$rowPage ne "345234"} {
            append cmd " -rowPage "
            append cmd $rowPage
        }

        if {$colPage ne "345234"} {
            append cmd " -colPage "
            append cmd $colPage
        }

        if {$thinBus ne "345234"} {
            append cmd " -thinBus "
            append cmd $thinBus
        }

        if {$sameAs ne "345234"} {
            append cmd " -sameAs "
            append cmd $sameAs
        }

        if {$printer ne "345234"} {
            append cmd " -printer \""
            append cmd $printer
            append cmd "\""
        }
        verdiRunVcstCmd verdi_cmd $cmd -no_wait
    
    }

    

    #===============================================================================
    # Verdi Actions:

    proc tryViewUpfFileLine { file line } {
        set upfFileLoaded [vcstIsUpfFileLoaded -file $file]
        if { $upfFileLoaded != "1" } {
            srcShowFile -file $file -line $line
            verdiShowWindow
            set cmd "action aaHierViewUpfCommandDone -trigger"
            verdiRunVcstCmd $cmd -no_wait 
            return 1
        }
        set cmd "action aaHierViewUpfFileLine -reset -file \{$file\} -line \{$line\} -trigger"
        verdiRunVcstCmd $cmd -no_wait 
        return 1
    }

    proc coiMarkEvent {} {
        source $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/coi.tcl
    }

    proc setupMenus {} {
        # Trace Views:
        qwConfig -type Verdi -cmds [list {
            qwRemoveMenuGroup -group "Debug"
        } {
            #qwRemoveMenuGroup -group "Window"
            #} {
            qwAction -name "Run Simulation" -invisible
        } {
            qwAction -name "Compile Design..." -invisible
        } {
            qwAction -name "VIA..." -invisible
        } {
            qwAction -name "UVM/OVM/VMM Debug" -invisible
        } {
            qwRemoveToolBarGroup -group "UVM/OVM/VMM Aware Debug"
        } {
            qwRemoveToolBarGroup -group "VIA Tool Bar"
        } {
            qwAddToolBarGroup -group "Static Debug"
        } ]

        # Wave Views:
        qwConfig -type nWave -cmds [list {
            qwAction -name "dupWaveVwAction" -text "(Duplicate this View)" -tcl ::vcst::dupWaveVw
        } {
            qwAddMenuAction -action "dupWaveVwAction" -group "File" -before "Open..."
        } {
            qwAction -name "coiMarkAction" -text "(Show Assertion COI View)" -tcl ::vcst::coiMarkEvent
        } {
            qwActionGroup -name "Static Debug" -actionNames {"coiMarkAction" "dupWaveVwAction"}
        } {
            qwAddToolBarGroup -group "Static Debug"
        } {
            qwRemoveMenuGroup -group "Analog"
        } {
            qwRemoveMenuGroup -group "ECO"
        } ]

        return "1"
    }

    proc hideUnrelatedMenus {} {
        #simple menu
        if {![info exist env(SNPS_VCS_INTERNAL_MONET_FV_BETA)]} {
            if {![info exist ::env(VERDI_SG_WORKMODE)]} {
                qwConfig -type Verdi -cmds [list {qwActionGroup -actionNames {"hbToggleParaAnnot"} -invisible -name ""}]
            }
            qwConfig -type Verdi -cmds [list {
                qwActionGroup -actionNames {"dbgToggleAnnotation" "hbToggleFuncAnnot" "dbgToggleLeadingZero"} -invisible -name ""
            } {
                qwRemoveMenuGroup -group "Upper Annotation"
            } {
                qwRemoveMenuGroup -group "User Defined Annotation"
            } {
                qwActionGroup -actionNames {"tfvVerdiPullDownTrXByPref" "tsBehaviorAnalysis"} -invisible -name ""
            } {
                qwActionGroup -actionNames {"schCreateWindowByECO" "schCreateWindowByEditSchSelected" "schCreateWindowByClockTree" "schCreateWindowByResetTree"} -invisible  -name ""
            } {
                qwAction -name "Summary View" -invisible      
            } {
                qwAction -name "Product Type" -invisible
            } {
                qwAction -name "Add Temporary Assertion" -invisible
            } {
                qwAction -name "UVM/OVM/VMM Aware Debug" -invisible
            } {
                qwAction -name "AMS" -invisible
            } {
                qwAction -name "Interactive" -invisible
            } {
                qwAction -name "Annotation" -invisible
            } {
                qwAction -name "Rewind" -invisible
            } {
                qwAction -name "Undo" -invisible
            } {
                qwAction -name "Reverse Debug" -invisible
            } {
                qwAction -name "Virtual Simulator" -invisible
            } {
                qwAction -name "Emulation" -invisible
            } {
                qwAction -name "Certitude" -invisible
            }  ]
        }
        return "1"
    }

    proc setupNWConeMenus {} {
        #Limit to LP
        if { ($::vcst::_powerDbDir != "") || ($::vcst::_goldenUpfConfig != "" && [file exists $::vcst::_goldenUpfConfig]) || ($::vcst::_upfOpts != "" && $::vcst::_upfOpts != " -upf ") } {
            qwConfig -type nWave -cmds [list {
                qwAction -name "wvViolationsCone" -text "Show VCLP Violations Cone" -tcl "::vcst::wvShowVCLPViolationsCone"
            } {
                qwAddMenuAction -action "wvViolationsCone" -group "Signal"
            } ]

            qwConfig -type nWave -cmds [list {
                qwAction -name "wvViolationsCone" -text "Show VCLP Violations Cone" -tcl "::vcst::wvShowVCLPViolationsCone"
            } {
                qwAddMenuAction -action "wvViolationsCone" -group "SignalPane"
            } ]
        }
        return "1"
    }

    proc wvShowVCLPViolationsCone {args} {
        #Get selected signals
        set signal [join [lreplace [split [wvGetSelectedPureSignals -win [wvGetCurrentWindow -active]] /] 0 0] .]
        #Get first signal name if there are more than one
        set sigName [lindex $signal 0]
        set type "net"
        ::vcst::showVCLPViolationsCone $sigName $type
    }

    proc setupCallbacks {} {
        AddEventCallback [tk appname] ::vcst::dblClkCB     wvDblClkWaveForm 1
        AddEventCallback  [tk appname] ::vcst::handleVerdiEvents schRMBClkObj 1
        AddEventCallback  [tk appname] ::vcst::handleVerdiEvents schCloseWindow 1
        AddEventCallback  [tk appname] ::vcst::handleVerdiEvents schCreateWindow 1
        AddEventCallback  [tk appname] ::vcst::handleVerdiEvents schDockFormState 1
        #AddEventCallback [tk appname] ::vcst::openSchemaCB schCreateWindow  1
        #AddEventCallback [tk appname] ::vcst::openWaveCB   wvCreateWindow   1

        # User Callback:
        #AddEventCallback [tk appname] ::vcst::myEventCB UDR_USER 1
        #qwConfig -type Verdi -cmds [list {
        #    qwAction -name "mycmd1" -text "My Command1" -tcl "EventTrigger UDR_USER USER_clientdata" 
        #} {
        #    qwActionGroup -name "mygrp1" -actionNames "mycmd1"
        #} {
        #    qwAddToolBarGroup -group "mygrp1" 
        #} ]

        return "1"
    }

    proc setupSimvKdbForLpImport {} {
        if {$::vcst::_powerDbDir != "" && $::vcst::_diucFlow != "true"} {
            # new flow to import powerDB, need to modify simv.kdb before debImport command
            if {![info exist ::env(SNPS_VERDI_VCLP_INTERNAL_DISABLE_NEW_FLOW)]} {  
                set simKdb "$::vcst::_rtdbDir/$::vcst::_hiddenDir/design/$::vcst::_simBinPath.daidir/simv.kdb"

                set filename $simKdb
                set temp     $filename.new
                set backup   $filename.bak

                if {[catch {set out [open $temp w]} errmsg]} {
                    set warnMsg "$errmsg. PowerDB import may fail."
                    verdiShowMessage -warn "$warnMsg"
                    return
                } else {
                    set in  [open $filename r]
                    set hasModified 0
                    set powerDb "POWERDB=$::vcst::_powerDbDir"
                    set lpOption "LP_OPTION=-powerModel VCST"
                    if {$::vcst::_strategyFilePath != "" && [file exists $::vcst::_strategyFilePath]} {
                        set lpOption "LP_OPTION=-powerModel VCST -strategy_association $::vcst::_strategyFilePath"
                    }

                    # line-by-line, read the original file
                    while {[gets $in line] != -1} {
                        if {$line == "\[Vclp\]"} {
                            incr hasModified
                        } elseif {[string first "POWERDB" $line] != -1} {
                            set line $powerDb
                            incr hasModified
                        } elseif {[string first "LP_OPTION" $line] != -1} {
                            set line $lpOption
                            incr hasModified
                        }
                        puts $out $line
                    }
                    if {$hasModified != 3} {
                        puts $out "\[Vclp\]"
                        puts $out $powerDb
                        puts $out $lpOption
                    }
                    close $in
                    close $out

                    # move the new data to the proper filename
                    file delete $backup
                    file rename -force $filename $backup
                    file rename -force $temp $filename 
                }
            }
        }
    }
    #===============================================================================
    proc loadMainWin { minimize } {
        set ::vcst::_minimized $minimize

        if { $minimize } {
            #verdiWindowResize -win Verdi_1 0 0 0 0
        }

        if { $::vcst::_kdbAlias == "true"} {
            set ::env(AUTOALIAS_ENUM_VALUES) 1
        }
        
        if { $::vcst::_disableSymbolLibraryImportMessage == "true"} {
            set ::env(SNPS_DISABLE_DUMP_SYMBOL_IMPORT_MESSAGE) 1
        }

        if { $::vcst::_enableVnrWriteKdb == "true"} {
            set ::env(SNPS_VERDI_VCLP_INTERNAL_DISABLE_NEW_FLOW) 1
        }

        if { [array exists ::vcst::propertyMap] } {
            array unset ::vcst::propertyMap
        }

        if { [array exists ::vcst::traceTypeMap] } {
            array unset ::vcst::traceTypeMap
        }

        if { [array exists ::vcst::winIdFsdbMap] } {
            array unset ::vcst::winIdFsdbMap
        }

        wvSetPreference -overwrite off
        wvSetPreference -getAllSignal off
        #verdiHideBanners -win Verdi_1 -on

        if { ! $::vcst::_masterMode } {
            ::vcst::setupMenus
        }
        ::vcst::setupNWConeMenus
        ::vcst::setupCallbacks
        ::vcst::setupSimvKdbForLpImport

        set cmd ""
        set goldenUpfFlow 0
        if {$::vcst::_masterMode && $::vcst::_bRestore ==""} {
            verdiLayoutFreeze
        }
        if { $::vcst::_nldmNschema == "true" } {
            #For NLDM->nSchema flow
            namespace inscope :: schUnifiedNetList -batchmode on
            #namespace inscope :: schSetPreference -detailRTL off
            #Change schematic preferences to match SpyGlass-Verdi integration
            #namespace inscope :: schSetPreference -modulePortName on
            namespace inscope :: schSetPreference -portName on
            namespace inscope :: schSetPreference -moduleName on
            namespace inscope :: schSetPreference -pinName on
            namespace inscope :: schSetPreference -instName on
        }
        if { $::vcst::_enableKdb != "true" } {
            if { $::vcst::_v2kConfig == "" } {
                set cmd "debImport \"-usevcs\" \"-top\" \"$::vcst::_top $::vcst::_elab\" \"$::vcst::_switches\" \"-path\" \{$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi\}"
            } else {
                set cmd "debImport \"-usevcs\" \"-top\" \"$::vcst::_v2kConfig $::vcst::_elab\" \"$::vcst::_switches\" \"-path\" \{$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi\}"
            }

            if { $::vcst::_workLib != "" } {
                set cmd "$cmd -lib $::vcst::_workLib"
            }
            foreach l $::vcst::_libArgs {
                set cmd "$cmd -L $l"
            }

            if { $::vcst::_elabOpts != "" } {
                set cmd "$cmd $::vcst::_elabOpts"
            }
            set cmd "$cmd +disable_message+C00371"

        } elseif {$::vcst::_diucFlow == "true"} {
            set cmd "debImport \"-diuc\""
            if { $::vcst::_powerDbDir != "" } {
                set cmd "$cmd \"-powerdb\" \"$::vcst::_powerDbDir\""
            } else {
                return "0"
            }
        } elseif {$::vcst::_enableVnrWriteKdb== "true"} {
            if {$::vcst::_enableVnrWriteKdbResolve == "false"} {
                set cmd "debImport \"-lib\" \"$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/work.lib++\" \"-top\" \"$::vcst::_top $::vcst::_elab\""
            } else {
                set cmd "debImport \"-elab\" \"$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/kdb.elab++\""
            }
        } else {
            if {[string index $::vcst::_simBinPath 0] == "/"} {
                set cmd "debImport \"-simflow\" \"-simBin\" \"$::vcst::_simBinPath\""
            } else {
                set cmd "debImport \"-simflow\" \"-simBin\" \"$::vcst::_rtdbDir/$::vcst::_hiddenDir/design/$::vcst::_simBinPath\""
            }
            if { $::vcst::_kdbAlias == "true"} {
                set cmd "$cmd -autoalias"
            }
        }

        if {$::vcst::_smartLoad == "true" || $::vcst::_smartLoad == "1"} {
            if {$::vcst::_enableVnrWriteKdb != "true" && $::vcst::_enableKdbRemoval != "true"} {
                set cmd "$cmd -smart_load_kdb"
            }
        }
        
        if {$::vcst::_enableKdbRemoval == "true" && [file exists $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/hier_save_xml.gz]} {
            set cmd "$cmd \"-hier_xml\" \"$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/hier_save_xml.gz\""
        }

        set hasLP 0
        if { $::vcst::_powerDbDir != "" } {
            set hasLP 1
            # powerDb also needs map file.
            if { $::vcst::_goldenUpfConfig != "" && [file exists $::vcst::_goldenUpfConfig] } {
                set cmd "$cmd -power_config $::vcst::_goldenUpfConfig"
            }
        } elseif { $::vcst::_goldenUpfConfig != "" && [file exists $::vcst::_goldenUpfConfig] } {
            set hasLP 1
            set goldenUpfFlow 1
            set cmd "$cmd -power_config $::vcst::_goldenUpfConfig"
        } elseif { $::vcst::_upfOpts != "" && $::vcst::_upfOpts != " -upf "} {
            set hasLP 1
            if {$::vcst::_saveLpLib != ""} {
                if {$::vcst::_bRestore == ""} {
                    set cmd "$cmd $::vcst::_upfOpts -saveLplib $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/kdb -powerModel VCST"
                } else {
                    set cmd "$cmd $::vcst::_upfOpts -lplib $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/kdb -powerModel VCST"
                }
            } else {
                set cmd "$cmd $::vcst::_upfOpts -powerModel VCST"
            }
        }

        if {$hasLP == 1 && $::vcst::_enableKdb != "true" &&  $::vcst::_workLib != "" && [file exists $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/lp_debug.xml]} {
            set cmd "$cmd -lp_xml $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/lp_debug.xml"
        }

        # Source VCST env file before loading UPF.
        if {$hasLP == 1 && [file exists $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/vcstEnv.tcl]} {
            catch {source $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/vcstEnv.tcl}
        }

        if {$::vcst::_splitbus == "true"} {
            set ::env(NOVAS_LIB_SPLITBUS) 1
        }

        namespace inscope :: $cmd

        #Since debLoadPDML will close all windows, we save current windows before debLoadPDML and restore them later as workaround 
        set idx 0
        if {$::vcst::_powerDbDir != "" && $::vcst::_bIsFormalFlow == "true" && $::vcst::_bRestore == "true" && $::vcst::_masterMode && [info exist ::env(SNPS_VERDI_VCLP_INTERNAL_DISABLE_NEW_FLOW)]} {
            set wvList [wvGetAllWindows]
            foreach win $wvList {
                set result [wvSaveSignal -win $win $::vcst::_rtdbDir/$::vcst::_hiddenDir/formal/formal_lp_restore_signals_$idx.rc]
                incr idx
            } 
        }

        if {$::vcst::_powerDbDir != ""} {
            if {$::vcst::_diucFlow != "true"} {
                # new flow to import powerDB
                if {![info exist ::env(SNPS_VERDI_VCLP_INTERNAL_DISABLE_NEW_FLOW)]} {  
                    # do nothing
                } else {
                    if {$::vcst::_strategyFilePath != "" && [file exists $::vcst::_strategyFilePath]} {
                        namespace inscope :: debLoadPDML -powerModel VCST -powerdb $::vcst::_powerDbDir -strategy_association $::vcst::_strategyFilePath
                    } else {
                        namespace inscope :: debLoadPDML -powerModel VCST -powerdb $::vcst::_powerDbDir
                    }
                }
            }
        } else {
            if {$goldenUpfFlow == 1} {
                if {$::vcst::_saveLpLib != ""} {
                    if {$::vcst::_bRestore == "" } {
                        namespace inscope :: debLoadPDML -saveLplib $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/kdb -powerModel VCST
                    } else {
                        namespace inscope :: debLoadPDML -lplib $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/kdb -powerModel VCST
                    }
                } else {
                    namespace inscope :: debLoadPDML -powerModel VCST
                }
            } 
        }
        
        if {$idx > 0 && $::vcst::_powerDbDir != "" && $::vcst::_bIsFormalFlow == "true" && $::vcst::_bRestore == "true" && $::vcst::_masterMode && [info exist ::env(SNPS_VERDI_VCLP_INTERNAL_DISABLE_NEW_FLOW)]} {
            set count 0
            while { $count < $idx } {
                wvRestoreSignal $::vcst::_rtdbDir/$::vcst::_hiddenDir/formal/formal_lp_restore_signals_$count.rc -newWave
                incr count
            }
        }

        if {$hasLP == 1 && $::vcst::_top != ""} {
            verdiDockWidgetHide -dock widgetDock_PDML_SRC_TAB_1
            # to enable view_schematic icon
            srcCreateSourceTab -win {$_nTrace1}
            srcCloseSourceTab -win {$_nTrace1}
            verdiWidgetResize -dock widgetDock_<Message> -height 200
        }

        if {$::vcst::_diucFlow == "true"} {
            verdiDockWidgetDisplay -dock widgetDock_<Inst._Tree>
            verdiDockWidgetDisplay -dock widgetDock_PDML_SRC_TAB_1
            verdiDockWidgetDisplay -dock widgetDock_<Power_Domain_List>
        }
        #exec echo "$cmd" > debImport.log
        #debImport "-top" "work.$::vcst::_top $::vcst::_elab" -path $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -lib $::vcst::_libArgs

        # Check if in SEQ Mode:
        if { $::vcst::_seqXmlFile != "" } {
            if { [info commands verdiSetSeqDebug] == "verdiSetSeqDebug" } {
                if {$::vcst::_bRestore == ""} {
                    verdiLayoutFreeze -off
                    verdiSetSeqDebug -xml $::vcst::_seqXmlFile
                }
            }
        }

        if {$::vcst::_bRestore != ""} {
            verdiLayoutFreeze -off
        }

        # if {$hasLP == 1 && $::vcst::_bIsFormalFlow == "true"} {
        #     schSetVCSTDelimiter -hierDelim / 
        # }

	if {$hasLP == 1} {
		schSetPreference -PGPin off
	}

        # Disable some messages:
        catch {assCtrlMsg -disable IDM_ASS_W_SRC_REFRESH_FOR_FSDB_CHANGE}

        # Hide ToggleBookmarkGroup and AMSConfiguration icon after source tcl
        if {![info exist ::env(SNPS_VERDI_INTERNAL_NAVIGATOR)]} {
            qwConfig -type Verdi -cmds [list {
                qwAction -name "hbInvokeEuclide" -invisible
            } {
                qwAction -name "hbInvokeWave" -invisible
            } {
                qwAction -name "schCreateWindowByScopeGroup" -invisible
            } {
                qwAction -name "tsCreateSchemaGroup" -invisible
            } {
                qwAction -name "hbAMSConfiguration" -invisible 
            } {
                qwAction -name "ToggleBookmarkGroup" -invisible
            } ]

            verdiVcstMoveToolbarIcon -targetToolbar HB_IMPORT_COMMAND_PANEL -targetIcon hbInvokeSignalPane -destToolbar VC_APPS_TOOL_BOX -destIcon hbAMSConfiguration
        }

        return "1"
    }

    proc dupWaveVw {} {
        verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType \"on\" ;
        verdiSetPrefEnv -bDockNewCreatedWindowInContainer on 
        set ::vcst::_curWaveVw [wvGetCurrentWindow]
        verdiSetActWin -win $::vcst::_curWaveVw
        set newWaveVw [wvCreateWindow]
        wvSaveSignal -win $::vcst::_curWaveVw $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/signals.rc
        wvRestoreSignal -win $newWaveVw $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/signals.rc
        if { $::vcst::_wvContainer == "x"} {
            set ::vcst::_wvContainer [verdiDockToContainer -win $::vcst::_curWaveVw -newContainer]
        } else {
            verdiDockToContainer -win $newWaveVw -container $::vcst::_wvContainer
        }
        verdiHideBanners -win $::vcst::_wvContainer  -on
        verdiWindowRaise -win $::vcst::_wvContainer
    }

    proc testTracePath {} {
        set fsdb $::vcst::_fsdb
        set signalName [wvGetSelectedPureSignals -win [wvGetCurrentWindow -active]]
        while {[string match "*]" $signalName]} {
            set pos [string last "\[" $signalName]
            set pStr [string range $signalName $pos [string length $signalName]]
            if {[string first ":" $pStr] > 0} {
                set signalName [string range $signalName 0 $pos-1]
            } else {
                break
            }
        }
        set words [split $signalName "/"]
        set signalName [join $words "."]
        set signalName [string trimleft $signalName "."]
        if ([info exists ::env(SNPS_VCF_INTERNAL_TRACE_PATH_DEBUG)]) { 
            puts "verdiVcstTraceSignalPath -fsdb $::vcst::_fsdb -signal $signalName"
        }
        verdiVcstTraceSignalPath -fsdb $::vcst::_fsdb -signal $signalName
    }

    proc cleanOldFsdb {curWaveVw fsdb} {
        # Close file before overwritting it.
        set wvList [wvGetAllWindows]
        set closeList [list]
        foreach win $wvList {
            if {$win != $curWaveVw && [wvGetActiveFileName -win $win] == $fsdb} {
                lappend closeList $win
            }
        }

        foreach win $closeList {
            wvCloseFile -win $win $fsdb
            wvDeleteMarker -win $win -all

            if {[wvGetActiveFileName -win $win] == "" } {
                if { [expPropGetAttr -is_nav_wave $win] == 1} {
                    verdiShowMessage -warn {Navigator FSDB is overwritten! Please do replot if you want to use navigator.}
                } else {
                    # YZF: for UDWin, close the parent container
                    set pContainer [verdiGetAttribute -win $win -parentWin]
                    set winTitle [verdiGetAttribute -win $pContainer -title]
                    set idx [expr [string first "Unified Debug:" $winTitle]]

                    # Close old window as it's empty now.
                    wvCloseWindow -win $win
                    # If parent container is Unifed Debug Window, close it
                    if { $idx != -1 } {
                        verdiWindowClose -win $pContainer
                    }
                }
            }
        }
    }

    proc wvOpenFsdb {curWaveVw fsdb} {
        cleanOldFsdb $curWaveVw $fsdb

        wvOpenFile -win $curWaveVw $fsdb
        set ::vcst::_fsdb [file normalize $fsdb]
        set ::vcst::actualFsdb $::vcst::_fsdb
        expPropVcstDataUpdated -initFSDB $::vcst::_fsdb
        expPropVcstDataUpdated -actualFsdb $::vcst::_fsdb
        wvSetPrimaryWindow -win $curWaveVw
        if ([info exists ::env(SNPS_VCF_INTERNAL_TRACE_PATH_ENABLE)]) { 
            qwConfig -type Verdi -cmds [list {
                qwAction -name "testTraceAction" -text "Test Trace Path" -tcl ::vcst::testTracePath
            } {
                qwAddMenuAction -action "testTraceAction" -group "tsNWavePopUp" 
            }]
        }
    }

    proc showDebugViews {loop showAnalyzer showWave args} {
        if {$::vcst::_minimized} {
            #verdiWindowResize -win Verdi_1 100 200 1100 800
            #verdiWindowResize -win Verdi_1 100 200 1400 1000  # If Embeded...
            set ::vcst::_minimized false
        }

        # if not analyzer arg given, hide analyzer
        #if {!$showAnalyzer} {verdiDockWidgetHide -dock widgetDock_Analyzer}

        if {$showWave && $::vcst::_curWaveVw != ""} {
            # Remove old COI inst tree:
            catch {npiDlSym -func vacoi_exec_cmd -cmd CLOSE_INST_TREE}
            verdiDockWidgetSetCurTab -dock widgetDock_<Inst._Tree>
            if {$::vcst::_sva == ""} {
                qwAction -name "coiMarkAction" -disabled -id $::vcst::_curWaveVw
            } else {
                qwAction -name "coiMarkAction" -enabled -id $::vcst::_curWaveVw
            }

            wvSelectGroup -win $::vcst::_curWaveVw {G1}
            wvCut -win $::vcst::_curWaveVw

            ::vcst::removeMarker
            if { [expr $loop >= 0] } {
                if {[expr $::vcst::_resetEnd > 0]} {
                    # loop marker needs to be offset by resetEnd
                    ::vcst::addMarker "Loop-Start" [expr {$loop + $::vcst::_resetEnd}]
                } else {
                    ::vcst::addMarker "Loop-Start" $loop
                }
            }

            if { ! $::vcst::_masterMode } {
                wvResizeWindow  -win $::vcst::_curWaveVw 50 50 1000 500
                verdiShowWindow -win $::vcst::_curWaveVw
                #after 500 verdiWindowRaise -win $::vcst::_curWaveVw
            }

            # set panel widths
            wvSetSubWindow  -win $::vcst::_curWaveVw -signal 320 -value 160 

            #verdiProcessEvents
            #wvZoomAll -win $::vcst::_curWaveVw # does not work.
        }

        if {! $::vcst::_masterMode } { 
            verdiSetUpdatesEnabled -on
            verdiShowWindow -win Verdi_1 -normal
            verdiWindowRaise -win Verdi_1
        }

        if {$showWave} {
            verdiWindowRaise -win $::vcst::_curWaveVw
        }

        if {[llength $args] && [lindex $args 0] == "setupSource"} {
            verdiDockWidgetSetCurTab -dock widgetDock_<vc_activity>
        }

        return "1"
    }

    proc genAnalyzerPrefix {fsdbPath} {
        #for navigator, do the same logic of view_trace
        # Use ::vcst::_traceCount
        #if {[expPropGetAttr -is_nav_wave [wvGetCurrentWindow]] == 1} {
        #    incr ::vcst::_traceCount
        #    return "trace${::vcst::_traceCount}"
        #} else

        if { [info exists ::vcst::tracePrefixMap($fsdbPath)] == 0} {
            incr ::vcst::_traceCount
            set ::vcst::tracePrefixMap($fsdbPath) "trace${::vcst::_traceCount}"
        }
        return $::vcst::tracePrefixMap($fsdbPath);
    }

    proc addSvaScriptAssert {{newWin 0}} {
        assCtrlInvoke -svaIncremental
        #TODO: Add scope to fvassert. Currently all SVA script properties are
        # inside the top-level scope.
        AssIncreSVA -scope   "$::vcst::_top"
        AssIncreSVA -content "$::vcst::_sva : $::vcst::_propType property ($::vcst::_propExpr);"
        AssIncreSVACommit
        assCtrlClose -svaIncremental

        if {$newWin == 1 || [expPropGetAttr -is_nav_wave [wvGetCurrentWindow]] == 1} {
            set prefix [genAnalyzerPrefix $::vcst::_fsdb]
            set oldFile "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/${prefix}.evaluate_result.fsdb.vf"
            cleanOldFsdb [wvGetCurrentWindow] $oldFile

            set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -prefix "$prefix" -evalFsdbVfFirstPriority -skipActiveAnalyzer]
        } else {
            set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -evalFsdbVfFirstPriority -skipActiveAnalyzer]
        }
        set ::vcst::actualFsdb [debGetSimResult]
        set ::vcst::propertyMap($::vcst::actualFsdb) $::vcst::_sva

        expPropVcstDataUpdated -actualFsdb $::vcst::actualFsdb
        return $result
    }

    #  Determines whether to use assertion analyzer for a given property or
    #  not. We don't run assertion analyzer for properties containing
    #  $isunknown.
    #
    proc excludeFromAssertAnalysis { } {
        if {[string first "\$isunknown" $::vcst::_propExpr] != -1} {
            return true
        }
        #disable assert analysis in navigator 
        if {[expPropGetAttr -is_nav_wave $::vcst::_curWaveVw] == 1} {
            return true;
        }
        return false
    }

    proc reloadTraceFsdb { keyword assertInfo fsdb } {
        if { [string compare $keyword "match"] == 0 } {
            if { [string first "match" $assertInfo] == -1 && [string first "success" $assertInfo] == -1 } {
                set ::vcst::_isAssertMatch 0
                wvCloseFile -win $::vcst::_curWaveVw
                wvDeleteMarker -win $::vcst::_curWaveVw -all
                ::vcst::wvOpenFsdb $::vcst::_curWaveVw $fsdb 
                updatePropertyMap
                verdiDockWidgetHide -dock widgetDock_Analyzer              
            }               
        } elseif { [string first $keyword $assertInfo] == -1 } {
                set ::vcst::_isAssertMatch 0
                wvCloseFile -win $::vcst::_curWaveVw 
                wvDeleteMarker -win $::vcst::_curWaveVw -all
                ::vcst::wvOpenFsdb $::vcst::_curWaveVw $fsdb
                updatePropertyMap
                verdiDockWidgetHide -dock widgetDock_Analyzer              
        }     
    }

    proc selectSvaProperty { } {
        set selectSvaProp $::vcst::propertyMap($::vcst::actualFsdb)
        wvSelectSignal -signalname "$selectSvaProp" -delim .
    }

    proc setupSvaDebug { groupSuffix {newWin 0} {startTime -1} {svaRerun 0}} {
        if {[excludeFromAssertAnalysis]} {
            return 0
        }
        assCtrlMsg -disable IDM_ASS_W_SRC_REFRESH_FOR_FSDB_CHANGE

        if {$::vcst::_propClass == "script" && $::vcst::_propExpr  != ""} {
            #  For script properties we need to add a temporary property and
            #  then call the assertion analyzer on it.
            #
            set result [addSvaScriptAssert $newWin]
        } elseif {$newWin == 1 || [expPropGetAttr -is_nav_wave [wvGetCurrentWindow]] == 1} {
            set prefix [genAnalyzerPrefix $::vcst::_fsdb]
            set oldFile "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/${prefix}.evaluate_result.fsdb.vf"
            cleanOldFsdb [wvGetCurrentWindow] $oldFile

            if {$::vcst::_analyzerStartTimePlus1 && $startTime > 0} {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -prefix "$prefix" -time [expr $startTime + 1] -evalFsdbVfFirstPriority -skipActiveAnalyzer]
            } elseif {$::vcst::_analyzerStartTime && $startTime > 0} {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -prefix "$prefix" -time $startTime -evalFsdbVfFirstPriority -skipActiveAnalyzer]
            } else {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -prefix "$prefix" -evalFsdbVfFirstPriority -skipActiveAnalyzer]
            }
            set ::vcst::actualFsdb [debGetSimResult]
            set ::vcst::propertyMap($::vcst::actualFsdb) $::vcst::_sva

            expPropVcstDataUpdated -actualFsdb $::vcst::actualFsdb
        } else {
            if {$::vcst::_analyzerStartTimePlus1 && $startTime > 0} {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -time [expr $startTime + 1] -evalFsdbVfFirstPriority -skipActiveAnalyzer]
            } elseif {$::vcst::_analyzerStartTime && $startTime > 0} {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -time $startTime -evalFsdbVfFirstPriority -skipActiveAnalyzer]
            } else {
                set result [assertAnalysis -name $::vcst::_sva -fsdb $::vcst::_fsdb -dir $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi -evalFsdbVfFirstPriority -skipActiveAnalyzer] 
            }
            set ::vcst::actualFsdb [debGetSimResult]
            set ::vcst::propertyMap($::vcst::actualFsdb) $::vcst::_sva

            expPropVcstDataUpdated -actualFsdb $::vcst::actualFsdb
        }

        set ::vcst::_isAssertMatch 1 
        if {$::vcst::_propType == "assert"} {
            if {$::vcst::_traceType == "witness" || $::vcst::_traceType == "vacuity"} {
                set assrtInfo [abvGetAssertionInfo -assert -name $::vcst::_sva -success]
                reloadTraceFsdb match $assrtInfo $::vcst::_fsdb
            } else {
                #property 
                set assrtInfo [abvGetAssertionInfo -assert -name $::vcst::_sva -failure]
                reloadTraceFsdb failure $assrtInfo $::vcst::_fsdb
            }
        } else {
            set assrtInfo [abvGetAssertionInfo -cover -name $::vcst::_sva -success]
            reloadTraceFsdb match $assrtInfo $::vcst::_fsdb
        }
        if { $result == "1" && !$svaRerun && $::vcst::_isAssertMatch == "1"} {
            wvAddSignal -fromVCST -win $::vcst::_curWaveVw $::vcst::_sva -delim .
            if {$::vcst::_curWaveVw != ""} {
                set propClass "SOURCE"
                if {$::vcst::_propClass == "script"} {
                    set propClass "SCRIPT"
                }
                if {$groupSuffix == "0"} {
                    wvRenameGroup -win $::vcst::_curWaveVw {G1} $propClass-Property
                } else {
                    wvRenameGroup -win $::vcst::_curWaveVw {G1} $propClass-Property-$groupSuffix
                }
            }
            return 1
        }

        #assertAnalysisReport (return error report)
        return 0
    }

    proc analyzerShowFirstSuccess {} {
        #search for success
        set timeStr [::vcst::getSvaBeginEndTime success]
        if { [llength $timeStr] == 2 } {
            set startTime [lindex $timeStr 0]
            set endTime [lindex $timeStr 1]

            #show analyzer at successCursor
            if { $startTime != "" } {
                srcAssertDebOpen -AssertName $::vcst::_sva -beginTime $startTime -endTime $endTime -TraceResult 1
            }
        }
    }

    proc getSvaBeginEndTime { searchMode } {
        #searchMode can be success or failure
        set result []
        wvSetSearchMode -win $::vcst::_curWaveVw -$searchMode
        wvSearchNext -win $::vcst::_curWaveVw
        #get startTime and endTime
        set valStr [lindex [wvGetCurValueString -delim . $::vcst::_sva] 0]
        set startIdx [string first , $valStr]
        set endIdx [string first ) $valStr]        
        if { $startIdx > 0 && $endIdx > 0 } {
            set startTime [string range $valStr 1 $startIdx-1]
            set endTime [string range $valStr $startIdx+1 $endIdx-1] 
            set result [list $startTime $endTime]
        }
        #reset search type
        wvSetSearchMode -win $::vcst::_curWaveVw -anyChange
        return $result
    }
    
    proc highLightLatencyParamsForCC {} {
        #params {cycle pathDealy enableDelay enableHold}
        set cycle [lindex $::vcst::_latencyParamsCC 0]
        set pathDelay [lindex $::vcst::_latencyParamsCC 1]
        set enableHold [lindex $::vcst::_latencyParamsCC 2]
        set enableDelay [lindex $::vcst::_latencyParamsCC 3]
        #puts "$cycle, $pathDelay, $enableHold,$enableDelay"

        set signalList $::vcst::_signalsCC
        set lastInd [string last "\}" $signalList]

        set timeStr [::vcst::getSvaBeginEndTime failure]
        if { [llength $timeStr] == 2 } {
            set startTime [lindex $timeStr 0]
            set endTime [lindex $timeStr 1]
        }

        if { $endTime != "" } {
            set startTime [expr $endTime - $pathDelay*$cycle]
            set enableStartTime [expr $startTime + $enableDelay*$cycle]
            set enableEndTime [expr $enableStartTime + $enableHold*$cycle]
            #puts "$startTime $enableStartTime $enableEndTime"

            #FSDB time range 
            set fsdbTimeRangeStr [wvGetFileTimeRange -win $::vcst::_curWaveVw]
            set strItem [split $fsdbTimeRangeStr " "]
            set fsdbEndTime [lindex $strItem 1]

            if { $enableEndTime > $fsdbEndTime } {
                set enableEndTime $fsdbEndTime
            }
            
            if { $startTime >=0 } {
                set typeList {src dest enable}
                foreach ty $typeList {
                    set indexa [string first -$ty $signalList]
                    if { [expr $indexa != -1] } {
                        set indexb [string first "\}" $signalList ]
                        set item [string range $signalList $indexa $indexb]
                        set signalList [string range $signalList $indexb+2 $lastInd]
                    }
                    if { $item == "" } {
                        continue
                    }
                    #src, dest, enable 
                    set sIndex [string first " \{ " $item] 
                    set eIndex [string first " \}" $item]
                    set sigs [string range $item $sIndex+3 $eIndex]
                    if { [string first ", " $sigs] != -1 } {
                        set sigs [split $sigs ", "]
                    }
                    foreach i $sigs {
                        set fullname "/$::vcst::_top/$i"
                        if { $i != "" } {
                            if { $ty == "src" } {
                                wvCreateGridLine -win $::vcst::_curWaveVw -color yellow4 -pattern REV_TRIANGLE -forDarkMode $fullname $startTime
                            }
                            if { $ty == "dest" } {
                                wvCreateGridLine -win $::vcst::_curWaveVw -color red4 -pattern TRIANGLE -forDarkMode $fullname $endTime
                            }
                            if { $ty == "enable" } {
                                wvCreateOverlapValue -win $::vcst::_curWaveVw -color ID_BLUE4 -forDarkMode $fullname "$enableStartTime $enableEndTime enable"
                            }
                        }
                    }
                }
            }
        }         
    }
    
    proc setupSvaDebugOld { groupSuffix } {
        # Create Assertion fsdb:
        #-----------------------
        AssEvalSelect -deselectAll
        AssEvalSelect -select $::vcst::_sva
        psmSetOptions -no_success 1 -flag_race 0 -no_filter 1 -no_cov_fail_filter 1 -Store_Item Assert -reset_filter 1 -display 0
        psmCommitAssertions

        # run evaluator and create result fsdb + virtual file to merge trace + results
        catch {vdac $::vcst::_fsdb -o $::vcst::_fsdb.eval -write 2} result
        if {[string match *error* $result]} { 
            verdiDockWidgetHide -dock widgetDock_Analyzer
            return 0 
        }

        # create virtual file with both fsdb files
        assToolBuildVirFile -virtualFile $::vcst::_fsdb.vf -fileNum 2 -FileList $::vcst::_fsdb $::vcst::_fsdb.eval

        # load generated fsdb
        debCloseSimResult -IsShowWarn 0
        debLoadSimResult $::vcst::_fsdb.vf

        # Build Analyzer Pane:
        #---------------------
        # retrieve information about the assertion
        if {$::vcst::_propType == "assert"} {
            if {$::vcst::_traceType == "witness"} {
                set ::vcst::_assrtInfo [abvGetAssertionInfo -assert -name $::vcst::_sva -success]
            } else {
                set ::vcst::_assrtInfo [abvGetAssertionInfo -assert -name $::vcst::_sva -failure]
            }
        } else {
            set ::vcst::_assrtInfo [abvGetAssertionInfo -cover -name $::vcst::_sva -success]
        }
        if { $::vcst::_assrtInfo == "There isn't matched thread." } { 
            verdiDockWidgetHide -dock widgetDock_Analyzer
            return 0 
        }

        set vcst_from [lindex $::vcst::_assrtInfo 1]
        set vcst_to   [lindex $::vcst::_assrtInfo 2]

        # setup the views
        assCtrlInvoke -statistic
        srcAssertSetOpt -addSigToWave 1 -addSigWithExpGrp 1 -maskWave 0 -ShowCycleInfo 1
        AssertStatistics -options -addSelectedProp on
        verdiDockWidgetHide -dock widgetDock_Statistics
        verdiDockWidgetHide -dock widgetDock_Analyzer
        simSetSimMode on
        AssertStatistics -propDetails -deleteAll
        if {$::vcst::_propType == "assert"} {
            AssertStatistics -fsdbStatistics -selectCell $::vcst::_fsdb.vf Assert Fsdb
        } else {
            AssertStatistics -fsdbStatistics -selectCell $::vcst::_fsdb.vf Cover Fsdb
        }

        AssertStatistics -options -filterAll on
        AssertStatistics -fsdbStatistics -addSignal
        AssertStatistics -propDetails -expand $::vcst::_fsdb.vf $::vcst::_sva
        AssertStatistics -propDetails -expand $::vcst::_fsdb.vf $::vcst::_sva success
        AssertStatistics -propDetails -expand $::vcst::_fsdb.vf $::vcst::_sva failure
        AssertStatistics -propDetails -expand $::vcst::_fsdb.vf $::vcst::_sva match

        # select the falsification and show the analyzer
        if {$::vcst::_propType == "assert"} {
            if {$::vcst::_traceType == "witness"} {
                AssertStatistics -propDetails -selectRow $::vcst::_fsdb.vf $::vcst::_sva $vcst_from $vcst_to success
            } else {
                AssertStatistics -propDetails -selectRow $::vcst::_fsdb.vf $::vcst::_sva $vcst_from $vcst_to failure
            }
        } else {
            AssertStatistics -propDetails -selectRow $::vcst::_fsdb.vf $::vcst::_sva $vcst_from $vcst_to match
        }

        AssertStatistics -propDetails -activeTrace

        if {$::vcst::_traceType != "vacuity"} {
            verdiDockWidgetDisplay -dock widgetDock_Analyzer
            #verdiDockWidgetSetCurTab -dock widgetDock_Analyzer # For 14.03 use -dockWidget instead of -dock
        }

        if {$::vcst::_curWaveVw != ""} {
            if {$groupSuffix == "0"} {
                wvRenameGroup -win $::vcst::_curWaveVw {G1} SOURCE-Property
            } else {
                wvRenameGroup -win $::vcst::_curWaveVw {G1} SOURCE-Property-$groupSuffix
            }
        }

        return 1
    }

    proc addMarker { label t } {
        if {![expr $t < 0]} {
            wvSetMarker -fix -win $::vcst::_curWaveVw -name $label $t ID_RED5 line_solid
            set ::vcst::_marker $label
        }
        return 1
    }

    proc removeMarker {} {
        if { $::vcst::_marker != "" } {
            if {$::vcst::_sysWarnEnable == 1} {
                sysWarnEnable -disable
            }
            wvDeleteMarker -win $::vcst::_curWaveVw $::vcst::_marker
            if {$::vcst::_sysWarnEnable == 1} {
                sysWarnEnable -enable
            }
            set ::vcst::_marker ""
        }

        return 1
    }

    proc addResetMarker { t } {
        if {![expr $t < 0]} {
            wvSetMarker -fix -win $::vcst::_curWaveVw -name "Rst-End" $t ID_PURPLE5 line_solid
            wvSetMarkerOption -win $::vcst::_curWaveVw -adjacent on
            if {$t > 0} {
                wvAddCompressTimeRange -win $::vcst::_curWaveVw 0 $t left
                wvExpandCompressTimeRange -win $::vcst::_curWaveVw 0 $t left
                set ::vcst::_resetEnd $t
            }
        }
        return 1
    }

    proc createNewWvWin { } {
        set ::vcst::_curWaveVw [wvCreateWindow]
    }

    proc dockWvWin { id } {
        verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType \"on\" ;
        verdiSetPrefEnv -bDockNewCreatedWindowInContainer on 
        set ::vcst::_curWaveVw [wvGetCurrentWindow]
        verdiSetActWin -win $::vcst::_curWaveVw
        if {$id == "g:"} {           
            verdiWindowPrependTitle -win $::vcst::_curWaveVw             
        } else {                 
            verdiWindowPrependTitle -win $::vcst::_curWaveVw -preTitle $id               
        }
        if { $::vcst::_wvContainer == "x"} {
            set ::vcst::_wvContainer [verdiDockToContainer -win $::vcst::_curWaveVw -newContainer]
        } else {
            verdiDockToContainer -win $::vcst::_curWaveVw -container $::vcst::_wvContainer
        }
        verdiHideBanners -win $::vcst::_wvContainer  -on
        verdiWindowRaise -win $::vcst::_wvContainer
    }

    proc removeResetMarker { } {
        wvDeleteMarker -win $::vcst::_curWaveVw  "Rst-End"
        if {$::vcst::_resetEnd > 0} {
            if {$::vcst::_sysWarnEnable == 1} {
                sysWarnEnable -disable
            }
            wvDeleteCompressTimeRange -win $::vcst::_curWaveVw 0 $::vcst::_resetEnd
            if {$::vcst::_sysWarnEnable == 1} {
                sysWarnEnable -enable
            }
            set ::vcst::_resetEnd 0
        }
        return 1
    }

    # Get selected signals from verdi in a string:
    proc getSignalSet {} {
        set l1 ""
        foreach x [srcGetSelectSet] {
            if { [string first [lindex $x 0] 'signal'] == 1 } {
                set l1 "[join [lindex $x 2] |]";
                break;
            }
        }
        set l2 ""
        foreach x [srcSignalViewGetSelectSet] {
            if { [string first [lindex $x 0] 'signal'] == 1 } {
                set l2 "[join [lindex $x 2] |]";
                break;
            }
        }

        return "signalSet:|$l1|$l2";
    }

    proc llmClientLoad { data cluster} {
        if { $cluster eq "2" } {
            llmClientOpen -app_mode lint -cluster
        } else {
            llmClientOpen -app_mode lint
        }
        llmSetResult -diff -file $data 
    }

    proc llmClearChatHistory { } {
        llmSetResult -chat -json {{"data":[]}}
    }

    proc sendVcfCmd { data } {
        #set pattern "\\-doneAction\\s+(\\S+)"
        #set actionCommand ""
        #set updatedData ""
        #if {[regexp $pattern $data match actionCommand]} {
        #    set updatedData [regsub $pattern $data ""]
        #    set updatedData [string trim $updatedData]
        #} else {
        #    set updatedData $data
        #}
        verdiRunVcstCmd "$data"
    }

    proc sendCmdToStaticUnode { command } {
        set cmd "action aaMonetEvExecuteVcfCmdDone -command \{$command\} -cdconly -reset -trigger"
        verdiRunVcstCmd "$cmd"
    }

    proc sendCmdToStaticUnodeForRegr { args } {
        if { ![ info exists ::env(VERDI_ENABLE_ELECTRONIC_DEBUG_RECORD) ] } {
            return
        }
        set command [lindex $args 0]
        set id [lindex $args 1]
        set isverdi [lindex $args 2]
        append command " fmlregr" 
        set cmd "action aaMonetEvCaptureFmlRegrCmd -cmd \{$command\} -cmdId \{$id\} -isverdi \{$isverdi\} -reset -trigger"
        verdiRunVcstCmd "$cmd"
    }

    #================================(Callbacks)================================

    proc dblClkCB args {
        #puts "..................DblClkCB....................."
        #puts "@DblClkCB@ ... "
        #foreach i $args { puts $i }
        #proc dblClickWvSignal {} 
        # For AEPs show location with bookmark:
        if { $::vcst::_propClass == "aep" } {
            if { $::vcst::_propLoc != "" } {
                set f [split $::vcst::_propLoc ':']
                set file [lindex $f 0]
                set line [lindex $f 1]
                srcShowFile -file $file -line $line
                srcAddBookMark $file $line
                #srcAddBookMark -win $::_nTrace1 $file $line
                #srcSelect -win $_nTrace1 -range "$line $line"
                after 500 verdiWindowRaise -win $::_nTrace1
            }
        }
    }

    proc myEventCB args {
        puts "..................OK!!!..............."
        puts "@myEventCB@ ... "
        foreach i $args { puts $i }
    }

    proc openSchemaCB {p1 p2} {
        puts "..................OpenSchema....................."
        puts "@openSchemaCB@  $p1 $p2"
    }

    proc openWaveCB {p1 p2} {
        puts "..................OpenWave....................."
        puts "@openWaveCB@  $p1 $p2"
    }

    proc changeLayout {p1 p2} {
        global _Verdi_1
        set bNativeShell "0"
        if {![info exist ::env(SNPS_VCF_INTERNAL_OLD_SHELL)]} {
            if {[info exist ::env(SNPS_VCF_INTERNAL_NATIVESHELL)]} {
                set bNativeShell "1"
            }
        }
        if {$p1 == "COV_SEQ_1"} {
            verdiWindowSaveUserLayout -win $_Verdi_1 "verdi_cov_seq_1src_saved"
            set ::vcst::_cov_seq_1src_saved "1"
        } elseif {$p1 == "COV_SEQ_2"} {
            verdiWindowSaveUserLayout -win $_Verdi_1 "verdi_cov_seq_2src_saved"
            set ::vcst::_cov_seq_2src_saved "1"
        }
        if {$p2 == "COV_SEQ_1"} {
            if {$::vcst::_cov_seq_1src_saved == "1"} {
                verdiWindowRestoreUserLayout -win $_Verdi_1 "verdi_cov_seq_1src_saved"
            } else {
                verdiWindowWorkMode -win $_Verdi_1 -formalVerification
                if {$bNativeShell == "1" && $::vcst::_masterMode} {
                    verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
                }
                #verdiDockWidgetMove -dock widgetDock_VCF:GoalList -dock widgetDock_<Message>
                #verdiWidgetResize -dock widgetDock_<Message> -height 400
            }
        } elseif {$p2 == "COV_SEQ_2"} {
            if {$::vcst::_cov_seq_2src_saved == "1"} {
                verdiWindowRestoreUserLayout -win $_Verdi_1 "verdi_cov_seq_2src_saved"
            } elseif {$::vcst::_seq_saved == "1"} {
                verdiWindowRestoreUserLayout -win $_Verdi_1 "verdi_seq_saved"
            } else {
                verdiWindowWorkMode -win $_Verdi_1 -formalVerification
                if {$bNativeShell == "1" && $::vcst::_masterMode} {
                    verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
                }
                #verdiDockWidgetMove -dock widgetDock_VCF:GoalList -dock widgetDock_<Message>
                #verdiWidgetResize -dock widgetDock_<Message> -height 400
            }
        } else {
            #verdiWindowWorkMode -win $_Verdi_1 -formalVerification
            if {$bNativeShell == "1" && $::vcst::_masterMode} { 
                verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
            }
        }

        if {$p1 == "SEQ" && $p2 != "SEQ"} {
            verdiSeqDebug -off
        } elseif {$p1 != "SEQ" && $p2 == "SEQ"} {
            verdiSeqDebug -on
        }
        verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
    }

    proc setNonSEQLayout {} {
        global _Verdi_1
        verdiWindowWorkMode -win $_Verdi_1 -formalVerification
        if {![info exist env(SNPS_VCF_INTERNAL_OLD_SHELL)]} {
            if {[info exist env(SNPS_VCF_INTERNAL_NATIVESHELL)] && $::vcst::_masterMode == "1"} {
                verdiDockWidgetDisplay -dock windowDock_vcstConsole_2
            }
        }
    }
    proc dpvCppDbgRestoreSameFsdb { saveSignalFile } {
        set firstAddGroup 1
        set newContent ""
        set needRestoreSignal 0
        set file [open $saveSignalFile r]
        while { [gets $file line] != -1 } {
            if {[string match *$::vcst::_fsdb* $line]} {
                set needRestoreSignal 1
            }
            if {[regexp {^addGroup} $line]} {
                if {$firstAddGroup} {
                    #combine all signals into one new group OldTraceSignals
                    regsub {".*"} $line {"OldTraceSignals"} line
                    set firstAddGroup 0
                    append newContent "$line\n"
                }
            } else {
                append newContent "$line\n"
            }
        }
        close $file

        if {$needRestoreSignal} {
            set newFile [open $saveSignalFile w]
            puts $newFile $newContent
            close $newFile
            wvRestoreSignal $saveSignalFile
        }
    }

    proc schRegisterGlobalWfMenu {} {
        if {$::vcst::_bGlobalFsdbPresent == "true"} {
            if {$::vcst::_sRunModes eq "" } {
                qwConfig -type nSchema -cmds [list {
                    qwAction -name "schGlobalFsdbAct" -text "Waveform Viewer..." -tcl "::vcst::schOpenGlobalFSDB #"
                } {
                    qwAddMenuAction -action "schGlobalFsdbAct" -group "RightClickMenu" -before "Add to Waveform"
                } 
                ]
            } else {
                #Multiple modes available, create sub-menu
                foreach mode [split $::vcst::_sRunModes ,] {
                    qwConfig -type nSchema -cmds [list {
                        qwAction -name $mode -text $mode -tcl "::vcst::schOpenGlobalFSDB $mode"
                    } {
                        qwActionGroup -name "wfGrp" -actionNames $mode
                    } 
                    ]
                }
                qwConfig -type nSchema -cmds [list {qwAction -name "wfGrp" -text "Waveform Viewer"}]
                qwConfig -type nSchema -cmds [list {qwAddMenuAction -action "wfGrp" -group "RightClickMenu" -before "Add to Waveform"}]
            }
        }
    }

    proc schOpenGlobalFSDB {args} {
        set mode [lindex $args 0]
        set cmd "action aaMonetRdcOpenGlobalFSDB -mode $mode -trigger 50"
        verdiRunVcstCmd $cmd -no_wait 
    }

    # dock is already handled by 
    # verdiSetPrefEnv -bDockNewWindowInContainerWhenFindSameType \"on\" ;
    # verdiSetPrefEnv -bDockNewCreatedWindowInContainer on 
    # Now this proc is mainly for raising the schematic window in vcst first mode
    proc dockCurrentSchematic {} {
        if {$::vcst::dockSchematicInContainer != "0" && !$::vcst::_masterMode} {
            set currentWin [verdiGetActiveWindow]
            set parentWin [verdiGetAttribute -win  $currentWin -parentWinName]
            if { $parentWin == "Verdi_1" } {
                set container [verdiDockToContainer -win $currentWin -newContainer]
                verdiHideBanners -win $container  -on
                verdiWindowRaise -win $container
            } elseif { $parentWin != "0" } {
                verdiWindowRaise -win "$parentWin"
            } else {
                printDbgMsg "[Error] \"verdiGetAttribute -win  $currentWin -parentWinName\" returns 0, avoid to invoke verdiWindowRaise."
            }

            if {[info exist env(SNPS_VCS_INTERNAL_MONET_FV_BETA)]} {
                verdiDockWidgetSetCurTab -dock widgetDock_VCF:GoalList
            } else {
                verdiDockWidgetSetCurTab -dock widgetDock_vcstActivityView
            }
        }
    }

    proc verdi_vcst_clear_all_windows_locators {} {
        foreach w [schGetAllWindows] {
            schClearLocator -win $w
        }
    }

    proc hideViewForLP {} {
        if {[verdiGetPrefEnv -bPreserveVisiblesForWorkMode] == "0"} { 
            verdiDockWidgetHide -dock widgetDock_<Decl._Tree>
            verdiDockWidgetHide -dock widgetDock_<Inst._Tree>
            verdiDockWidgetHide -dock widgetDock_<Power_Domain_List>
        }
    }

    proc triggerX {} {
        set winId [wvGetCurrentWindow]
        set result [wvSelectSignal -win $winId {( "SECURITY-Property" 1 )}]
        if {$result == "0"} {
            wvSelectSignal -win $winId {( "XPROP-Property" 1 )}
        }
        set result [wvSearchNext -win $winId]
        if {$result == "0"} {
            set next 0
        } else {
            set next [lindex $result 1]
        }
        wvSelectSignal -win $winId {( "Root-Cause" 1 )}
        set signal [lindex [wvGetSelectedSignals -win $winId] 0]
        catch {tfgUpdateMarker -win $winId -time $next -sig $signal}
        set signal [join [lreplace [split [wvGetSelectedSignals -win $winId] /] 0 0] .]
        regsub -all {\[} $signal {\\[} signal
        regsub -all {\]} $signal {\\]} signal
        after 1000 tfgTrX -traceNonTrigX -showOnNWave -time $next $signal#T
    }

    proc updateMarker {} {
        set winId [wvGetCurrentWindow]
        set result [wvSelectSignal -win $winId {( "SECURITY-Property" 1 )}]
        if {$result == "0"} {
            wvSelectSignal -win $winId {( "XPROP-Property" 1 )}
        }
        set result [wvSearchNext -win $winId]
        if {$result == "0"} {
            set next 0
        } else {
            set next [lindex $result 1]
        }
        wvSelectSignal -win $winId {( "Root-Cause" 1 )}
        set signal [lindex [wvGetSelectedSignals -win $winId] 0]
        catch {tfgUpdateMarker -win $winId -time $next -sig $signal}
    }

    proc showConstraints {args} {
        set object [lindex $args 0]
        set type   [lindex $args 1]
        #puts "Inside showConstraints ($object, $type)"
        
        if { $type != "port" && $type != "net" && $type != "pin" } { 
            set cmd "action aaMonetNewConstraint -trigger"
        } else {
            set firstFullStopIndex [string first "." $object]
            set firstVCSTDelimIndex [string first "$::vcst::_vcstAppHierDelim" $object]

            #if no . or VCStatic delimiter found keep object as it is otherwise change
            if { [expr $firstFullStopIndex != -1] || [expr $firstVCSTDelimIndex != -1] } {
                
                set objectLen [string len $object]
                if {$firstVCSTDelimIndex < 0 } {
                    set firstVCSTDelimIndex $objectLen
                }
                
                if {$firstFullStopIndex < 0 } {
                    set firstFullStopIndex $objectLen
                }

                set firstDelimitterIndex $firstVCSTDelimIndex
                if { $firstFullStopIndex < $firstDelimitterIndex} {
                    set firstDelimitterIndex $firstFullStopIndex
                }

                set firstDelimitterIndex [expr $firstDelimitterIndex + 1]
                set object [string range $object $firstDelimitterIndex end]
            }

            set cmd "action aaMonetNewConstraint -trigger -obj \{$object\}"
        }
        verdiRunVcstCmd $cmd -no_wait 
    }

    proc showStructValue {args} {
        set object [lindex $args 0]
        set type   [lindex $args 1]
        set option [lindex $args 2]
        #puts "Inside showStructValue ($object, $type)"
        
        if { $type == "net" } {
            set firstFullStopIndex [string first "." $object]
            set firstVCSTDelimIndex [string first "$::vcst::_vcstAppHierDelim" $object]

            #if no . or VCStatic delimiter found keep object as it is otherwise change
            if { [expr $firstFullStopIndex != -1] || [expr $firstVCSTDelimIndex != -1] } {
                
                set objectLen [string len $object]
                if {$firstVCSTDelimIndex < 0 } {
                    set firstVCSTDelimIndex $objectLen
                }
                
                if {$firstFullStopIndex < 0 } {
                    set firstFullStopIndex $objectLen
                }

                set firstDelimitterIndex $firstVCSTDelimIndex
                if { $firstFullStopIndex < $firstDelimitterIndex} {
                    set firstDelimitterIndex $firstFullStopIndex
                }

                set firstDelimitterIndex [expr $firstDelimitterIndex + 1]
                set object [string range $object $firstDelimitterIndex end]
            }

            set curSchWin [schGetCurrentWindow]
            if {[catch { dict get $::vcst::_windowViolIdMap $curSchWin } errMsg]} {
                puts "error in dict get $errMsg"
            } else {
                set violId [dict get $::vcst::_windowViolIdMap $curSchWin]
                if {[string first "THRESHOLD" $option] !=-1} {
                    set cmd "action aaMonetOpenThresholdSelector -reset -option \{$option\} -obj \{$object\} -id \{$violId\} -trigger"
                    verdiRunVcstCmd $cmd -no_wait
                } else {
                    set cmd "action aaMonetLintShowStructValue2 -reset -trigger -option \{$option\} -obj \{$object\} -id \{$violId\}"
                    verdiRunVcstCmd $cmd -no_wait 
                }
            }
        }
    }

    proc showVCLPViolationsCone {args} {
        set object [lindex $args 0]
        set type   [lindex $args 1]

        # No need to convert here. Use new verdi command to get DC style name
        #set hierList [split $object .]
        #set hierList [lreplace $hierList 0 0]
        #if { [llength $hierList] > 0} {
        #    set object [join $hierList "/"]
        #}
        set object [verdiVcstToDcName -vname $object]

        set cmd "action aaMonetVCLPViolationsCone -trigger -obj \{$object\} -type \{$type\}"
        verdiRunVcstCmd $cmd -no_wait 
    }

    proc constRegTrace {args} {
        set object [lindex $args 0]
        set cmd "action aaMonetLintConstRegTrace -trigger -obj \{$object\}"
        verdiRunVcstCmd $cmd -no_wait 
    }

    proc addConstRegList {args} {
        set objectList [lindex $args 0]
        set ::vcst::_constRegList $objectList
        set curSchWin [schGetCurrentWindow]
         if {[catch { dict set ::vcst::_winRegMap $curSchWin $::vcst::_constRegList } errMsg]} {
            puts "error in dict set $errMsg"
        } else {
            dict set ::vcst::_winRegMap $curSchWin $::vcst::_constRegList
        }
    }

    proc addSchWinList { } {
        set curSchWin [schGetCurrentWindow]
        lappend ::vcst::_schWinList $curSchWin
        lappend ::vcst::_schWindowList $curSchWin
    }

    proc unusedRegTrace {args} {
        set object [lindex $args 0]
        set cmd "action aaMonetLintUnusedRegTrace -trigger -obj \{$object\}"
        verdiRunVcstCmd $cmd -no_wait 
    }

    proc addUnusedRegList {args} {
        set objectList [lindex $args 0]
        set ::vcst::_unusedRegList $objectList
        set curSchWin [schGetCurrentWindow]
        if {[catch { dict set ::vcst::_windowRegMap $curSchWin $::vcst::_unusedRegList } errMsg]} {
            puts "error in dict get $errMsg"
        } else {
            dict set ::vcst::_windowRegMap $curSchWin $::vcst::_unusedRegList
        }
    }

    proc setSchScenarioList {args} {
        set objectList [lindex $args 0]
        set ::vcst::_scenarioList $objectList 
    }

    proc showScenarioSelector { } {
        set curSchWin [schGetCurrentWindow]
        if {[catch { dict get $::vcst::_windowScenarioMap $curSchWin } errMsg]} {
            puts "error in dict get $errMsg"
        } else {
            set scenarios [dict get $::vcst::_windowScenarioMap $curSchWin]
            set cmd "action aaMonetSchScenarioSelector -trigger -sch_scenarios \{$scenarios\} -win \{$curSchWin\}"
            verdiRunVcstCmd $cmd -no_wait 
        }
    }

    proc handleVerdiEvents {args} {
        #puts "===============handleVerdiEvents($args)================="
        set evnt [lindex $args 0]
        switch $evnt {
            "schRMBClkObj" {
                set objectType [lindex $args 1]
                set contextObject [lindex $args 2]
                set pinName [lindex $args 3]

                variable type
                #Modify the nschema right click menu based on the design object type.
                switch $objectType {
                    "PORT"     { set type "port"} 
                    "INST"     { set type "instance"} 
                    "SIGNAL"   { set type "net"} 
                    "INSTPPIN" { set type "pin"}
                    "INSTPORT" { set type "pin"} 
                    default    { set type ""}
                }

                set multipleNets false

                if {"$contextObject" != ""} {
                    if {"$type" == "pin" && "$pinName" != ""} {
                        set contextObject "$contextObject$::vcst::_vcstAppHierDelim$pinName"
                    }
                    set multipleNets [expr {[string first "!@#$%" $contextObject] !=-1}]
                }

                #Add global fsdb menu for RDC (if exists)  
                schRegisterGlobalWfMenu

                set curSchWin [schGetCurrentWindow]

                if {[catch { dict get $::vcst::_windowScenarioMap $curSchWin } errMsg]} {
                    # puts "error in dict get $errMsg"
                } else {
                    set scenarios [dict get $::vcst::_windowScenarioMap $curSchWin]
                        if {$scenarios != ""} {
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "schScenario" -text "Scenario Selector..." -tcl "::vcst::showScenarioSelector" -visible
                            } {
                                qwAddMenuAction -action "schScenario" -group "RightClickMenu"
                            } 
                            ]
                        }
                }

                if { [lsearch -regex $::vcst::_schWindowList $curSchWin] >= 0 } { 
                    qwAction -id $curSchWin -invisible
                    set ::vcst::_prevUnusedRegList $::vcst::_unusedRegList
                    #Multiple objects available, create sub-menu
                    if {[catch { dict get $::vcst::_windowRegMap $curSchWin } errMsg]} {
                        puts "error in dict get $errMsg"
                    } else {
                        set value [dict get $::vcst::_windowRegMap $curSchWin]
                        foreach obj [split $value ,] {
                            qwAction -name $obj -text $obj -tcl "::vcst::unusedRegTrace \{$obj\}" -id $curSchWin -visible
                            qwActionGroup -name "unusedRegGrp" -actionNames $obj -id $curSchWin
                        }
                        qwAction -name "unusedRegGrp" -text "Unused Register Trace" -id $curSchWin
                        qwAddMenuAction -action "unusedRegGrp" -group "RightClickMenu" -id $curSchWin
                    }

                } else {
                    qwAction -name "unusedRegGrp" -id $curSchWin -invisible 
                }

                if { [lsearch -regex $::vcst::_schWinList $curSchWin] >= 0 } { 
                    qwAction -id $curSchWin -invisible
                    set ::vcst::_prevConstRegList $::vcst::_constRegList
                    #Multiple objects available, create sub-menu
                    if {[catch { dict get $::vcst::_winRegMap $curSchWin } errMsg]} {
                        puts "error in dict get $errMsg"
                    } else {
                    set value [dict get $::vcst::_winRegMap $curSchWin]
                    foreach obj [split $value ,] {
                        qwAction -name $obj -text $obj -tcl "::vcst::constRegTrace \{$obj\}" -id $curSchWin -visible
                        qwActionGroup -name "constRegGrp" -actionNames $obj -id $curSchWin
                    }
                        qwAction -name "constRegGrp" -text "Constant Register Trace" -id $curSchWin
                        qwAddMenuAction -action "constRegGrp" -group "RightClickMenu" -id $curSchWin
                    }  
                } else {
                    qwAction -name "constRegGrp" -id $curSchWin -invisible 
                }


               if {$type == "net" && $::vcst::_lintImplMode == "1" && [lsearch -regex $::vcst::_schWinList $curSchWin] >= 0} {

                    if {$multipleNets} {
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "equalNet" -text "Show Equal Net" -tcl "::vcst::showStructValue \{$contextObject\} $type \"EQUAL_NET\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "equalNet"
                            } 
                            ]
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "invertedNet" -text "Show Inverted Net" -tcl "::vcst::showStructValue \{$contextObject\} $type \"INVERTED_NET\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "invertedNet"
                            } 
                            ]
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "alwaysGreaterNet" -text "Show Always Greater Net" -tcl "::vcst::showStructValue \{$contextObject\} $type \"ALWAYS_GREATER_NET\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "alwaysGreaterNet"
                            } 
                            ]
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "sumMaxThreshold" -text "Show Sum Max Threshold" -tcl "::vcst::showStructValue \{$contextObject\} $type \"SUM_MAX_THRESHOLD\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "sumMaxThreshold"
                            } 
                            ]
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "sumMinThreshold" -text "Show Sum Min Threshold" -tcl "::vcst::showStructValue \{$contextObject\} $type \"SUM_MIN_THRESHOLD\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "sumMinThreshold"
                            }
                            ]
                            qwConfig -type nSchema -cmds [list {qwAction -name "stuckValue" -invisible}]
                            qwConfig -type nSchema -cmds [list {qwAction -name "nextLevelUserNets" -invisible}]
                            
                    } else {
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "stuckValue" -text "Show Stuck Value" -tcl "::vcst::showStructValue \{$contextObject\} $type \"STUCK_VALUE\"" -visible
                            } {
                                qwActionGroup -name "structValue" -actionNames "stuckValue"
                            } 
                            ]

                            qwConfig -type nSchema -cmds [list {qwAction -name "equalNet" -invisible}]
                            qwConfig -type nSchema -cmds [list {qwAction -name "invertedNet" -invisible}]
                            qwConfig -type nSchema -cmds [list {qwAction -name "alwaysGreaterNet" -invisible}]
                            qwConfig -type nSchema -cmds [list {qwAction -name "sumMaxThreshold" -invisible}]
                            qwConfig -type nSchema -cmds [list {qwAction -name "sumMinThreshold" -invisible}]
                    }
                    qwConfig -type nSchema -cmds [list {
                        qwAction -name "structValue" -text "Analyze Net" -visible
                    } {
                        qwAddMenuAction -action "structValue" -group "RightClickMenu"
                    }
                    ]

                    if {!$multipleNets} {
                        qwConfig -type nSchema -cmds [list {
                            qwAction -name "nextLevelUserNets" -text "Show Next Level User Nets" -tcl "::vcst::showStructValue \{$contextObject\} $type \"NEXT_LEVEL_USER_NETS\"" -visible
                        } {
                            qwAddMenuAction -action "nextLevelUserNets" -group "RightClickMenu"
                        } 
                        ]
                    }
                
                } else {
                    qwConfig -type nSchema -cmds [list {qwAction -name "structValue" -invisible}]
                    qwConfig -type nSchema -cmds [list {qwAction -name "nextLevelUserNets" -invisible}]
                }

                if {!$multipleNets} {

                    qwConfig -type nSchema -cmds [list {
                        qwAction -name "schConstraints" -text "Set Constraints..." -tcl "::vcst::showConstraints \{$contextObject\} $type" -visible
                    } {
                        qwAddMenuAction -action "schConstraints" -group "RightClickMenu"
                    }
                    ]
                    
                    #Limit to LP
                    if {![info exists ::env(VERDI_SG_WORKMODE)]} {
                        #reverting back to Verdi style name 
                        set contextObject [string map "$::vcst::_vcstAppHierDelim ." $contextObject]
                        if { ($::vcst::_powerDbDir != "") || ($::vcst::_goldenUpfConfig != "" && [file exists $::vcst::_goldenUpfConfig]) || ($::vcst::_upfOpts != "" && $::vcst::_upfOpts != " -upf ") } {
                            qwConfig -type nSchema -cmds [list {
                                qwAction -name "schViolationsCone" -text "Show VCLP Violations Cone" -tcl "::vcst::showVCLPViolationsCone \{$contextObject\} $type"
                            } {
                                qwAddMenuAction -action "schViolationsCone" -group "RightClickMenu"
                            } 
                            ] 
                        }
                    }
                } else {
                    qwConfig -type nSchema -cmds [list {qwAction -name "schConstraints" -invisible}]
                    qwAction -name "schViolationsCone" -invisible
                }
            }
            "schCloseWindow" {
                set currentWin [lindex $args 1]
                set cmd "action aaMonetnSchemaClosed -trigger -win \{$currentWin\}"
                verdiRunVcstCmd $cmd -no_wait 
            }
            "schCreateWindow" {
                set currentWin [lindex $args 1]
                set modefile "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/.modelist"
                if {[file exists $modefile]} {
                    set fp [open $modefile r]
                    set scenarios [read $fp]
                    close $fp
                    if {$scenarios != ""} {
                        if {[catch { dict set ::vcst::_windowScenarioMap $currentWin $scenarios } errMsg]} {
                            puts $dd "error in dict set $errMsg"
                        }
                    }
                    file delete $modefile
                }
                set idfile "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/.violid"
                if {[file exists $idfile]} {
                    set fp [open $idfile r]
                    set id [read $fp]
                    close $fp
                    if {$id != ""} {
                        if {[catch { dict set ::vcst::_windowViolIdMap $currentWin $id } errMsg]} {
                            puts $dd "error in dict set $errMsg"
                        }
                    }
                    file delete $idfile
                }
                set cmd "action aaMonetnSchemaCreated -win \{$currentWin\} -trigger 50"
                verdiRunVcstCmd $cmd -no_wait 
            }
            "schDockFormState" {
                set currentWin [lindex $args 1]
                set dockName   [lindex $args 2]
                set dockState  [lindex $args 3]
                set dockWinId  "N/A"
                if { [llength $args ] == 5 } {
                    set dockWinId  [lindex $args 4]
                }
                set cmd "action aaMonetnSchemaDisplayed -win \{$currentWin\} -dockName \{$dockName\} -dockState \{$dockState\} -dockWinId \{$dockWinId\} -trigger 50"
                verdiRunVcstCmd $cmd -no_wait 
            }
            default {
            }
        }
        return 1;
    }

    proc updateNavTarget {args} {
        if {$::vcst::_navLastTarget != $::vcst::_navTarget} {
            set ::vcst::_navLastTarget $::vcst::_navTarget
            set cmd "action aaMonetNavigatorTarget -data \{$::vcst::_navTarget\} -trigger"
            verdiRunVcstCmd $cmd -no_wait
        }
    }

    proc updatePropertyMap {} {
        if {$::vcst::_fsdb != "" && $::vcst::_sva != ""} {
            set ::vcst::propertyMap($::vcst::_fsdb) $::vcst::_sva
            expPropVcstDataUpdated -actualFsdb 
        }
    }

    proc updateCurTraceWin {} {
        set ::vcst::_curWaveVw [wvGetCurrentWindow -primary]
        if {$::vcst::_curWaveVw == "0"} {
            set ::vcst::_curWaveVw ""
        }
        if {$::vcst::_curWaveVw != "" && [expPropGetAttr -is_nav_wave $::vcst::_curWaveVw] } {
            set ::vcst::_curWaveVw ""
            set winList [wvGetAllWindows]
            foreach winId $winList {
                if {[expPropGetAttr -is_nav_wave $winId] == 0} {
                    # If Primary nWave is for navigator, pick any other wave view.
                    set ::vcst::_curWaveVw $winId
                    break
                }
            }
        }
        return $::vcst::_curWaveVw
    }

    proc saveViewTraceRc {} {
        file delete $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/view_trace.rc
        if {[wvGetActiveFile -win $::vcst::_curWaveVw] == ""} {
            return ""
        }

        set attr_value [wvSaveSignalRC -win $::vcst::_curWaveVw -get_attr_value]
        wvSaveSignalRC -win $::vcst::_curWaveVw -all -no_fsdbinfo -no_usermarker
        wvSaveSignal -win $::vcst::_curWaveVw $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/view_trace.rc
        wvSaveSignalRC -win $::vcst::_curWaveVw -keep -set_attr_value $attr_value

        return "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/view_trace.rc"
    }

    proc restoreViewTraceRc {{clear "true"}} {
        if {$clear} {
            wvClearAll -win $::vcst::_curWaveVw
        }
        restoreViewTraceRcFromFile $::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/view_trace.rc
    }

    proc restoreViewTraceRcFromFile {rcFile} {
        if {[file exists $rcFile]} {
            set cursor [lindex [wvGetCursor] 1]
            #wvClearAll -win $::vcst::_curWaveVw
            wvRestoreSignal -win $::vcst::_curWaveVw $rcFile
            # Zoom full for extend/new scenario
            wvZoomAll -win $::vcst::_curWaveVw
            wvSetCursor $cursor
            verdiWindowRaise -win $::vcst::_curWaveVw
        }
    }

    proc appendSignalGroup {groupName signalList} {
        set win $::vcst::_curWaveVw
        set bGroupExisted [wvIsGroupExist -win $win $groupName] 
        if {$bGroupExisted == 1} {
            wvSetPosition -win $win {($groupName 0)}
            wvRenameGroup -win $win $groupName "GROUP_TO_DELETE"
            wvAddGroup -win $win $groupName
        } else {
            wvSetPosition -win $win -index last 
            wvAddGroup -win $win -insertBefore $groupName
        }
        foreach signal $signalList {
            wvAddSignal -fromVCST -win $win $signal
        }
        if {$bGroupExisted == 1} {
            wvSelectGroup -win $win "GROUP_TO_DELETE"
            wvCut -win $win
        }
    }
    
    proc navShowSourceTab { } {
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        set widgetSourceTab ""
         if { [info exists ::vcst::SrcTabs($container)] && [verdiGetAttribute -dock $::vcst::SrcTabs($container) -height] != "0" } {
            set widgetSourceTab $::vcst::SrcTabs($container)
            verdiDockWidgetDock -dock $widgetSourceTab
            verdiDockWidgetDisplay -dock $widgetSourceTab
        } else {
            set result [srcCreateSourceTab]
            if { $result == "0" } {
                verdiShowMessage -warn {Failed to create src window, because new source tab is not allowed.}
                return
            }
            srcShowDefine -incrSearch $::vcst::_top

            set sourceIdx [srcGetNewTabIdx]
            set sourceTab MTB_SOURCE_TAB_$sourceIdx
            verdiDockToContainer -widget $sourceTab -container $container
            set widgetSourceTab widgetDock_$sourceTab
            set ::vcst::SrcTabs($container) $widgetSourceTab
        }
        return $widgetSourceTab
    }

    proc navAdjustSourceTabLayout { widgetSourceTab instExist } {
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        verdiDockWidgetMove -dock $widgetSourceTab -bottom
        verdiDockWidgetMove -dock $widgetSourceTab -win $::vcst::_curWaveVw -bottom
        if { $instExist == "1" } {
            verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -dock $widgetSourceTab -left
        }
        
        set waveWidth [verdiGetAttribute -win $::vcst::_curWaveVw -width]
        set containerHeight [verdiGetAttribute -win $container -height]
        set idx1 [expr [string first "width" $waveWidth]+6]
        set conWidth [string range $waveWidth $idx1 end-1]
        set idx1 [expr [string first "height" $containerHeight]+7]
        set conHeight [string range $containerHeight $idx1 end-1]
        if { $instExist == "0" } {
            verdiWidgetResize -dock $widgetSourceTab $conWidth [expr $conHeight/5*2]
        } else {
            verdiWidgetResize -dock $widgetSourceTab [expr $conWidth/3*2] [expr $conHeight/5*2]
        }
    }
    #P10049895-156320 add source view into navigator default layout
    proc navMoveSrcView { wvWinId instExist } {
        set ::vcst::_curWaveVw $wvWinId
        set widgetSourceTab [navShowSourceTab]
        navAdjustSourceTabLayout $widgetSourceTab $instExist
    }

    proc navRemoveSrcView { } {
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        set srcTab $::vcst::SrcTabs($container)
        verdiDockWidgetHide -dock $srcTab
    }

    proc navCloseSrcView { } {
        if {$::vcst::_curWaveVw == ""} {
            set ::vcst::_curWaveVw [wvGetCurrentWindow -primary]
        }
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        set srcTab $::vcst::SrcTabs($container)
        verdiDockWidgetDelete -dock $srcTab
    }

    proc navMoveInstView { srcExist } {
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        verdiDockToContainer -widget <Inst._Tree> -container $container
        set srcTab $::vcst::SrcTabs($container)
        if { $srcExist == "1" } {
            verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -dock $srcTab -left
        } else {
            verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -bottom
            verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -win $::vcst::_curWaveVw -bottom
        }
        set waveWidth [verdiGetAttribute -win $::vcst::_curWaveVw -width]
        set containerHeight [verdiGetAttribute -win $container -height]
        set idx1 [expr [string first "width" $waveWidth]+6]
        set conWidth [string range $waveWidth $idx1 end-1]
        set idx1 [expr [string first "height" $containerHeight]+7]
        set conHeight [string range $containerHeight $idx1 end-1]
        if { $srcExist == "0" } {
            verdiWidgetResize -dock widgetDock_<Inst._Tree> $conWidth [expr $conHeight/5*2]
        } else {
            verdiWidgetResize -dock widgetDock_<Inst._Tree> [expr $conWidth/3] [expr $conHeight/5*2]
        }
    }

    proc navRemoveInstView { } {
        verdiDockToContainer -widget <Inst._Tree> -container $::_nTrace1
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        verdiWindowRaise -win $container
    }

    proc navDefaultLayoutView { instExist } {
        if { $instExist == "1" } {
            navRemoveInstView
        }
        navShowSourceTab

        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        set srcTab $::vcst::SrcTabs($container)
        set waveStr [verdiGetAttribute -win $::vcst::_curWaveVw -type]
        set endIdx [string first "\]:" $waveStr]
        set waveDockName [string range $waveStr 1 $endIdx-1]
        set waveDockName "windowDock_$waveDockName"

        set naviStr [expPropGetWindowName -win $::vcst::_curWaveVw]
        set naviDocName "windowDock_$naviStr"

        verdiDockWidgetDisplay -dock $naviDocName
        verdiWindowVerticalTile -win $container
        verdiDockWidgetMove -dock $naviDocName -dock $waveDockName -right
        navAdjustSourceTabLayout $srcTab 0

        set containerWidth [verdiGetAttribute -win $container -width]
        set idx1 [expr [string first "width" $containerWidth]+6]
        set conWidth [string range $containerWidth $idx1 end-1]
        set navHeight [verdiGetAttribute -dock $naviDocName -height]
        set idx1 [expr [string first "height" $navHeight]+7]
        set nheight [string range $navHeight $idx1 end-1]
        verdiWidgetResize -dock $naviDocName [expr $conWidth/5] $nheight
    }

    #9001423529: to support navigator in Unified Debug Window
    #Usage: prepareUDWin waveWinId (when nWave exists)
    #       prepareUDWin  (when there is no nWave)
    proc prepareUDWin { {wvWinId "-1"} {hasAnalyzer "0"} } {
        if { $wvWinId != "-1" } {
            # wvWin provided, check parent
            # if wave parent is already a UDW, do NOTHING but returnt the container id
            set ::vcst::_curWaveVw $wvWinId
            set parentID [verdiGetAttribute -win $wvWinId -parentWin]
            set winTitle [verdiGetAttribute -win $parentID -title]
            set idx [string first "Unified Debug:" $winTitle]
            if { $idx != "-1" } {
                #puts "Already in UDW, do not popup UDW again!"
                return $parentID
            } else {
                #create new container and dock wvWin
                set container [verdiDockToContainer -win $wvWinId -newContainer]
                #puts "wvWinId: $wvWinId, new container created: $container"
            }
        } else {
            #wvWinID not provided, create wave window
            verdiSetPrefEnv -bDockNewCreatedWindowInContainer on
            set ::vcst::_curWaveVw [wvCreateWindow]
            verdiSetPrefEnv -bDockNewCreatedWindowInContainer off
            set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        }

        #prepare new source window and open top scope in it
        set result [srcCreateSourceTab]
        if { $result == "0" } {
            verdiShowMessage -warn {Failed to create unified debug window, because new source tab is not allowed.}
            return $container
        }
        srcShowDefine -incrSearch $::vcst::_top

        return [popUpUDWindow 1 $hasAnalyzer]
    }

    #reset default layout
    #usage: resetUDWinLayout <wvWinID>
    proc resetUDWinLayout { {wvWinId "-1"}} {
        #get current container
        if { $wvWinId == "-1" } {
            set currentWinID [verdiGetActiveWindow]
            #puts "Get wvWin ID from active window"
        } else {
            set currentWinID $wvWinId
            #puts "Set wvWin ID as input, $wvWinId"
        }
        verdiLogCommand ::vcst::resetUDWinLayout $currentWinID

        #in case nWave is undocked, dock back
        verdiWindowBeDocked -win $currentWinID
        set container [verdiGetAttribute -win $currentWinID -parentWin]
        if { $container == 0 } {
            #nWave is NOT in a container
            return -1
        }
        #check if it is UDW container
        set winTitle [verdiGetAttribute -win $container -title]
        set isUDWContainer [string first "Unified Debug:" $winTitle]
        if { $isUDWContainer == "-1" } {
            #nWave is not in UDW
            return -1
        }
        #freeze layout to avoid nWave disorder during reset
        verdiLayoutFreeze
        #check if it's a navigator, as it needs special layout
        set winTitle [verdiGetAttribute -win $container -title]
        set naviIdx [string first "\[navigator\]" $winTitle]

        #get source tab for the container
        set srcTab $::vcst::SrcTabs($container)
        set currentInstShown $::vcst::instShown($currentWinID)
        set currentAnalyzerShown $::vcst::analyzerShown($currentWinID)

        #make sure srcTab exists and in show status
        set srcShowState [verdiGetAttribute -dock $srcTab -show_state]
        if { $srcShowState == "0" } { 
            qwAction -id $currentWinID -name "resetLayout" -disabled
            verdiShowMessage -warn {No source tab in current unified debug window, "Reset Layout" is disabled.}
            verdiLayoutFreeze -off
            return
        }
        #if source is hidden, show it
        set idx [expr [string first "show_state=hidden" $srcShowState]]
        if { $idx != "-1" } {
            #src is hidden, show srcTab
            verdiDockWidgetDisplay -dock $srcTab
        }

        if { $naviIdx != "-1" } {
            #for navigator: dock navigator to the right of nWave
            #get nWave dock name
            set waveStr [verdiGetAttribute -win $currentWinID -type]
            set endIdx [string first "\]:" $waveStr]
            set waveDockName [string range $waveStr 1 $endIdx-1]
            set waveDockName "windowDock_$waveDockName"

            #get Navigator dock name
            set naviStr [expPropGetWindowName -win $currentWinID]
            set naviDocName "windowDock_$naviStr"

            #in case navigator is undocked, dock navigator (name as $_Navigator_n)
            set navWin "\$::_$naviStr"
            verdiWindowBeDocked -win [subst $navWin]
        }

        #reset container layout to default
        set minWidth 850
        set minHeight 700

        #in case source, instance, analyzer is undocked
        verdiDockWidgetDock -dock $srcTab
        if { $currentInstShown == "1" } {
            verdiDockWidgetDock -dock widgetDock_<Inst._Tree>
        }
        if { $currentAnalyzerShown == "1" } {
            verdiDockWidgetDock -dock widgetDock_Analyzer
        }

        #YZF: to support Navigtor flow better, using vertical + bottom moving
        #verdiWindowHorizontalTile -win $container
        verdiWindowVerticalTile -win $container
        verdiDockWidgetMove -dock $srcTab -bottom

        #reset layout for Navigator
        if { $naviIdx != "-1" } { 
            verdiDockWidgetMove -dock $naviDocName -dock $waveDockName -right
            verdiDockWidgetMove -dock $srcTab -dock $waveDockName -bottom
        }
        #reset layout for instance
        if { $currentInstShown == "1" } {
            verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -dock $srcTab -left
            verdiDockWidgetDisplay -dock widgetDock_<Inst._Tree>
        }
        #reset layout for analyzer
        if { $currentAnalyzerShown == "1" } {
            verdiDockWidgetMove -dock widgetDock_Analyzer -dock $srcTab -right
        }        

        #set unified debug window minimum height 500, minimum width 800
        set containerWidth [verdiGetAttribute -win $container -width]
        set containerHeight [verdiGetAttribute -win $container -height]
        set idx1 [expr [string first "width" $containerWidth]+6]
        set conWidth [string range $containerWidth $idx1 end-1]
        set idx1 [expr [string first "height" $containerHeight]+7]
        set conHeight [string range $containerHeight $idx1 end-1]
        #if < minHeight/minWdith, set to minimum
        if { $conHeight < $minHeight } {
            verdiWindowResize -win $container $conWidth $minHeight
            set conHeight $minHeight
        }
        if { $conWidth < $minWidth } {
            verdiWindowResize -win $container $minWidth $conHeight
            set conWidth $minWidth
        }

        #adjust size of docks
        set headerHeight 30
        if { $currentInstShown == "0" } {
            if { $currentAnalyzerShown == "1" } {
                verdiWidgetResize -dock $srcTab [expr $conWidth/2] [expr ($conHeight-$headerHeight)/2]
            } else {
                verdiWidgetResize -dock $srcTab $conWidth [expr ($conHeight-$headerHeight)/2]
            }
        } else {
            #instance is Shown
            verdiWidgetResize -dock widgetDock_<Inst._Tree> [expr $conWidth/6] [expr ($conHeight-$headerHeight)/2]
            if { $currentAnalyzerShown == "1" } {
                verdiWidgetResize -dock $srcTab [expr $conWidth/3] [expr ($conHeight-$headerHeight)/2]
            }
        }

        verdiLayoutFreeze -off
        verdiWindowRaise -win $container -raiseWithParent
        #update nWave after unified debug is ready
        #expPropVcstDataUpdated -actualFsdb
        printDbgMsg "Unified Debug window layout is reset to default!"
        #puts "Unified Debug window reset to default!"
        return $container
    }

    #to iterate all UDW containers and close source tabs inside, before restar VCF
    proc closeAllSourceTabInUDWContainers {} {
        #this proc is only for restart_vcst with UDW enabled
        if { ![info exists ::vcst::EnableUDWin] || $::vcst::EnableUDWin != "1" } {
            #Not enabled UDW, need not close source tab
            return
        }
        verdiDockToContainer -widget <Inst._Tree> -container $::_nTrace1
        #interate all containers, and find UDW
        set winCnt [verdiGetTypeCount -docker]
        verdiWindowIterNext -docker -begin
        for { set i 1 } { $i<$winCnt } {incr i} {
            set subWinId [verdiWindowIterNext -docker]
            if { $subWinId != "0" } {
                set winTitle [verdiGetAttribute -win $subWinId -title]
                set idx [string first "Unified Debug:" $winTitle]
                if { $idx != "-1" } {
                    #Unified Debug Window
                    srcCloseSourceTab -win $::_nTrace1
                }
            }
        }
    }
    proc moveUDWave { } {
        set sourceIdx [srcGetNewTabIdx]
        set sourceTab MTB_SOURCE_TAB_$sourceIdx
        set widgetSourceTab "widgetDock_$sourceTab"
        verdiDockWidgetMove -dock $widgetSourceTab -win $::vcst::_curWaveVw -bottom
        verdiToolBar -win $::vcst::_curWaveVw -toolbar UDWinGroup -moveToAf replotToolbar
    }
    proc popUpUDWindow { includeAnalyzerTFV analyzerFlag } {
        #YZF: Move nWave, soruce, analyzer, etc. into new container and pop up it
        #puts "start Unified Debug window ..."

        #set container [verdiDockToContainer -win $::vcst::_curWaveVw -newContainer -windowTitle $titleStr]
        set container [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]

        #initialize
        set ::vcst::analyzerShown($::vcst::_curWaveVw) 0
        set ::vcst::instShown($::vcst::_curWaveVw) 0
        set ::vcst::analyzerSetupInfo($container) 0
        set curAnalyzerShown 0

        set currentWin [verdiGetActiveWindow]
        set parentWin [verdiGetAttribute -win $currentWin -parentWinName]

        #Wave window to container, and save container name
        #show property string in window title
        set titleStr $::vcst::_sva
        if { [string length $titleStr] > 55 } {
            #truncate if longer than 55
            set titleStr [string range $titleStr end-52 end]
            set titleStr "...$titleStr"
        }
        set titleStr "Unified Debug: $titleStr"
        # nWave already created in container, just get the parent container and rename the title

        verdiSetAttribute -win $container -banner $titleStr
        #verdiWindowPrependTitle -win $container -preTitle $titleStr

        #get current source tab name and move to container
        set sourceIdx [srcGetNewTabIdx]
        set sourceTab MTB_SOURCE_TAB_$sourceIdx
        verdiDockToContainer -widget $sourceTab -container $container
        #two docks: wave and source
        set dockCount 2

        #add toolbar to source
        #Toolbars:
        #         Calling, Definition, Backward History, Forward History, Driver, Load
        #         Show Previous, Show Next, Show Previous in Hierarchy, Show Next in Hierarchy,
        #         Find String, Find Previous, Find Next
        set widgetSourceTab "widgetDock_$sourceTab"
        #add search bar
        verdiAddBannerAct -dock $widgetSourceTab -comboBox HB_STATUS_SEARCH
        verdiAddBannerAct -dock $widgetSourceTab TextFindPrevGroup TextFindNextGroup
        verdiAddBannerAct -dock $widgetSourceTab \
                TextShowCallingScopeGroup TextShowDefinedScopeGroup \
                UndoTraceGroup RedoTraceGroup ToolBarTraceDriverGroup ToolBarTraceLoadGroup \
                TextGoPrevInstGroup TextGoNextInstGroup TextGoPrevGroup TextGoNextGroup

        #move instance tree to container and hide -- todo: move when a button clicked.
        #verdiDockToContainer -widget <Inst._Tree> -container $container

        #----- Analyzer (if include Analyzer is enabled) -----
        if { $includeAnalyzerTFV == "1" } {
            #check if Analyzer exists during view_trace
            #set analyzerState [verdiGetAttribute -dock widgetDock_Analyzer -show_state]
            if { $analyzerFlag == "1" } {
                verdiDockToContainer -widget Analyzer -container $container
                #incr dockCount
                #set analyzer button status
                set ::vcst::analyzerShown($::vcst::_curWaveVw) 1
                set curAnalyzerShown 1
            } 
            uncheckOtherUDWinAnalyzerBtn $container
        }

        #if analyzerFlag =1 and Analyzer not shown, enable the Analyzer button
        if { $curAnalyzerShown == "0" } {
            qwAction -id $::vcst::_curWaveVw -name "addAnaly" -unchecked
        } else {
            qwAction -id $::vcst::_curWaveVw -name "addAnaly" -checked
        }

        #Adjust container layout
        set minWidth 850
        set minHeight 700
        #move source, instance, analyzer, etc.
        #verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -bottom
        verdiDockWidgetMove -dock $widgetSourceTab -bottom
        #verdiWidgetResize -dock widgetDock_<Inst._Tree> [expr $minWidth/4]
        #verdiDockWidgetHide -dock widgetDock_<Inst._Tree>

        if { $curAnalyzerShown == "1" } {
            verdiDockWidgetMove -dock widgetDock_Analyzer -bottom
            saveCurUdwAnalyzerSetupInfo $container
        }
        #set unified debug window minimum height 500, minimum width 800
        set containerWidth [verdiGetAttribute -win $container -width]
        set containerHeight [verdiGetAttribute -win $container -height]
        set idx1 [expr [string first "width" $containerWidth]+6]
        set conWidth [string range $containerWidth $idx1 end-1]
        set idx1 [expr [string first "height" $containerHeight]+7]
        set conHeight [string range $containerHeight $idx1 end-1]

        #if < minHeight/minWdith, set to minimum
        if { $conHeight < $minHeight } {
            verdiWindowResize -win $container $conWidth $minHeight
            set conHeight $minHeight
        }
        if { $conWidth < $minWidth } {
            verdiWindowResize -win $container $minWidth $conHeight
            set conWidth $minWidth
        }
        #puts "Width: $conWidth , Height: $conHeight"

        #adjust size of docks
        set headerHeight 30
        verdiWidgetResize -dock $widgetSourceTab [expr $conWidth/2] [expr ($conHeight-$headerHeight)/2]
        #disable source RMB menu "add to new Waveform"
        verdiEnableCommand -off -act Verdi_1_MTB_SOURCE_TAB_1_srcAddSignalToWaveMenu_NewWaveform

        #show instance, analyzer, reset icons
        qwConfig -type Verdi -cmds [list {
            qwAction -name "addInstForVerdi" -visible
        }]
        qwAction -id $::vcst::_curWaveVw -name "addInst" -visible
        qwAction -id $::vcst::_curWaveVw -name "addAnaly" -invisible
        #add Reset layout button
        qwAction -id $::vcst::_curWaveVw -name "resetLayout" -invisible
        qwAction -id $::vcst::_curWaveVw -name "assertAnalyzer" -invisible
        #move UDW toolbar to the correct position (top left)
        verdiToolBar -win $::vcst::_curWaveVw -toolbar UDWinGroup -moveToAf replotToolbar

        #save sourceTab, waveID, as it's impossible to get them later
        set ::vcst::SrcTabs($container) $widgetSourceTab
        set ::vcst::nWaveID($container) $::vcst::_curWaveVw
        set ::vcst::containerID($::vcst::_curWaveVw) $container
        #save analyzerFlag: if the container has the analyzer opened during view_trace
        set ::vcst::AnalyzerFlag($container) $analyzerFlag

        verdiWindowRaise -win $container -raiseWithParent
        #update nWave after unified debug is ready
        expPropVcstDataUpdated -actualFsdb
        printDbgMsg "Unified Debug window is ready!"
        #save current UDW winID
        set vcst::_currentActWinIsUDW $container
        return $container
    }

    #printDebugMessage: print at GUI_REGRESSION_MODE
    proc printDbgMsg { msg {fileName ""} } {
        if {[info exists ::env(GUI_REGRESSION_MODE)]} {
            puts $msg
            if {$fileName != ""} {
                redirect -file $fileName -append { puts $msg }
            }
        }
    }

    #UDWinCleanup
    proc UDWinCleanup { waveID } {
        #get container ID by waveID
        set container $::vcst::containerID($waveID)
        #close container, in case it still exists
        verdiWindowClose -win $container
        #unset all arrays
        unset ::vcst::analyzerShown($waveID)
        unset ::vcst::containerID($waveID)
        unset ::vcst::instShown($waveID)
        unset ::vcst::AnalyzerFlag($container)
        unset ::vcst::SrcTabs($container)
        unset ::vcst::nWaveID($container)
        if {[info exists ::vcst::analyzerSetupInfo($container)]} {
            unset ::vcst::analyzerSetupInfo($container)
        }
    }

    # move Analzyer to the container
    proc moveInAnalyzer { container } {
        #check if Analyzer exists
        set analyzerState [verdiGetAttribute -dock widgetDock_Analyzer -show_state]
        if { $analyzerState != "0" } {
            #move Analzyer to container
            verdiDockWidgetDisplay -dock widgetDock_Analyzer
            verdiDockToContainer -widget Analyzer -container $container
            verdiDockWidgetMove -dock widgetDock_Analyzer -bottom
            #Adjust container layout
            set containerWidth [verdiGetAttribute -win $container -width]
            set containerHeight [verdiGetAttribute -win $container -height]
            set idx1 [expr [string first "width" $containerWidth]+6]
            set idx2 [expr [string length $containerWidth]-1]
            set conWidth [string range $containerWidth $idx1 $idx2]
            set idx1 [expr [string first "height" $containerHeight]+7]
            set idx2 [expr [string length $containerHeight]-1]
            set conHeight [string range $containerHeight $idx1 $idx2]
            set headerHeight 30
            verdiWidgetResize -dock widgetDock_Analyzer [expr $conWidth/2] [expr ($conHeight-$headerHeight)/2]
        }
    }

    proc createInstAction {} {
        #create action, group
        qwConfig -type nWave -cmds [list {
            qwAction -name "addInst" -icon ":/images/inst.png" -text "Show Instance" -tcl "::vcst::instanceBtnPressed" -tooltip "Show/Hide Instance Tree" -checkable -invisible
        } {
            qwActionGroup -name "UDWinGroup" -actionNames "addInst" -nonexclusive
        }]
        # Add 'Show Instance' button in the VCF window toolbar
        # In Verdi Navigator, Formal toolbar is not available 
        if {[info exist ::env(SNPS_VERDI_INTERNAL_NAVIGATOR)]} {
            qwConfig -type Verdi -cmds [list {
                qwAction -name "addInstForVerdi" -icon ":/wave/icon/wave/png/inst.png" -text "Show Instance" -tcl "::vcst::instanceBtnPressedForVerdi" -tooltip "Show/Hide Instance Tree" -visible
            } {
                qwActionGroup -name "VerdiNavGroup" -actionNames "addInstForVerdi"
            }]
            #verdiToolBar -win $_Verdi_1 -toolbar VerdiNavGroup -moveToAf HB_IMPORT_COMMAND_PANEL
        } else {
            qwConfig -type Verdi -cmds [list {
                qwAction -name "addInstForVerdi" -icon ":/images/inst.png" -text "Show Instance" -tcl "::vcst::instanceBtnPressedForVerdi" -tooltip "Show/Hide Instance Tree" -invisible
            } {
                qwAddToolBarAction -action "addInstForVerdi" -group "toolBarFormalVerification"
            }]
        }
    }

    #Analyzer action
    proc createAnalyzerAction {} {
        #create action, group
        qwConfig -type nWave -cmds [list {
            qwAction -name "addAnaly" -icon ":/images/analyzer.png" -text "Show Analyzer" -tcl "::vcst::analyzerBtnPressed" -tooltip "Show/hide Analyzer" -checkable -invisible
        } {
            qwActionGroup -name "UDWinGroup" -actionNames "addAnaly" -nonexclusive
        }]
    }

    #reset layout action
    proc creatResetLayoutAction {} {
        #create action, group
        qwConfig -type nWave -cmds [list {
            qwAction -name "resetLayout" -icon ":/images/reset_udw.png" -text "Reset Layout" -tcl "::vcst::resetUDWinLayout" -tooltip "Reset default layout" -invisible
        } {
            qwActionGroup -name "UDWinGroup" -actionNames "resetLayout"
        }]
    }

    proc creatAssertAnalyzerAction {} {
        #creat assertAnalyzer icon and init group 
        qwConfig -type nWave -cmds [list {
            qwAction -name "assertAnalyzer" -icon ":/images/analyzer.png" -text "Run Analyzer" -tcl "::vcst::AssertAnalyzerBtnPressed" -tooltip "Run Analyzer" -invisible
        } {
            qwActionGroup -name "AssertAnalyzer" -actionNames "assertAnalyzer"
        }]
    }

    proc createAddTraceToWaveAction {} {
        #creat assertAnalyzer icon and init group 
        qwConfig -type nWave -cmds [list {
            qwAction -name "addTraceToWave" -icon ":/images/addToTrace.png" -text "Add Trace Results to Wave" -tcl "::vcst::addToTraceWaveBtnPressed" -tooltip "Add Trace Results to Wave" -invisible -checkable
        } {
            qwActionGroup -name "AddTraceToWave" -actionNames "addTraceToWave"
        } {
            qwAddToolBarGroup -group "AddTraceToWave"
        }]
    }

    proc enableAssertAnalysis {} {
        set curWaveVw [wvGetCurrentWindow -active]
        verdiToolBar -win $curWaveVw -toolbar UDWinGroup -moveToEnd
        qwAction -id $curWaveVw -name "assertAnalyzer" -visible
        verdiToolBar -win $curWaveVw -toolbar AssertAnalyzer -moveToEnd
    }
    
    proc enableAddTraceToWave {} {
        set curWaveVw [wvGetCurrentWindow -active]
        if {[expPropGetAttr -is_nav_wave $curWaveVw] == 1} {
            verdiToolBar -win $curWaveVw -toolbar AddTraceToWave -hide
            return
        }
        set ::vcst::addTraceToWaveFlag FALSE
        qwAction -id $curWaveVw -name "addTraceToWave" -visible
        verdiToolBar -win $curWaveVw -toolbar AddTraceToWave -moveToEnd   
        set ::vcst::addTraceToWaveFlag [verdiGetRCValue -section HB -key TraceAddToWave]
        if {$::vcst::addTraceToWaveFlag == TRUE} {
            qwAction -id $curWaveVw -name "addTraceToWave" -checked
        } else {
            qwAction -id $curWaveVw -name "addTraceToWave" -unchecked
        }
    }

    proc addToTraceWaveBtnPressed {} {
        set curWaveVw [wvGetCurrentWindow -active]
        wvSetPrimaryWindow -win $curWaveVw

        if {$::vcst::addTraceToWaveFlag == FALSE} {
            srcSetPreference -traceAddToWave on
            qwAction -id $curWaveVw -name "addTraceToWave" -checked
            set ::vcst::addTraceToWaveFlag TRUE
        } else {
            srcSetPreference -traceAddToWave off
            qwAction -id $curWaveVw -name "addTraceToWave" -unchecked
            set ::vcst::addTraceToWaveFlag FALSE
        }
        
    }

    proc AssertAnalyzerBtnPressed {} {
        set curWaveVw [wvGetCurrentWindow -active]
        wvSetPrimaryWindow -win $curWaveVw

        if { [info exists ::vcst::winIdFsdbMap($curWaveVw)] == 0  } {
            set actualFsdb [debGetSimResult]
            set ::vcst::winIdFsdbMap($curWaveVw) $actualFsdb
        } else {
            if { !$::vcst::_noVDACnewWin } {
                set oldFile "$::vcst::_rtdbDir/$::vcst::_hiddenDir/verdi/evaluate_result.fsdb.vf"
                cleanOldFsdb [wvGetCurrentWindow] $oldFile 
                set actualFsdb [debGetSimResult]
                if { ![string match *evaluate_result.fsdb.vf $actualFsdb]} {
                    set ::vcst::winIdFsdbMap($curWaveVw) $actualFsdb
                } else {
                    set actualFsdb $::vcst::winIdFsdbMap($curWaveVw) 
                }
            } else {
                set actualFsdb $::vcst::winIdFsdbMap($curWaveVw) 
            }
        }
        set ::vcst::_fsdb $actualFsdb
        set ::vcst::_sva $::vcst::propertyMap($actualFsdb)
        set svaRerun 1
        setupSvaDebug $::vcst::_noVDACgroupSuffix $::vcst::_noVDACnewWin $::vcst::_noVDACstartTime $svaRerun
    }

    proc AnalyzerForNavigator {} {
        #Ensure curent nWave is in a Unified Debug Win
        set pContainer [verdiGetAttribute -win $::vcst::_curWaveVw -parentWin]
        set isUDWContainer [string first "Unified Debug:" [verdiGetAttribute -win $pContainer -title]]
        if { $isUDWContainer == "-1" } { return }

        #set analyzerFlag
        set ::vcst::AnalyzerFlag($pContainer) 1
        #save restore info
        saveCurUdwAnalyzerSetupInfo $pContainer
        #emulate the analyzer button press
        analyzerBtnPressed $::vcst::_curWaveVw
    }

    proc analyzerBtnPressed { {wvWinId "-1"} } {
        if { $wvWinId == "-1" } {
            set currentWinID [verdiGetActiveWindow]
        } else {
            set currentWinID $wvWinId
        }
        verdiLogCommand ::vcst::analyzerBtnPressed $currentWinID

        #disable auto-primaryFSDB changeLayout
        set ::vcst::_primaryFsdbAutoChange 0
        set pContainer [verdiGetAttribute -win $currentWinID -parentWin]
        if {$pContainer == "0"} {
            set pContainer $currentWinID
            set currentWinID $::vcst::nWaveID($pContainer)
        }

        if { $::vcst::AnalyzerFlag($pContainer) == "0"} {
            AssertAnalyzerBtnPressed
            set ::vcst::AnalyzerFlag($pContainer) 1
        }
        set currentAnalyzerShown $::vcst::analyzerShown($currentWinID)
        if { [verdiGetAttribute -dock widgetDock_Analyzer -show_state] == "0"} {
            set currentAnalyzerShown 0
        }
        #only moving when analyzer is not shown, and current container has analyzerFlag
        set analyzerFlag $::vcst::AnalyzerFlag($pContainer)
        if { $analyzerFlag == "1" } {
            if { $currentAnalyzerShown == "0" } {
                #disable current window's Analyzer button
                qwAction -id $currentWinID -name "addAnaly" -checked
                set ::vcst::analyzerShown($currentWinID) 1
                saveCurUdwAnalyzerSetupInfo $pContainer

                #enable other containers' analyzer button
                uncheckOtherUDWinAnalyzerBtn $pContainer
                restoreAnalyzer $pContainer
                moveInAnalyzer $pContainer
            } else {
                removeAnalyzer 
                verdiWindowRaise -win $pContainer
                qwAction -id $currentWinID -name "addAnaly" -unchecked
                set ::vcst::analyzerShown($currentWinID) 0
            }
        }

        #enable auto-primaryFSDB change after 3 seconds, to avoid GUI flicker
        after 3000 {set ::vcst::_primaryFsdbAutoChange 1}
    }

    #remove Analyzer from container (dock back to nTrace)
    proc removeAnalyzer {} {
        verdiDockToContainer -widget Analyzer -container $::_nTrace1
    }

    #to enable other unified debug window Analyzer buttons
    proc uncheckOtherUDWinAnalyzerBtn { curContainer } {

        set winCnt [verdiGetTypeCount -docker]
        verdiWindowIterNext -docker -begin
        for { set i 1 } { $i<$winCnt } {incr i} {
            set subWinId [verdiWindowIterNext -docker]
            if { $subWinId != "0" } {
                set winTitle [verdiGetAttribute -win $subWinId -title]
                set idx [string first "Unified Debug:" $winTitle]
                if { $idx != "-1" } {
                    #found unfied debug window
                    if { $subWinId != $curContainer } {
                        #get waveID for the container
                        set waveId $::vcst::nWaveID($subWinId)
                        qwAction -id $waveId -name "addAnaly" -unchecked
                        set ::vcst::analyzerShown($waveId) 0
                    }
                }
            }
        }

    }

    proc getVfIndex { waveId } {
        set vfName [wvGetActiveFileName -win $waveId]
        set idx1 [string first "/.internal/verdi/" $vfName]
        set idx2 [string first ".evaluate_result" $vfName]
        if { $idx1 != "-1" && $idx2 != "-1" } {
            #len: 17 is length of "/.internal/verdi/", a constant, so just define it.
            set len 17
            set idx1 [expr $idx1 + $len]
            set idx2 [expr $idx2 - 1]
            if { $idx1 < $idx2 } {
                return [string range $vfName $idx1 $idx2]
            }
        } else {
            return 0
        }
    }

    #get all UDWins' Analyzer setup info string from array ::vcst::analyzerSetupInfo
    proc getAllAnalyzerInfoString {} {
        set result ""
        set winCnt [verdiGetTypeCount -docker]
        verdiWindowIterNext -docker -begin
        for { set i 1 } { $i<$winCnt } {incr i} {
            set subWinId [verdiWindowIterNext -docker]
            if { $subWinId != "0" } {
                set winTitle [verdiGetAttribute -win $subWinId -title]
                set idx [string first "Unified Debug:" $winTitle]
                if { $idx != "-1" } {
                    #found unfied debug container: get analyzer info if it exists
                    if { [info exists ::vcst::analyzerSetupInfo($subWinId)] } {
                        #puts "Analyzer info exits: $subWinId"
                        set waveId $::vcst::nWaveID($subWinId)
                        set vfIndex [getVfIndex $waveId]
                        if { $vfIndex != "0" } {
                            set analyzerInfoStr $::vcst::analyzerSetupInfo($subWinId)
                            set result "$result$vfIndex $analyzerInfoStr "
                        }
                    }
                }
            }
        }
        return $result
    }

    proc restoreSessionAnalyzerInfo { allInfoArray } {
        set cnt [llength $allInfoArray]
        #puts "Analyzer info count: $cnt"
        set idx 0
        while { $idx < $cnt } {
            set index [lindex $allInfoArray $idx]
            set infoStr ""
            for { set i 0 } { $i<4 } {incr i} {
                incr idx
                set infoStr "$infoStr[lindex $allInfoArray $idx] "
            }
            set ::vcst::sessionAnalyzerInfo($index) $infoStr
            #puts $infoStr
            incr idx
        }
    }

    # save UDW analyzer setup info (UDW should have the Analzyer shown)
    proc saveCurUdwAnalyzerSetupInfo { UdwWinId } {
        #get analyzer info
        set analyzerInfoStr [srcAssertDebInfo]
        if { [llength $analyzerInfoStr] == "4" } {
            #puts "Contaienr: $UdwWinId, Analyzer Info: $analyzerInfoStr"
            set ::vcst::analyzerSetupInfo($UdwWinId) $analyzerInfoStr
            return $analyzerInfoStr
        } else {
            #puts "NO Analyzer info!"
            return 0
        }
    }

    proc restoreAnalyzer { container } {
        set waveId $::vcst::nWaveID($container)
        set currentAnalyzerShown $::vcst::analyzerShown($waveId)
        if { $currentAnalyzerShown == "1" } {
            set analyzerInfoStr $::vcst::analyzerSetupInfo($container)
            if { [llength $analyzerInfoStr] == "4" } {
                set name [lindex $analyzerInfoStr 0]
                set begin [lindex $analyzerInfoStr 1]
                set end [lindex $analyzerInfoStr 2]
                set result [lindex $analyzerInfoStr 3]
                srcAssertDebOpen -AssertName $name -beginTime $begin -endTime $end -TraceResult $result
            }
        }
    }

    proc removeInst {} {
        set currentWinID [verdiGetActiveWindow]
        set pContainer [verdiGetAttribute -win $currentWinID -parentWin]

        verdiDockToContainer -widget <Inst._Tree> -container $::_nTrace1
    }

    proc moveInst { pContainer } {
        #get source tab for the container
        set srcTab $::vcst::SrcTabs($pContainer)

        #get source tab widget name; get source tab size
        set containerWidth [verdiGetAttribute -win $pContainer -width]
        set containerHeight [verdiGetAttribute -win $pContainer -height]
        set idx1 [expr [string first "width" $containerWidth]+6]
        set idx2 [expr [string length $containerWidth]-1]
        set conWidth [string range $containerWidth $idx1 $idx2]
        set idx1 [expr [string first "height" $containerHeight]+7]
        set idx2 [expr [string length $containerHeight]-1]
        set conHeight [string range $containerHeight $idx1 $idx2]

        #move instance to the left of source tab
        verdiDockToContainer -widget <Inst._Tree> -container $pContainer
        if {$::vcst::_curWaveVw == ""} {
            set ::vcst::_curWaveVw [wvGetCurrentWindow -primary]
        }
        set waveDockName [verdiGetAttribute -win $::vcst::_curWaveVw -dockName]
        set naviStr [expPropGetWindowName -win $::vcst::_curWaveVw]
        set naviDocName "windowDock_$naviStr"
        verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -dock $naviDocName -left
        verdiDockWidgetMove -dock $srcTab -dock $naviDocName -left
        verdiDockWidgetMove -dock $srcTab -dock $waveDockName -bottom
        verdiDockWidgetMove -dock widgetDock_<Inst._Tree> -dock $srcTab -left
        set waveHeight [verdiGetAttribute -dock $naviDocName -height]
        verdiWidgetResize -dock $naviDocName 200 [string range $waveHeight end-3 end]

        set currentAnalyzerShown $::vcst::analyzerShown($::vcst::nWaveID($pContainer))
        if { $currentAnalyzerShown == "1" } {
            verdiDockWidgetMove -dock widgetDock_Analyzer -dock $srcTab -right
        }
        set headerHeight 30
        #Adjust size after move in isntance tree
        verdiWidgetResize -dock widgetDock_Analyzer [expr $conWidth/2] [expr ($conHeight-$headerHeight)/2]
        verdiWidgetResize -dock widgetDock_<Inst._Tree> [expr $conWidth/6] [expr ($conHeight-$headerHeight)/2]
        #verdiWidgetResize -dock $srcTab [expr $conWidth/4] [expr ($conHeight-$headerHeight)/2]
        verdiWindowResize -win $pContainer $conWidth $conHeight
    }

    #usage: instanceBtnPressed <wvWinID> or without option
    proc instanceBtnPressed { {wvWinId "-1"} } {
        if { $wvWinId == "-1" } {
            set currentWinID [verdiGetActiveWindow]
        } else {
            set currentWinID $wvWinId
        }
        #log instance command to verdi.cmd log
        verdiLogCommand ::vcst::instanceBtnPressed $currentWinID

        set pContainer [verdiGetAttribute -win $currentWinID -parentWin]
        #if nWave is undocked or not in a UDW, exit the proc
        if { $pContainer == 0 } { return }
        set isUDWContainer [string first "Unified Debug:" [verdiGetAttribute -win $pContainer -title]]
        if { $isUDWContainer == "-1" } { return }
        #check source tab, if no source tab, give warning and return
        set srcTab $::vcst::SrcTabs($pContainer)
        #make sure srcTab exists and in show status before move/remove instance pane
        set srcShowState [verdiGetAttribute -dock $srcTab -show_state]
        if { $srcShowState == "0" } { 
            qwAction -id $currentWinID -name "addInst" -disabled
            verdiShowMessage -warn {No source tab in current unified debug window, so "Show Instance" is disabled!}
            #return
        }

        #disable auto-primaryFSDB changeLayout
        set ::vcst::_primaryFsdbAutoChange 0
        #check show_state
        set idx [expr [string first "show_state=hidden" $srcShowState]]
        if { $idx != "-1" } {
            #src is hidden, show srcTab
            verdiDockWidgetDisplay -dock $srcTab
        }

        #puts "Move instance to $pContainer"
        set currentInstShown $::vcst::instShown($currentWinID)
        if { $currentInstShown == "0" } {
            #when there is no source tab, do not move instance in.
            if { $srcShowState == "0" } {
                set ::vcst::_primaryFsdbAutoChange 1
                return 
            }
            moveInst $pContainer
            qwAction -id $currentWinID -name "addInst" -checked -visible
            set ::vcst::instShown($currentWinID) 1
            #uncheck other UDWin's instance button
            uncheckOtherUDWinInstBtn $pContainer
        } else {
            removeInst
            verdiWindowRaise -win $pContainer
            qwAction -id $currentWinID -name "addInst" -unchecked -visible
            set ::vcst::instShown($currentWinID) 0
        }

        #enable auto-primaryFSDB change after 3 seconds, to avoid GUI flicker
        after 3000 {set ::vcst::_primaryFsdbAutoChange 1}
    }


    proc instanceBtnPressedForVerdi { } {
        verdiLogCommand ::vcst::instanceBtnPressedForVerdi
        verdiDockToContainer -widget <Inst._Tree> -container $::_nTrace1
        set currentWinID [verdiGetActiveWindow]
        uncheckOtherUDWinInstBtn $currentWinID
    }

    #to uncheck other unified debug win's instance button
    proc uncheckOtherUDWinInstBtn { curContainer } {
        set winCnt [verdiGetTypeCount -docker]
        verdiWindowIterNext -docker -begin
        for { set i 1 } { $i<$winCnt } {incr i} {
            set subWinId [verdiWindowIterNext -docker]
            if { $subWinId != "0" } {
                set winTitle [verdiGetAttribute -win $subWinId -title]
                set idx [expr [string first "Unified Debug:" $winTitle]]
                if { $idx != "-1" } {
                    #found unfied debug window
                    if { $subWinId != $curContainer } {
                        #get waveID for the container
                        set waveId $::vcst::nWaveID($subWinId)
                        qwAction -id $waveId -name "addInst" -unchecked
                        set ::vcst::instShown($waveId) 0
                    }
                }
            }
        }
    }

    #Get the index from srcTab string (format: widgetDock_MTB_SOURCE_TAB_x) 
    proc getSourceTabIndex { UDWinId } {
        set srcTab $::vcst::SrcTabs($UDWinId)
        set idx [string length "widgetDock_MTB_SOURCE_TAB_"]
        return [string range $srcTab $idx end]
    }

    #check if active window is unified debug window; set primary FSDB/wv; active correct source tab
    proc setPrimaryWvWin { activeId } {
        if { $::vcst::_primaryFsdbAutoChange == "0" } {
            return
        }
        #disable auto-primaryFSDB change during primary fsdb setting
        set ::vcst::_primaryFsdbAutoChange 0

        set winTitle [verdiGetAttribute -win $activeId -title]
        #active window can be container, navigator or the nWave, all should work
        set ::idx1 [string first "nWave:" $winTitle]
        set ::idx2 [string first "Unified Debug:" $winTitle]
        set ::idx3 [string first "navigator:" $winTitle]
        if { $::idx1 == "-1" && $::idx2 == "-1" && $::idx3 == "-1"} {
            # NOT nWave, navigator window nor UDWin, return
            # enable source tab RMB "add to New Waveform"
            verdiEnableCommand -on -act Verdi_1_MTB_SOURCE_TAB_1_srcAddSignalToWaveMenu_NewWaveform
            set ::vcst::_primaryFsdbAutoChange 1
            if { $vcst::_currentActWinIsUDW != "0" } {
                # UDW -> non_UDW, set active source tab back to main window
                set vcst::_currentActWinIsUDW 0
                set srcTab [vcst::getMainWindowSourceTab]
                srcSetActiveSourceTab -win $::_nTrace1 -lockTab -tab $srcTab
            }
            return
        } else {
            # nWave or navigator
            if { $::idx1 != "-1" || $::idx3 != "-1"} {
                set parentID [verdiGetAttribute -win $activeId -parentWin]
                set winTitle [verdiGetAttribute -win $parentID -title]
                set idx [expr [string first "Unified Debug:" $winTitle]]
                #parent win is NOT unified debug, set active source tab back to main window and return
                if { $idx == "-1" } {
                    # enable source tab RMB "add to New Waveform"
                    verdiEnableCommand -on -act Verdi_1_MTB_SOURCE_TAB_1_srcAddSignalToWaveMenu_NewWaveform
                    set ::vcst::_primaryFsdbAutoChange 1
                    if { $vcst::_currentActWinIsUDW != "0" } {
                        set vcst::_currentActWinIsUDW 0
                        set srcTab [vcst::getMainWindowSourceTab]
                        srcSetActiveSourceTab -win $::_nTrace1 -lockTab -tab $srcTab
                    }
                    return
                }
                #parent is UDW
                if { [info exists ::vcst::nWaveID($parentID)] } {
                    wvSetPrimaryWindow -win $activeId
                    #check if there is Analyzer in current window
                    if { [verdiGetAttribute -dock widgetDock_Analyzer -show_state] == "0"} {
                        qwAction -id $waveId -name "addAnaly" -unchecked
                    } else {
                        #should NOT always restore Analyzer -- causes blink; causes nWave lost new changes
                        #ONLY restore Analyzer if UDW id changes (current UDW is not previous UDW)
                        #puts "previous UDW id: $vcst::_currentActWinIsUDW, current UDW id: $parentID"
                        if { $parentID != $vcst::_currentActWinIsUDW } {
                            restoreAnalyzer $parentID
                        }
                    }
                    #also set source tab to active
                    set tabIdx [getSourceTabIndex $parentID]
                    srcSetActiveSourceTab -tab $tabIdx
                    # disable add to New Waveform
                    verdiEnableCommand -off -act Verdi_1_MTB_SOURCE_TAB_1_srcAddSignalToWaveMenu_NewWaveform
                }
                set vcst::_currentActWinIsUDW $parentID
            } elseif  { $::idx2 != "-1" } {
                # active win is UDW
                #find waveID for the container
                if {[info exists ::vcst::nWaveID($activeId)]} {
                    set waveId $::vcst::nWaveID($activeId)
                    wvSetPrimaryWindow -win $waveId
                    if { [verdiGetAttribute -dock widgetDock_Analyzer -show_state] == "0"} {
                        qwAction -id $waveId -name "addAnaly" -unchecked
                    } else {
                        #ONLY restore Analyzer if UDW id changes (current UDW is not previous UDW)
                        #puts " previous UDW id: $vcst::_currentActWinIsUDW, current UDW id: $activeId"
                        if { $activeId != $vcst::_currentActWinIsUDW } {
                            restoreAnalyzer $activeId
                        }
                    }
                    set tabIdx [getSourceTabIndex $activeId]
                    srcSetActiveSourceTab -tab $tabIdx
                    # disable add to New Waveform
                    verdiEnableCommand -off -act Verdi_1_MTB_SOURCE_TAB_1_srcAddSignalToWaveMenu_NewWaveform
                }
                set vcst::_currentActWinIsUDW $activeId
            }
        }

        set ::vcst::_primaryFsdbAutoChange 1
    }

    #get the available source tab of nTrace window
    proc getMainWindowSourceTab {} {
        #iterate all docks and find the first source which parent is nTraceMain
        verdiWindowIterNext -dock -begin
        set dockID [verdiWindowIterNext -dock]
        while { $dockID != "0" } {
            set dockTitle [verdiGetAttribute -dock $dockID -title]
            set idx [string first "widgetDock_MTB_SOURCE_TAB" $dockTitle]
            if { $idx != "-1" } {
                #check parent for nTrace
                set parentID [verdiGetAttribute -dock $dockID -parentWin]
                set winTitle [verdiGetAttribute -win $parentID -title]
                set idx1 [string first "nTraceMain:" $winTitle]
                if { $idx1 != "-1" } {
                    #parent is nTrace, get tab number
                    set idx1 [expr [string length "widgetDock_MTB_SOURCE_TAB_"]+1]
                    set idx2 [expr [string first "\]: title" $dockTitle]-1]
                    set sourceTab [string range $dockTitle $idx1 $idx2]
                    set ::vcst::SrcTabs($parentID) $sourceTab
                    #puts " source $sourceTab is in nTrace: $parentID"
                    return $sourceTab
                }
            }
            set dockID [verdiWindowIterNext -dock]            
        }
    }

    #YZF: set Trace Analysis result array for nWave to show tooltip and icon
    proc setTraceAnalysisInfo { signal group tooltip } {
        set ::vcst::SignalGroup($::vcst::actualFsdb,$signal) $group
        set ::vcst::SignalToolTip($::vcst::actualFsdb,$signal) $tooltip
    }

    proc restoreTraceAnalysisInfo { fsdb signal group tooltip } {
        set ::vcst::SignalGroup($fsdb,$signal) $group
        set ::vcst::SignalToolTip($fsdb,$signal) $tooltip
    }

    # save trace analysis result for save/restore
    proc saveTraceAnalysisStr { infoStr } {
        # Note: save when actualFsdb is available
        set ::vcst::TraceAnalysisArray($::vcst::actualFsdb) $infoStr
        # also save fsdb(wv) map, for cleanup usage
        set ::vcst::traceActualFsdb($::vcst::_curWaveVw) $::vcst::actualFsdb
    }

    # show trace analysis result (for test only)
    proc showTraceAnalysisStr {} {
        puts "Trace Analysis Strings:"
        set searchId [array startsearch ::vcst::TraceAnalysisArray]
        while {[array anymore ::vcst::TraceAnalysisArray $searchId]==1} {
            set elem [array nextelement ::vcst::TraceAnalysisArray $searchId]
            puts "    FSDB:$elem"
            puts "    Str: $vcst::TraceAnalysisArray($elem)"
        }
    }

    # clean up string and arrays
    proc unsetTraceAnalysisStr { wvWin } {
        #get fsdb by waveID
        set fsdb $vcst::traceActualFsdb($wvWin)
        #puts ">>>actual fsdb: $fsdb"
        if {[info exists ::vcst::TraceAnalysisArray($fsdb)]} {
            unset vcst::TraceAnalysisArray($fsdb)
        }
        if {[info exists ::vcst::traceActualFsdb($wvWin)]} {
            unset vcst::traceActualFsdb($wvWin)
        }
        #unset arrays: find array which contents $fsdb in element
        set elemList [array names vcst::SignalGroup $fsdb,*]
        foreach elem $elemList {
            #puts "RM: $elem"
            if {[info exists ::vcst::SignalGroup($elem)]} {
                unset ::vcst::SignalGroup($elem)
                unset ::vcst::SignalToolTip($elem)
            }
        }
    }

    # get all fsdb file name as a list to save all available trace infos
    proc getFsdbList { } {
        #get wvWindow list(wvGetAllWindows); get activeFsdb list
        set lst {}
        set wvList [wvGetAllWindows]
        foreach wv $wvList {
            #puts $wv
            set fsdb [wvGetActiveFileName -win $wv]
            lappend lst $fsdb
        }
        return $lst
    }

    # get trace analysis string for save session
    proc getTraceAnalysisFullStr {}  {
        set str ""
        set fsdbList [vcst::getFsdbList]
        foreach fsdb $fsdbList {
            if { [info exists vcst::TraceAnalysisArray($fsdb)] } {
                append str $fsdb "!;" $vcst::TraceAnalysisArray($fsdb) "!,"
            }
        }
        return $str
    }

    #YZF: show signal tooltip and group, for debug and test
    proc showTraceAnalysisInfo {} {
        set searchId [array startsearch ::vcst::SignalToolTip]
        while {[array anymore ::vcst::SignalToolTip $searchId]==1} {
            set elem [array nextelement ::vcst::SignalToolTip $searchId]
            puts "$elem :"
            puts "         Group: $vcst::SignalGroup($elem); Tooltip: $vcst::SignalToolTip($elem)"

        }
    }

    #1 for find free UDWin, 0 for no free UDWin
    proc getFreeUDWin {} {
        set free 0
        set winCnt [verdiGetTypeCount -docker]
        # if no top window, return 0
        if { $winCnt == "0"} { return 0 }
        #top window
        set UDWinCnt 0
        #iterate all windows
        verdiWindowIterNext -docker -begin
        for { set i 1 } { $i<$winCnt } {incr i} {
            set subWinId [verdiWindowIterNext -docker]
            #puts $subWinId
            if { $subWinId != "0" } {
                set winTitle [verdiGetAttribute -win $subWinId -title]
                #search Unifed Debug Window, increase UDWin count
                set idx [expr [string first "Unified Debug:" $winTitle]]
                if { $idx != "-1" } { 
                    incr UDWinCnt
                }
            }
        }

        #Support 7 UDWin for now. Can be extended to 7 later.
        if { $UDWinCnt < 7 } {
            set free 1 
        } else { set free 0 }
        #use action to send freeUDWin to VCF
        set cmd "action aaMonetFreeUDWin -data \{$free\} -trigger"
        verdiRunVcstCmd $cmd -no_wait

        #puts "FreeUDW: $free"
        return $free
    }

    #update lasyout and toolbar for spyglass mode
    proc updateSpyglassLayout {} {
        global _Verdi_1
        if {[info exists ::env(VERDI_SG_WORKMODE)]} {
            verdiWindowWorkMode -win $_Verdi_1 -spyGlassDebug
            verdiDockWidgetSetCurTab -dock windowDock_vcstConsole_2
            verdiMoveToTailMenu -type nSchema -act {schPortNameVis schPinNameVis schModulePortNameVis schModuleNameVis schEntityNameVis schArchNameVis schInstNameVis schLocalNetVis schCompleteNameVis schCompleteNameVis schLocalNameVis schPGPinVis }
            verdiMoveToTailMenu -type nSchema -act {schChangeColor schColorInstByScope schResetAllColor}
            verdiMoveToTailMenu -type Verdi -act {hbToggleParaAnnot}
            verdiMoveToTailMenu -type Verdi -act {hbToggleSrcLineNum}
        }
    }

    #YZF: reset UDWin after session restored 
    #1. add action to toolbarGroup
    #2. list all waveWindow, and get all UDW
    #3. Set correct mapping: UDW-nWave, UDW-SourceTab, instance shown, analyzer status
    #   ::vcst::analyzerShown($waveID),::vcst::AnalyzerFlag($container)
    #   ::vcst::containerID($waveID),::vcst::nWaveID($container)
    #   ::vcst::instShown($waveID)
    #   ::vcst::SrcTabs($container)
    #4. For each sourceTab: reset source toolbar
    proc resetUDWinAfterSesRestore {} {
        #puts " ---------- start to restore buttons and mapping ---------- "
        if { $::vcst::EnableUDWin != "1" } { 
            return
        }
        qwConfig -type nWave -cmds [list {qwAddToolBarGroup -group "UDWinGroup"}]
        qwAction -id $_Verdi_1 -name "addInstForVerdi" -visible
        # UDW and nWave mapping
        set wvList [wvGetAllWindows]
        foreach wvWin $wvList {
            set parentID [verdiGetAttribute -win $wvWin -parentWin]
            set winTitle [verdiGetAttribute -win $parentID -title]
            set idx [expr [string first "Unified Debug:" $winTitle]]
            if { $idx != "-1" } {
                #puts "wvWin $wvWin is in UDW: $parentID"
                qwAction -id $wvWin -name "addInst" -visible
                qwAction -id $wvWin -name "resetLayout" -invisible
                qwAction -id $wvWin -name "addAnaly" -invisible -checked
                qwAction -id $wvWin -name "assertAnalyzer" -invisible
                set ::vcst::nWaveID($parentID) $wvWin
                set ::vcst::containerID($wvWin) $parentID
                set ::vcst::instShown($wvWin) 0
                set ::vcst::analyzerShown($wvWin) 0
                set ::vcst::AnalyzerFlag($parentID) 0

                #also restore analzyer mapping, restore analyzerFlag
                set index [getVfIndex $wvWin]
                if { [info exist ::vcst::sessionAnalyzerInfo($index)] } {
                    set ::vcst::analyzerSetupInfo($parentID) $::vcst::sessionAnalyzerInfo($index)
                    #restore analyzerFlag (if analyzerInfo exists, flag = 1)
                    set ::vcst::AnalyzerFlag($parentID) 1
                }
            }
        }

        # UDW and source mapping, instance shown status
        verdiWindowIterNext -dock -begin
        set dockID [verdiWindowIterNext -dock]
        while { $dockID != "0" } {
            set dockTitle [verdiGetAttribute -dock $dockID -title]
            set idx [expr [string first "widgetDock_MTB_SOURCE_TAB" $dockTitle]]
            if { $idx != "-1" } {
                #check parent for UDW
                set parentID [verdiGetAttribute -dock $dockID -parentWin]
                set winTitle [verdiGetAttribute -win $parentID -title]
                set idx1 [expr [string first "Unified Debug:" $winTitle]]
                if { $idx1 != "-1" } {
                    #found UDW
                    set idx2 [expr [string first "\]: title" $dockTitle]-1]
                    set sourceTab [string range $dockTitle $idx $idx2]
                    set ::vcst::SrcTabs($parentID) $sourceTab
                    #puts " source $sourceTab is in UDW: $parentID"
                    #resotre source toolbar buttons
                    verdiAddBannerAct -dock $sourceTab \
                            TextShowCallingScopeGroup TextShowDefinedScopeGroup \
                            UndoTraceGroup RedoTraceGroup ToolBarTraceDriverGroup ToolBarTraceLoadGroup \
                            TextGoPrevInstGroup TextGoNextInstGroup TextGoPrevGroup TextGoNextGroup
                }
            }
            set idx2 [expr [string first "<Inst._Tree>" $dockTitle]]
            if { $idx2 != "-1" } {
                set parentID [verdiGetAttribute -dock $dockID -parentWin]
                set winTitle [verdiGetAttribute -win $parentID -title]
                set idx1 [expr [string first "Unified Debug:" $winTitle]]
                if { $idx1 != "-1" } {
                    set waveId $::vcst::nWaveID($parentID)
                    qwAction -id $waveId -name "addInst" -checked -visible
                    set ::vcst::instShown($waveId) 1
                    #puts " instance is shown in UDW: $parentID"
                }
            }

            #restore analyzerShown
            set idx3 [string first "Analyzer" $dockTitle]
            if { $idx3 != "-1" } {
                set parentID [verdiGetAttribute -dock $dockID -parentWin]
                set winTitle [verdiGetAttribute -win $parentID -title]
                set idx [expr [string first "Unified Debug:" $winTitle]]
                if { $idx != "-1" } {
                    set waveId $::vcst::nWaveID($parentID)
                    set ::vcst::analyzerShown($waveId) 1
                    #disable current wvWin Analyzer button
                    qwAction -id $waveId -name "addAnaly" -disabled
                    #enable other containers' analyzer button
                    uncheckOtherUDWinAnalyzerBtn $parentID
                }
            }

            set dockID [verdiWindowIterNext -dock]
        }
        #puts " -------- End of restore buttons and mapping -------- "
    }

    # Action for clicking hier ref hyperlink in SmartLog
    proc probeHierRef { hierName } {
      set top [set ::vcst::_top]
      set covDut [set ::vcst::_covDut]
      set containTop [regexp -nocase ^$top $hierName]
      set containDut [regexp -nocase ^$covDut $hierName]
      if {$covDut == ""} {set containDut 0}
      set fullHierName "$hierName"
      if {$containTop == 0 && $containDut == 0} {
        set fullHierName "$top.$hierName"
      } elseif {$containDut == 1} {
        regsub $covDut $hierName $top fullHierName
      } 
      
      srcSetScope -win $::_nTrace1 "$fullHierName" -delim "."
      verdiRunVcstCmd action aaMonetSelectProperties -data $fullHierName -trigger -no_wait
    }
}

proc verdiFusaLoadFdb {server fdb campaign tool} {
    if {[info exists ::env(VERDI_FUSA_DEBUG)]} {
        if {![fusaFdbLoaded]} {
            fusaSummary -loaddb -fdb_server $server -fdb_name $fdb -campaign $campaign -tool $tool 
        } else {
            set fdbInfo [fusaFdbInfo]
            if {[string compare $fdbInfo 0]} {
                set fdbInfoList [split $fdbInfo]
                if {[llength $fdbInfoList] == 4} {
                    set curServer [lindex $fdbInfoList 0]
                    set curFdb [lindex $fdbInfoList 1]
                    set curCamp [lindex $fdbInfoList 2]
                    set curTool [lindex $fdbInfoList 3]
                    set serverEq [expr {![string compare $curServer $server]}]
                    set fdbEq [expr {![string compare $curFdb $fdb]}]
                    set campEq [expr {![string compare $curCamp $campaign]}]
                    set toolEq [expr {![string compare $curTool $tool]}]
                    if {[expr {$serverEq && $fdbEq && $campEq && $toolEq}]} {
                        fusaSummary -action reloadDB -item DB
                    } else {
                        fusaSummary -action closeDB 
                        fusaSummary -loaddb -fdb_server $server -fdb_name $fdb -campaign $campaign -tool $tool
                    } 
                }   
            }
        }
    }
}

proc showSourceWarning { signal msg designTop } {
    set result [ srcShowDefine -incrSearch "$signal" ]
    if {"$result" == "0"} {
        set result2 [ srcShowDefine -incrSearch "$designTop.$signal" ]
        if {"$result2" == "0"} {
            verdiShowMessage -warn "$msg" 
        }
    }
}

proc syncSignoffCovParamFromRcFile { } {
    set time [verdiGetRCValue -section SignoffToolBar -key Time]
    set bound [verdiGetRCValue -section SignoffToolBar -key Bound]
    set hasCOI [verdiGetRCValue -section SignoffToolBar -key hasCoi]
    set hasOC [verdiGetRCValue -section SignoffToolBar -key hasOC]
    set hasFC [verdiGetRCValue -section SignoffToolBar -key hasFC]
    set isBounded [verdiGetRCValue -section SignoffToolBar -key isBounded]
    set Signoff_DB [verdiGetRCValue -section SignoffToolBar -key Signoff_DB]
    set Overwrite [verdiGetRCValue -section SignoffToolBar -key Overwrite]
    set smartMerge [verdiGetRCValue -section SignoffToolBar -key smartMerge]
    #set low effort default
    set Effort 0 
    syncSignoffCovParamToFormalDialog $time $bound $hasCOI $hasOC $hasFC $isBounded $Signoff_DB $Overwrite $smartMerge $Effort 
}

proc syncSignoffCovParamToFormalDialog { time bound hasCOI hasOC hasFC isBounded signoff_DB overwrite smartMerge effort { type { }} } {
    set cmd "action aaMonetSyncSignoffCovParam"
    #effortIndex,bound,isOc,isFc,isBounded,path,isOverwrite,time,type
    if {$time != ""} {
        append cmd " -time "
        set firstChar [string range $time 0 0]
        if { $firstChar == "-" } {
            append cmd "neg_prefix_internal"
        }
        append cmd $time
    }

    if {$bound != ""} {
        append cmd " -bound "
        set firstChar [string range $bound 0 0]
        if { $firstChar == "-" } {
            append cmd "neg_prefix_internal"
        }
        append cmd $bound
    }
    if {$hasCOI != ""} {
        append cmd " -isCoi "
        append cmd $hasCOI
    }
    if {$hasOC != ""} {
        append cmd " -isOc "
        append cmd $hasOC
    }

    if {$hasFC != ""} {
        append cmd " -isFc "
        append cmd $hasFC
    }

    if {$isBounded != ""} {
        append cmd " -isBounded "
        append cmd $isBounded
    }

    if {$signoff_DB != ""} {
        append cmd " -path "
        append cmd $signoff_DB
    }
    
    if {$overwrite != ""} {
        append cmd " -isOverwrite "
        append cmd $overwrite
    }
    
    if {$smartMerge != ""} {
        append cmd " -isSmartMerge "
        append cmd $smartMerge
    }

    if {$effort != ""} {
        append cmd " -effortIndex "
        append cmd $effort
    }

    if { ( [llength $type ] != 0 ) } {
        append cmd " -type {"
        append cmd $type
        append cmd " }"
    }
    append cmd " -trigger"
    set runCmd "___fvSyncSignoffCovParam {$cmd}"
    verdiRunVcstCmd $runCmd -no_wait
}

#--------------------------------------------------------------------------------
#if {![info exist env(VERDI_VCST_MASTER)]} { 
#verdiShowWindow -win Verdi_1 -min
#verdiSetUpdatesEnabled -off
#}

verdiSetPrefEnv -bKeepUndockedWidgetsOnTop "off"

if {[info exist env(SNPS_VCS_INTERNAL_MONET_VERDI_SHOW_MIN)] && ![info exist env(SNPS_VCS_INTERNAL_VERDI_BACKGROUND)]} {
    verdiShowWindow
    #verdiLayoutFreeze
}

# Hide unused toolbar
if {![info exist env(SNPS_VERDI_INTERNAL_NAVIGATOR)]} {
    if {[info exist env(SNPS_VCS_INTERNAL_MONET_FV_BETA)]} {
        verdiToolBar -win  $_Verdi_1 -toolbar HB_IMPORT_COMMAND_PANEL -hide
        verdiToolBar -win  $_Verdi_1 -toolbar toolBarFormalVerification -moveToFirst
        verdiToolBar -win  $_Verdi_1 -toolbar HB_BA_COMMAND_PANEL -moveToAf VC_APPS_TOOL_BOX
        qwConfig -type Verdi -cmds [list {
            qwAction -name "hbInvokeEuclide" -invisible
        } {
            qwAction -name "hbInvokeWave" -invisible
        } {
            qwAction -name "schCreateWindowByScopeGroup" -invisible
        } {
            qwAction -name "tsCreateSchemaGroup" -invisible
        } {
            qwAction -name "hbAMSConfiguration" -invisible 
        } {
            qwAction -name "ToggleBookmarkGroup" -invisible
        } ]
    } else {
        verdiToolBar -win  $_Verdi_1 -toolbar HB_IMPORT_COMMAND_PANEL -hide
        verdiToolBar -win  $_Verdi_1 -toolbar HB_SIGNAL_PANE_PANEL -hide
        verdiToolBar -win  $_Verdi_1 -toolbar HB_MULTI_TAB_PANEL -hide
        verdiToolBar -win  $_Verdi_1 -toolbar NOVAS_TBBR_COMMAND  -hide
        verdiToolBar -win  $_Verdi_1 -toolbar ABV_ADD_TEMPORARY_ASSERT_PANEL -hide
        verdiToolBar -win  $_Verdi_1 -toolbar VC_APPS_TOOL_BOX -hide
        verdiToolBar -win  $_Verdi_1 -toolbar AMS_CONFIG_TOOLBAR -hide
    }
}

trace variable ::vcst::_navTarget w ::vcst::updateNavTarget

return 1;
verdiWindowResize -win $_Verdi_1 "0" "0" "1143" "745"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSetPreference -vhdlcase original
schUnifiedNetList
verdiRunVcst -on
schSetVCSTDelimiter -hierDelim "/"
srcSetPreference -delimiterforFindSignal_Inst_Instport "/"
srcSetPreference -skipTopLevelName on
srcSetPreference -copyScopeNameDelimiter "/"
wvSetPreference -overwrite off
wvSetPreference -getAllSignal off
schUnifiedNetList -batchmode on
simSetSimulator "-vcssv" -exec \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/design/m_vlsi_qspi_top.exe" \
           -args
debImport "-simflow" "-smart_load_kdb" "-dbdir" \
          "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/design/m_vlsi_qspi_top.exe.daidir"
srcSetDecoration -reset
srcSetDecoration -inst "1"
schResetDisplayAttr -white
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/signalnames.xml"
srcSetPreference -tabNum 16
verdiWindowResize -win $_Verdi_1 "100" "200" "1100" "800"
verdiWindowResize -win $_Verdi_1 "100" "200" "1100" "800"
verdiSetPrefEnv -bDockNewCreatedWindowInContainer "on"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema2
schGetCurrentWindow
verdiWindowResize -win $_dockContainer_1 -2 -23 "1912" "1020"
verdiSetActWin -win $_nSchema_2
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"124\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[27:24\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_id/Q\[3:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4c1c69d0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoomIn -win $_nSchema2 -pos 60575 16274
schZoomIn -win $_nSchema2 -pos 60575 16274
schZoomOut -win $_nSchema2 -pos 60574 16274
schZoomOut -win $_nSchema2 -pos 60035 16094
schZoomOut -win $_nSchema2 -pos 59660 15869
schZoomIn -win $_nSchema2 -pos -2845 17366
schZoomOut -win $_nSchema2 -pos 1085 18279
schZoomOut -win $_nSchema2 -pos 1173 18279
schZoomOut -win $_nSchema2 -pos 2709 17730
schZoom {16689} {-1459} {174175} {39523} -win $_nSchema2
schSetOptions -win $_nSchema2 -highContrastMode on
schSetOptions -win $_nSchema2 -highContrastMode off
schSelect -win $_nSchema2 -instpin \
          "m_vlsi_qspi_top.u_axi_ctrl.u_arfifo.u_wval_sync.sync_multi\[0\].u_wval_sync.reg_sync" \
          "CLK"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
schProperties -win $_nSchema2 -Basic on -CDC on
schSelect -win $_nSchema2 -instpin \
          "m_vlsi_qspi_top.u_axi_ctrl.u_arfifo.u_wval_sync.sync_multi\[0\].u_wval_sync.reg_sync" \
          "CLK"
schSelect -win $_nSchema2 -instpin \
          "m_vlsi_qspi_top.u_axi_ctrl.u_arfifo.u_wval_sync.sync_multi\[0\].u_wval_sync.reg_sync" \
          "CLK"
schTraceDriver -win $_nSchema2
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4c1c69d0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoomOut -win $_nSchema2 -pos 70 6912
schZoomOut -win $_nSchema2 -pos 88 6926
schZoomOut -win $_nSchema2 -pos 87 6926
schZoomOut -win $_nSchema2 -pos 123 6926
schZoomOut -win $_nSchema2 -pos 123 6925
schZoomOut -win $_nSchema2 -pos 156 7033
schZoomOut -win $_nSchema2 -pos 157 7033
schZoomOut -win $_nSchema2 -pos 157 7033
schZoomOut -win $_nSchema2 -pos 157 7033
schZoomOut -win $_nSchema2 -pos 156 7033
schZoomOut -win $_nSchema2 -pos 156 7032
schZoomOut -win $_nSchema2 -pos 157 7032
schZoomOut -win $_nSchema2 -pos 156 7032
schZoomOut -win $_nSchema2 -pos 157 7031
schZoomOut -win $_nSchema2 -pos 156 7031
schZoomOut -win $_nSchema2 -pos 156 7030
schZoomOut -win $_nSchema2 -pos 156 7030
schZoomIn -win $_nSchema2 -pos 23879 9436
schZoomIn -win $_nSchema2 -pos 23879 9436
schZoomIn -win $_nSchema2 -pos 23878 9436
schZoomOut -win $_nSchema2 -pos 24603 8072
schZoomOut -win $_nSchema2 -pos 24422 8072
schZoomOut -win $_nSchema2
schZoomIn -win $_nSchema2 -pos 25003 9137
schZoomIn -win $_nSchema2 -pos 25003 9137
schZoomIn -win $_nSchema2 -pos 25003 9136
schZoomIn -win $_nSchema2 -pos 25003 9136
schZoomIn -win $_nSchema2 -pos 21904 9279
schZoomOut -win $_nSchema2 -pos 18999 9042
schZoomOut -win $_nSchema2 -pos 18918 8504
schZoomOut -win $_nSchema2 -pos 21137 7058
schZoomOut -win $_nSchema2 -pos 72823 13156
schZoomOut -win $_nSchema2 -pos 74924 16780
schSelect -win $_nSchema2 -signal \
          "m_vlsi_qspi_top.u_axi_ctrl.u_axi_sclk_logic.N_39\[3\]"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
schProperties -win $_nSchema2 -Basic on -CDC on
schSelect -win $_nSchema2 -signal "m_vlsi_qspi_top.u_axi_ctrl.w_arb_write_en"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
schProperties -win $_nSchema2 -Basic on -CDC on
schProperties -win $_nSchema2 -Basic on -CDC on
schSelect -win $_nSchema2 -signal "m_vlsi_qspi_top.u_axi_ctrl.w_arfifo_empty"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
schProperties -win $_nSchema2 -Basic on -CDC on
schZoomOut -win $_nSchema2 -pos 151360 12841
schZoomIn -win $_nSchema2 -pos 81597 3895
schCloseWindow -win $_nSchema2
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema3
schGetCurrentWindow
verdiSetActWin -win $_nSchema_3
verdiWindowResize -win $_dockContainer_2 -4 -46 "1912" "1020"
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"169\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q\[7:0\]\[23:0\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_addr/Q\[23:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4c1c69d0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nSchema_3
schCloseWindow -win $_nSchema3
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema4
schGetCurrentWindow
verdiWindowResize -win $_dockContainer_3 -6 -69 "1912" "1020"
verdiSetActWin -win $_nSchema_4
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"117\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_rd_last/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4df35000\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schCloseWindow -win $_nSchema4
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema5
schGetCurrentWindow
verdiSetActWin -win $_nSchema_5
verdiWindowResize -win $_dockContainer_4 -8 -92 "1912" "1020"
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"180\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_id/Q\[3:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4dfeaa30\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schCloseWindow -win $_nSchema5
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema6
schGetCurrentWindow
verdiWindowResize -win $_dockContainer_5 -10 -115 "1912" "1020"
verdiSetActWin -win $_nSchema_6
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"172\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[23:0\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_addr/Q\[23:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4e01d7e0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nSchema_6
schCloseWindow -win $_nSchema6
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema7
schGetCurrentWindow
verdiSetActWin -win $_nSchema_7
verdiWindowResize -win $_dockContainer_6 -12 -138 "1912" "1020"
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"140\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_pending/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4f072460\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema8
schGetCurrentWindow
verdiSetActWin -win $_nSchema_8
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"225\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_rfifo/rd_comb_val\[0\]&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4e8897e0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {22170} {40857} {91255} {72797} -win $_nSchema8
schZoomOut -win $_nSchema8 -pos 47337 62103
schZoomOut -win $_nSchema8 -pos 47336 62103
schZoomOut -win $_nSchema8 -pos 47337 62103
schZoomOut -win $_nSchema8 -pos 47337 62103
schZoomOut -win $_nSchema8 -pos 47336 62102
schZoomIn -win $_nSchema8 -pos 7659 5605
schZoomIn -win $_nSchema8 -pos 7766 5604
schZoomIn -win $_nSchema8 -pos 8009 6331
schZoomOut -win $_nSchema8 -pos 11890 24404
schZoomOut -win $_nSchema8 -pos 11890 24404
schZoomOut -win $_nSchema8 -pos 11890 24404
schZoomOut -win $_nSchema8 -pos 11890 24404
schZoomIn -win $_nSchema8 -pos 54532 19573
schZoomIn -win $_nSchema8 -pos 54532 19574
schZoomIn -win $_nSchema8 -pos 54532 19574
schZoomIn -win $_nSchema8 -pos 54532 19511
schZoomIn -win $_nSchema8 -pos 54532 18902
schZoomOut -win $_nSchema8 -pos 54531 18725
schZoomOut -win $_nSchema8 -pos 54531 18725
schZoomOut -win $_nSchema8 -pos 54531 18725
schZoomOut -win $_nSchema8 -pos 54530 18725
schZoomIn -win $_nSchema8 -pos 38575 -1090
schZoomIn -win $_nSchema8 -pos 45715 6308
schZoomOut -win $_nSchema8 -pos 45715 6307
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema9
schGetCurrentWindow
verdiSetActWin -win $_nSchema_9
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"226\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/w_write_error&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4fc5bb30\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {-20381} {-12254} {96855} {61101} -win $_nSchema9
schZoom {-12505} {-7710} {84652} {23017} -win $_nSchema9
schZoomOut -win $_nSchema9 -pos 35412 -281
schZoomOut -win $_nSchema9 -pos 35412 -281
schZoomOut -win $_nSchema9 -pos 35412 -281
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema10
schGetCurrentWindow
verdiSetActWin -win $_nSchema_10
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"227\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_bfifo/rd_comb_val\[0\]&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"50d4cbb0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema11
schGetCurrentWindow
verdiSetActWin -win $_nSchema_11
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"228\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals found but check for gray encoding of source bits skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/o_sram_addr\[0\]&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4fc2c5b0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {-20669} {1619} {151785} {73592} -win $_nSchema11
schSelect -win $_nSchema11 -inst "m_vlsi_qspi_top.u_axi_ctrl"
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/property.xml"
schProperties -win $_nSchema11 -Basic on -Library on -CDC on
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema12
schGetCurrentWindow
verdiSetActWin -win $_nSchema_12
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"221\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arbiter/o_arb_sel&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"539a8010\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {-54328} {13749} {249621} {159986} -win $_nSchema12
schZoom {-11924} {-7230} {144235} {28574} -win $_nSchema12
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema13
schGetCurrentWindow
verdiSetActWin -win $_nSchema_13
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"223\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_bus_logic/o_awfifo_we&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"556829c0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {-9294} {1431} {120347} {25032} -win $_nSchema13
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema14
schGetCurrentWindow
verdiSetActWin -win $_nSchema_14
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"229\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_RECONV_COMB&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Combinational convergence of multiple synchronized signals found but check for gray encoding of source bits is skipped&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Combinational convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_csr/reg_pready/D&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Same Source Diverging Paths\" shape=\"box\" style=\"solid\" color=\"#FFD2A5\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"5632b2d0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_pclk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schZoomOut -win $_nSchema14 -pos 37912 12121
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nSchema_14
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema15
schGetCurrentWindow
verdiSetActWin -win $_nSchema_15
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"222\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_COHERENCY_ASYNCSRCS_RECONV_SEQ&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Sequential convergence of multiple synchronized signals from mutually asynchronous sources&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Sequential convergence found at &lt;font color=&quot;#0000ff&quot;&gt;u_csr/reg_prdata/D\[30\]&lt;/font&gt;\" /><Legends><Legend name=\"Input Signals\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Synchronizers\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Converging Paths\" shape=\"box\" style=\"solid\" color=\"#FF73FF\" fill=\"1\" /><Legend name=\"Convergence Net\" shape=\"box\" style=\"solid\" color=\"#0101FF\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
schZoom {-83854} {115673} {279641} {242283} -win $_nSchema15
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4a8c2010\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_pclk\" icon=\"cipl,#ff0000\" /></H_Ports><H_Pins><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_nxt_prdata/D1\[31:0\]\" text=\"32'b00000...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_20/D1\[31:0\]\" text=\"32'bxx000...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_19/D1\[31:0\]\" text=\"32'bxx000...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_17/D0\[31:0\]\" text=\"32'bxxxx0...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_16/OUT\[31:0\]\" text=\"32'bxxxx0...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_16/D1\[31:0\]\" text=\"32'b00000...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_16/D0\[31:0\]\" text=\"32'bxxxx0...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_15/OUT\[31:0\]\" text=\"32'bxxxx0...\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_csr/I_MUX_N_15/D1\[31:0\]\" text=\"32'bxxxx0...\" icon=\"\" /></H_Pins></HighlightObjs></Command> "
schGetCurrentWindow
schZoom {-282078} {202969} {260502} {312631} -win $_nSchema15
schZoom {-9369} {213304} {96763} {245087} -win $_nSchema15
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema16
schGetCurrentWindow
verdiSetActWin -win $_nSchema_16
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"136\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"59e55a70\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
verdiShowWindow -win $_dockContainer_6 -switchFS
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema17
schGetCurrentWindow
verdiSetActWin -win $_nSchema_17
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"136\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"582b8720\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schCloseWindow -win $_nSchema7
schCloseWindow -win $_nSchema8
schCloseWindow -win $_nSchema9
schCloseWindow -win $_nSchema10
schCloseWindow -win $_nSchema11
schCloseWindow -win $_nSchema12
schCloseWindow -win $_nSchema13
schCloseWindow -win $_nSchema14
schCloseWindow -win $_nSchema15
schCloseWindow -win $_nSchema16
schCloseWindow -win $_nSchema17
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema18
schGetCurrentWindow
verdiSetActWin -win $_nSchema_18
verdiWindowResize -win $_dockContainer_7 -2 -23 "1908" "896"
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"148\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q\[7:0\]\[32\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q\[1\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4e029bd0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports><H_Pins><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/D\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/OUT\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D1\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D0\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_w_bresp/OUT\[1:0\]\" text=\"2'bx0\" icon=\"\" /></H_Pins></HighlightObjs></Command> "
schGetCurrentWindow
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema19
schGetCurrentWindow
verdiSetActWin -win $_nSchema_19
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"185\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q\[7:0\]\[31:0\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_qspi_fsm/reg_ax_wdata/Q\[31:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4e0d1290\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schCloseWindow -win $_nSchema19
verdiSetActWin -win $_nSchema_18
schCloseWindow -win $_nSchema18
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema20
schGetCurrentWindow
verdiSetActWin -win $_nSchema_20
verdiWindowResize -win $_dockContainer_8 -4 -46 "1908" "896"
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"127\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_arfifo/reg_mem/Q\[7:0\]\[27:24\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_rd_id/Q\[3:0\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"59ccf670\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema21
schGetCurrentWindow
verdiSetActWin -win $_nSchema_21
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"166\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_wfifo/reg_mem/Q\[7:0\]\[32\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_err/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"54a4ac70\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
verdiShowWindow -win $_dockContainer_8 -switchFS
schCloseWindow -win $_nSchema20
schCloseWindow -win $_nSchema21
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema22
schGetCurrentWindow
verdiWindowResize -win $_dockContainer_9 -2 -23 "1908" "896"
verdiSetActWin -win $_nSchema_22
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"140\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_pending/Q&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"4de756e0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports></HighlightObjs></Command> "
schGetCurrentWindow
schCloseWindow -win $_nSchema22
opVerdiComponents -xmlfile \
           "/home/ltthinh/PSRAM_THANG/cdc/vc_static/vcst_rtdb/.internal/verdi/schematic.xml"
schProperties -win $_nSchema23
schGetCurrentWindow
verdiWindowResize -win $_dockContainer_10 -4 -46 "1908" "896"
verdiSetActWin -win $_nSchema_23
opVerdiComponents -xmlstr \
           "<?xml version=\"1.0\"?><Command delimiter=\"/\" born_src=\"Spyglass\" name=\"schLegendInfo\" id=\"154\"><LegendInfo isShow=\"on\"><Description description=\"&lt;b&gt;&lt;font color=&quot;#0000ff&quot;&gt;CDC_UNSYNC_DATA&lt;/font&gt;:&lt;/b&gt; &lt;font color=&quot;#ff0000&quot;&gt;Partially matched data synchronization scheme found for CDC path&lt;/font&gt;&lt;br&gt;&lt;b&gt;Message: &lt;/b&gt; Partially matched data synchronization scheme found for CDC path from &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_awfifo/reg_mem/Q\[7:0\]\[28\]&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q\[1\]&lt;/font&gt;, crossing from &lt;font color=&quot;#0000ff&quot;&gt;i_aclk:1&lt;/font&gt; to &lt;font color=&quot;#0000ff&quot;&gt;i_qspi_clk:3&lt;/font&gt;\" /><Legends><Legend name=\"Source\" shape=\"box\" style=\"solid\" color=\"#800080\" fill=\"1\" /><Legend name=\"Crossing Path\" shape=\"box\" style=\"solid\" color=\"#FF8000\" fill=\"1\" /><Legend name=\"Destination\" shape=\"box\" style=\"solid\" color=\"#BE8042\" fill=\"1\" /><Legend name=\"Potential Qualifier\" shape=\"box\" style=\"solid\" color=\"#008000\" fill=\"1\" /><Legend name=\"Debug Info\" shape=\"box\" style=\"solid\" color=\"#5BA5A5\" fill=\"1\" /><Legend name=\"Partially visible Net\(s\)\" shape=\"line\" style=\"dash\" fill=\"0\" /><Legend name=\"Diveable Instance\" shape=\"box\" style=\"dash-dot\" color=\"white\" fill=\"1\" /><Legend name=\"Virtual Group\" shape=\"box\" style=\"dash\" color=\"white\" fill=\"1\" /><Legend name=\"Blackbox Module\" shape=\"box\" style=\"solid\" color=\"#A0A0A0\" fill=\"1\" /><Legend name=\"Encrypted Module\" shape=\"box\" style=\"solid\" color=\"#BEBE42\" fill=\"1\" /><Legend name=\"Abstracted view of IP\" shape=\"box\" style=\"dash-dot\" color=\"#800000\" fill=\"1\" /><Legend name=\"Constrained object\" shape=\"icon\" icon=\"constraint.png\" fill=\"0\" /></Legends></LegendInfo></Command>"
opVerdiComponents -xmlfile "vcst_rtdb/.internal/verdi/crmrln.xml"
opVerdiComponents -xmlstr \
           " <Command name=\"schSession\" delimiter=\"/\" verdiWin=\"531afcf0\"><HighlightObjs><H_Ports><H_Port name=\"m_vlsi_qspi_top/i_aclk\" icon=\"cipl,#ff0000\" /><H_Port name=\"m_vlsi_qspi_top/i_qspi_clk\" icon=\"cipl,#ff0000\" /></H_Ports><H_Pins><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/Q\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/reg_wr_resp/D\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_w_bresp/OUT\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/OUT\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D1\[1:0\]\" text=\"2'bx0\" icon=\"\" /><H_Pin name=\"m_vlsi_qspi_top/u_axi_ctrl/u_axi_sclk_logic/I_MUX_N_40/D0\[1:0\]\" text=\"2'bx0\" icon=\"\" /></H_Pins></HighlightObjs></Command> "
schGetCurrentWindow
verdiShowWindow -win $_dockContainer_10 -switchFS
schCloseWindow -win $_nSchema23
