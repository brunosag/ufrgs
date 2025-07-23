create_clock -name "main_clk" -period 20.000 -waveform {0.000 10.000} [get_ports CLK_IN]
derive_clock_uncertainty

set_input_delay -clock "main_clk" -max 5.0 [remove_from_collection [all_inputs] [get_ports CLK_IN]]
set_input_delay -clock "main_clk" -min -1.0 [remove_from_collection [all_inputs] [get_ports CLK_IN]]

set_output_delay -clock "main_clk" -max 5.0 [all_outputs]
set_output_delay -clock "main_clk" -min -1.0 [all_outputs]
