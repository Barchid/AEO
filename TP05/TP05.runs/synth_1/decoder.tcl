# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache /tmp/.Xil_slimani/Vivado-4888-a10p25/incrSyn
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/m1/slimani/Desktop/AEO/TP05/TP05.cache/wt [current_project]
set_property parent.project_path /home/m1/slimani/Desktop/AEO/TP05/TP05.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
set_property ip_output_repo /home/m1/slimani/Desktop/AEO/TP05/TP05.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/sources_1/new/btnToCode.vhd
  /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/sources_1/new/btn_pulse.vhd
  /home/m1/slimani/Desktop/AEO/TP4.2/TP4.2.srcs/sources_1/new/chenillard.vhd
  /home/m1/slimani/Desktop/AEO/TP4.2/TP4.2.srcs/sources_1/new/clk_div.vhd
  /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/sources_1/new/clkdiv.vhd
  /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/sources_1/new/decode_sequence.vhd
  /home/m1/slimani/Desktop/AEO/TP4.2/TP4.2.srcs/sources_1/new/shift_vector.vhd
  /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/sources_1/new/decoder.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/constrs_1/imports/new/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/m1/slimani/Desktop/AEO/TP05/TP05.srcs/constrs_1/imports/new/Basys3_Master.xdc]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top decoder -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef decoder.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file decoder_utilization_synth.rpt -pb decoder_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
