library verilog;
use verilog.vl_types.all;
entity mux2_8_vlg_check_tst is
    port(
        Z               : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end mux2_8_vlg_check_tst;
