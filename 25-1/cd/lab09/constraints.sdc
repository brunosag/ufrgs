# creates a virtual clock (not attached to any real port) with period of 10ns
create_clock -name clk -period 20 [get_ports CLK]

#setting input and output delays to make Quartus calculate timing information
set_input_delay -clock clk -max 0.2 [all_inputs]
set_input_delay -clock clk -min 0.01 [all_inputs]
set_output_delay -clock clk -max 0.2 [all_outputs]
set_output_delay -clock clk -min 0.01 [all_outputs]
