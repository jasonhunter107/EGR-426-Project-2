# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
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
add_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/runnerBlue.coe}}
add_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/typeface.coe}}
read_vhdl -library xil_defaultlib {
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/Char_Gen.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/Collision_Detection.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/Speed_Controller.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/char_driver.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/colorPlexer.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/hurdles.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/runner.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/staticBackground.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/vga_controller_640_60.vhd}
  {C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/new/Game_Top.vhd}
}
read_ip -quiet {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc}}]
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc}}]
set_property is_locked true [get_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci}}]

read_ip -quiet {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom_ooc.xdc}}]
set_property is_locked true [get_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/runner_rom_1/runner_rom.xci}}]

read_ip -quiet {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/rom1kx8/rom1kx8.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/rom1kx8/rom1kx8_ooc.xdc}}]
set_property is_locked true [get_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/sources_1/ip/rom1kx8/rom1kx8.xci}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/constrs_1/new/vgatop_pins.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Jason/Desktop/EGR 426/Project2/EGR-426-Project-2/Project2.srcs/constrs_1/new/vgatop_pins.xdc}}]


synth_design -top Game_Top -part xc7a35tcpg236-1


write_checkpoint -force -noxdef Game_Top.dcp

catch { report_utilization -file Game_Top_utilization_synth.rpt -pb Game_Top_utilization_synth.pb }
