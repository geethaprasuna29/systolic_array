create_library_set -name MAX_timing -timing {/package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM/NangateOpenCellLibrary_slow.lib}
create_library_set -name MIN_timing -timing {/package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM/NangateOpenCellLibrary_fast.lib}
create_constraint_mode -name Constraints -sdc_files {/home/min/a/hjaigane/ece69500_project/scripts/reports/constraints_new.sdc}
create_delay_corner -name MAX_delay -library_set {MAX_timing}
create_delay_corner -name MIN_delay -library_set {MIN_timing}
create_analysis_view -name Worst -constraint_mode {Constraints} -delay_corner {MAX_delay}
create_analysis_view -name Best -constraint_mode {Constraints} -delay_corner {MIN_delay}
set_analysis_view -setup {Worst} -hold {Best}
