# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.17-s066_1 on Thu Apr 10 21:35:42 EDT 2025

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1fF
set_units -time 1000ps

# Set the current design
current_design topSystolicArray

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports i_clk]
set_clock_transition 0.1 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.01 [get_ports i_clk]
set_clock_uncertainty -hold 0.01 [get_ports i_clk]
