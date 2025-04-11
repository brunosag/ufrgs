library verilog;
use verilog.vl_types.all;
entity mux2_8_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        S0              : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end mux2_8_vlg_sample_tst;
