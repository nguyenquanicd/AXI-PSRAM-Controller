################################################################################
#This is an internally genertaed by SpyGlass for Message Tagging Support
################################################################################


use spyglass;
use SpyGlass;
use SpyGlass::Objects;
spyRebootMsgTagSupport();

spySetMsgTagCount(83,48);
spyParseTextMessageTagFile("/home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/spyglass/vc_lint0/m_vlsi_qspi_top/VC_GOAL0/spyglass_spysch/sg_msgtag.txt");

if(!defined $::spyInIspy || !$::spyInIspy)
{
    spyDefineReportGroupingOrder("ALL",
(
"BUILTIN"   => [SGTAGTRUE, SGTAGFALSE]
,"TEMPLATE" => "A"
)
);
}
spyMessageTagTestBenchmark(15,"/home/ltthinh/PSRAM_CTRL/lint/vc_static/vcst_rtdb/.internal/spyglass/vc_lint0/m_vlsi_qspi_top/VC_GOAL0/spyglass.vdb");

1;
