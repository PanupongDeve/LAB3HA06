
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name check44 -dir "D:/lab6/check44/planAhead_run_1" -part xc3s200tq144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/lab6/check44/alarm_twodigit.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/lab6/check44} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "alarm_twodigit.ucf" [current_fileset -constrset]
add_files [list {alarm_twodigit.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
