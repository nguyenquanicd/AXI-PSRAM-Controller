#------------------------------------------------------------------------------
# Synopsys CDC Run Script
#------------------------------------------------------------------------------

# Project inputs
set FILELIST   $::env(QSPI_FILELIST)
set DEFINES    ""
set TOP_DESIGN m_vlsi_qspi_top

# CDC setup
set enable_cdc true
configure_cdc_setup_check

# Parse and elaborate
analyze \
  -format sverilog \
  -vcs "-f $FILELIST" \
  -define "$DEFINES -timescale=1ns/10ps +lint=TFIPC-L"
elaborate $TOP_DESIGN

# Reuse synthesis constraints for clocks, resets, and async groups.
source $::env(QSPI_DC_HOME)/sdc.tcl

# Declare top-level asynchronous resets for CDC/RDC setup checks.
create_reset -name i_aresetn  -async -value low [get_ports i_aresetn]
create_reset -name i_presetn  -async -value low [get_ports i_presetn]
create_reset -name i_qspi_rstn -async -value low [get_ports i_qspi_rstn]
configure_reset_propagation -propagate_through_reset_pin true

# Identify project-defined synchronizer modules for CDC analysis.
configure_cdc_nff_sync \
  -detect_full_chain true \
  -uds_modules {m_vlsi_synch m_vlsi_multi_synch}

proc qspi_cdc_collect {getter patterns} {
  set objs [$getter -quiet [lindex $patterns 0]]
  foreach pattern [lrange $patterns 1 end] {
    set objs [add_to_collection $objs [$getter -quiet $pattern]]
  }
  return $objs
}

proc qspi_configure_csr_data_sync {} {
  set csr_cfg_reg_d_pins [qspi_cdc_collect get_pins [list \
    "*/u_csr/reg_ctrl*_reg/D" \
    "*/u_csr/reg_wd_*_reg/D" \
    "*/u_csr/reg_read_*_reg/D" \
    "*/u_csr/reg_write_*_reg/D" \
    "*/u_csr/reg_wr_dummy_num_reg*/D" \
    "*/u_csr/reg_rd_dummy_num_reg*/D" \
    "*/u_csr/reg_independent*_reg/D" \
    "u_csr/reg_ctrl*_reg/D" \
    "u_csr/reg_wd_*_reg/D" \
    "u_csr/reg_read_*_reg/D" \
    "u_csr/reg_write_*_reg/D" \
    "u_csr/reg_wr_dummy_num_reg*/D" \
    "u_csr/reg_rd_dummy_num_reg*/D" \
    "u_csr/reg_independent*_reg/D"]]
  set csr_reg_prdata_d_pins [qspi_cdc_collect get_pins [list \
    "*/u_csr/reg_prdata_reg*/D" \
    "u_csr/reg_prdata_reg*/D"]]
  set csr_pwdata_q_pins [qspi_cdc_collect get_pins [list \
    "*/u_csr/reg_pwdata_reg*/Q" \
    "u_csr/reg_pwdata_reg*/Q"]]
  set csr_addr_q_pins [qspi_cdc_collect get_pins [list \
    "*/u_csr/reg_address_reg*/Q" \
    "u_csr/reg_address_reg*/Q"]]
  set csr_write_en_nets [qspi_cdc_collect get_nets [list \
    "*/u_csr/apb_write_en" \
    "u_csr/apb_write_en"]]
  set csr_read_en_nets [qspi_cdc_collect get_nets [list \
    "*/u_csr/apb_read_en" \
    "u_csr/apb_read_en"]]

  if {[sizeof_collection $csr_pwdata_q_pins] > 0 && \
      [sizeof_collection $csr_cfg_reg_d_pins] > 0 && \
      [sizeof_collection $csr_write_en_nets] > 0} {
    configure_cdc_data_sync \
      -from_obj $csr_pwdata_q_pins \
      -to_obj $csr_cfg_reg_d_pins \
      -des_enable_expr [get_object_name $csr_write_en_nets] \
      -sync_check_type enable_with_dest_domain
  }

  if {[sizeof_collection $csr_addr_q_pins] > 0 && \
      [sizeof_collection $csr_cfg_reg_d_pins] > 0 && \
      [sizeof_collection $csr_write_en_nets] > 0} {
    configure_cdc_data_sync \
      -from_obj $csr_addr_q_pins \
      -to_obj $csr_cfg_reg_d_pins \
      -des_enable_expr [get_object_name $csr_write_en_nets] \
      -sync_check_type enable_with_dest_domain
  }

  if {[sizeof_collection $csr_addr_q_pins] > 0 && \
      [sizeof_collection $csr_reg_prdata_d_pins] > 0 && \
      [sizeof_collection $csr_read_en_nets] > 0} {
    configure_cdc_data_sync \
      -from_obj $csr_addr_q_pins \
      -to_obj $csr_reg_prdata_d_pins \
      -des_enable_expr [get_object_name $csr_read_en_nets] \
      -sync_check_type enable_with_dest_domain
  }
}

qspi_configure_csr_data_sync

# Run checks
check_cdc

# Add waivers
source waiver.tcl

# Dump text reports for batch review.
report_cdc -family unsync -severity error -limit 0 -no_summary -verbose -file reports_unsync_errors.rpt
report_cdc -family data_path -severity error -limit 0 -no_summary -verbose -file reports_data_path_errors.rpt
report_cdc -only_waived -limit 0 -no_summary -verbose -file reports_waived.rpt

# Open GUI
if {[info exists ::env(DISPLAY)] && $::env(DISPLAY) ne ""} {
  start_gui
}
