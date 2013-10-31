
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ram1 -dir "D:/VHDL/ram1/planAhead_run_2" -part xc3s1200efg320-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/VHDL/ram1/ram.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/VHDL/ram1} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "ram.ucf" [current_fileset -constrset]
add_files [list {ram.ucf}] -fileset [get_property constrset [current_run]]
link_design
