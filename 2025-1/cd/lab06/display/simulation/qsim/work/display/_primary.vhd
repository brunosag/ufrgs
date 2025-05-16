library verilog;
use verilog.vl_types.all;
entity display is
    port(
        S_A             : out    vl_logic;
        S_B             : out    vl_logic;
        S_C             : out    vl_logic;
        S_D             : out    vl_logic;
        S_E             : out    vl_logic;
        S_F             : out    vl_logic;
        S_G             : out    vl_logic;
        flag_Z          : out    vl_logic;
        flag_N          : out    vl_logic;
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        op_sel          : in     vl_logic_vector(1 downto 0)
    );
end display;
