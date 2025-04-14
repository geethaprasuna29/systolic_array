# Genus TCL script for synthesis
#set design(TOPLEVEL) "sa"
# Set up technology libraries
set_db init_lib_search_path {/package/eda/cells/NanGate_45nm_OCL_v2010_12/pdk_v1.3_v2010_12/NangateOpenCellLibrary_PDKv1_3_v2010_12/Front_End/Liberty/NLDM}
read_libs NangateOpenCellLibrary_typical.lib


# Read design files
read_hdl -sv { \
    /home/min/a/hjaigane/ece69500_project/systolic_array/rtl/pe.sv \
    /home/min/a/hjaigane/ece69500_project/systolic_array/rtl/systolicArray.sv \
    /home/min/a/hjaigane/ece69500_project/systolic_array/rtl/topSystolicArray.sv \
}

# Elaborate the design
elaborate topSystolicArray

read_sdc {/home/min/a/hjaigane/ece69500_project/scripts/constraints_top.sdc}

# Set synthesis constraints

set_db syn_generic_effort medium
set_db syn_map_effort medium
set_db syn_opt_effort medium

syn_generic
syn_map
syn_opt


# Run synthesis
#synthesize -to_mapped

# Generate reports
report_timing > ./reports/timing_report.txt
report_area > ./reports/area_report.txt
report_power > ./reports/power_report.txt

# Save synthesized netlist and constraints
write_hdl > ./reports/synth_netlist.v
write_sdc > ./reports/constraints_new.sdc

# Exit Genus
exit

