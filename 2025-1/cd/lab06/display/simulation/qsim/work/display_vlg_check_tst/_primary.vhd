library verilog;
use verilog.vl_types.all;
entity display_vlg_check_tst is
    port(
        flag_N          : in     vl_logic;
        flag_Z          : in     vl_logic;
        S_A             : in     vl_logic;
        S_B             : in     vl_logic;
        S_C             : in     vl_logic;
        S_D             : in     vl_logic;
        S_E             : in     vl_logic;
        S_F             : in     vl_logic;
        S_G             : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end display_vlg_check_tst;
