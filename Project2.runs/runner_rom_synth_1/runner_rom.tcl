# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_param project.vivado.isBlockSynthRun true
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.xpr} [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_ip -quiet {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_ooc.xdc}}]
set_property is_locked true [get_files {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.xci}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

set cached_ip [config_ip_cache -export -no_bom -use_project_ipc -dir {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1} -new_name runner_rom -ip [get_ips runner_rom]]

if { $cached_ip eq {} } {

synth_design -top runner_rom -part xc7a35tcpg236-1 -mode out_of_context

#---------------------------------------------------------
# Generate Checkpoint/Stub/Simulation Files For IP Cache
#---------------------------------------------------------
catch {
 write_checkpoint -force -noxdef -rename_prefix runner_rom_ runner_rom.dcp

 set ipCachedFiles {}
 write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ runner_rom_stub.v
 lappend ipCachedFiles runner_rom_stub.v

 write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ runner_rom_stub.vhdl
 lappend ipCachedFiles runner_rom_stub.vhdl

 write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ runner_rom_sim_netlist.v
 lappend ipCachedFiles runner_rom_sim_netlist.v

 write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ runner_rom_sim_netlist.vhdl
 lappend ipCachedFiles runner_rom_sim_netlist.vhdl

 config_ip_cache -add -dcp runner_rom.dcp -move_files $ipCachedFiles -use_project_ipc -ip [get_ips runner_rom]
}

rename_ref -prefix_all runner_rom_

write_checkpoint -force -noxdef runner_rom.dcp

catch { report_utilization -file runner_rom_utilization_synth.rpt -pb runner_rom_utilization_synth.pb }

if { [catch {
  file copy -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom.dcp} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.dcp}
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_sim_netlist.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_sim_netlist.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}


} else {


if { [catch {
  file copy -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom.dcp} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.dcp}
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  file rename -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom_stub.v} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom_stub.vhdl} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom_sim_netlist.v} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_sim_netlist.v}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  file rename -force {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.runs/runner_rom_synth_1/runner_rom_sim_netlist.vhdl} {c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_sim_netlist.vhdl}
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

}; # end if cached_ip 

if {[file isdir {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.ip_user_files/ip/runner_rom}]} {
  catch { 
    file copy -force {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.v}} {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.ip_user_files/ip/runner_rom}
  }
}

if {[file isdir {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.ip_user_files/ip/runner_rom}]} {
  catch { 
    file copy -force {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_stub.vhdl}} {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.ip_user_files/ip/runner_rom}
  }
}
