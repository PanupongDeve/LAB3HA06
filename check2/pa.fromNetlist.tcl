
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name check2 -dir "D:/lab6/check2/planAhead_run_1" -part xc3s200tq144-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "D:/lab6/check2/buzzer.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {D:/lab6/check2} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "buzzer.ucf" [current_fileset -constrset]
add_files [list {buzzer.ucf}] -fileset [get_property constrset [current_run]]
open_netlist_design
