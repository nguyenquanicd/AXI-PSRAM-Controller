#!/bin/csh -f
setenv VCS_HOME /tools/Synopsys/vc_static/X-2025.06/vcs-mx
setenv VC_STATIC_HOME /tools/Synopsys/vc_static/X-2025.06
setenv SYNOPSYS_SIM_SETUP /home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/design/synopsys_sim.setup

$VCS_HOME/bin/vlogan  -kdb=common_elab /home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/design/undef_vcs.v -Xvd_opts=-silent,+disable_message+C00373,-ssy,-ssv,-ssz -file /home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/design/analyzeCmd1 -kdb=incopt  -Xufe=parallel:incrdump  -full64  -libfile_opt 

$VCS_HOME/bin/vcs -file /home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/design/elaborateCmd -Xvcstatic_extns=0x4  -Xvcstatic_extns=0x100  +warn=noSM_CCE  -suppress=SM_BB_LIST  -suppress=SM_UM_LIST  -units  -error=IRRIPS  -kdb=common_elab  -Xufe=parallel:incrdump  -kdb=incopt  +warn=noKDB-ELAB-E  -Xverdi_elab_opts=-saveLevel  -verdi_opts "-logdir /home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/verdi/elabcomLog " -Xvd_opts=,-ssy,-ssv,-ssz,-silent,+disable_message+C00373, -full64 
