
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name serial_port -dir "D:/VHDL/Computer Arti/serial_port/planAhead_run_1" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/VHDL/Computer Arti/serial_port/serial_port.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/VHDL/Computer Arti/serial_port} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "serial_port.ucf" [current_fileset -constrset]
add_files [list {serial_port.ucf}] -fileset [get_property constrset [current_run]]
link_design
