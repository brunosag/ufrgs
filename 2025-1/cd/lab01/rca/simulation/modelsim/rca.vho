-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "03/16/2025 14:35:05"

-- 
-- Device: Altera EP3C5F256C6 Package FBGA256
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	rca IS
    PORT (
	Cout : OUT std_logic;
	A : IN std_logic_vector(3 DOWNTO 0);
	B : IN std_logic_vector(3 DOWNTO 0);
	S : OUT std_logic_vector(3 DOWNTO 0)
	);
END rca;

-- Design Ports Information
-- Cout	=>  Location: PIN_G1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[3]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[2]	=>  Location: PIN_L6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[1]	=>  Location: PIN_J6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S[0]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[2]	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[2]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[0]	=>  Location: PIN_G2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[0]	=>  Location: PIN_T6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[1]	=>  Location: PIN_L3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[1]	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A[3]	=>  Location: PIN_P2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B[3]	=>  Location: PIN_T4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF rca IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_Cout : std_logic;
SIGNAL ww_A : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_B : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_S : std_logic_vector(3 DOWNTO 0);
SIGNAL \Cout~output_o\ : std_logic;
SIGNAL \S[3]~output_o\ : std_logic;
SIGNAL \S[2]~output_o\ : std_logic;
SIGNAL \S[1]~output_o\ : std_logic;
SIGNAL \S[0]~output_o\ : std_logic;
SIGNAL \B[2]~input_o\ : std_logic;
SIGNAL \A[2]~input_o\ : std_logic;
SIGNAL \B[1]~input_o\ : std_logic;
SIGNAL \B[0]~input_o\ : std_logic;
SIGNAL \A[1]~input_o\ : std_logic;
SIGNAL \A[0]~input_o\ : std_logic;
SIGNAL \inst|inst5~0_combout\ : std_logic;
SIGNAL \inst1|inst5~1_combout\ : std_logic;
SIGNAL \A[3]~input_o\ : std_logic;
SIGNAL \inst1|inst5~0_combout\ : std_logic;
SIGNAL \B[3]~input_o\ : std_logic;
SIGNAL \inst2|inst5~0_combout\ : std_logic;
SIGNAL \inst2|inst2~combout\ : std_logic;
SIGNAL \inst1|inst2~0_combout\ : std_logic;
SIGNAL \inst|inst2~0_combout\ : std_logic;
SIGNAL \inst3|inst2~combout\ : std_logic;

BEGIN

Cout <= ww_Cout;
ww_A <= A;
ww_B <= B;
S <= ww_S;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X0_Y18_N23
\Cout~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|inst5~0_combout\,
	devoe => ww_devoe,
	o => \Cout~output_o\);

-- Location: IOOBUF_X0_Y8_N16
\S[3]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst2|inst2~combout\,
	devoe => ww_devoe,
	o => \S[3]~output_o\);

-- Location: IOOBUF_X0_Y9_N9
\S[2]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst1|inst2~0_combout\,
	devoe => ww_devoe,
	o => \S[2]~output_o\);

-- Location: IOOBUF_X0_Y10_N23
\S[1]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst|inst2~0_combout\,
	devoe => ww_devoe,
	o => \S[1]~output_o\);

-- Location: IOOBUF_X1_Y24_N2
\S[0]~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inst3|inst2~combout\,
	devoe => ww_devoe,
	o => \S[0]~output_o\);

-- Location: IOIBUF_X0_Y6_N22
\B[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(2),
	o => \B[2]~input_o\);

-- Location: IOIBUF_X0_Y8_N22
\A[2]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(2),
	o => \A[2]~input_o\);

-- Location: IOIBUF_X0_Y6_N15
\B[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(1),
	o => \B[1]~input_o\);

-- Location: IOIBUF_X0_Y18_N15
\B[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(0),
	o => \B[0]~input_o\);

-- Location: IOIBUF_X0_Y7_N1
\A[1]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(1),
	o => \A[1]~input_o\);

-- Location: IOIBUF_X11_Y0_N15
\A[0]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(0),
	o => \A[0]~input_o\);

-- Location: LCCOMB_X1_Y7_N10
\inst|inst5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|inst5~0_combout\ = (\B[1]~input_o\ & ((\A[1]~input_o\) # ((\B[0]~input_o\ & \A[0]~input_o\)))) # (!\B[1]~input_o\ & (\B[0]~input_o\ & (\A[1]~input_o\ & \A[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[1]~input_o\,
	datad => \A[0]~input_o\,
	combout => \inst|inst5~0_combout\);

-- Location: LCCOMB_X1_Y7_N12
\inst1|inst5~1\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst1|inst5~1_combout\ = (\inst|inst5~0_combout\ & ((\B[2]~input_o\) # (\A[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \A[2]~input_o\,
	datad => \inst|inst5~0_combout\,
	combout => \inst1|inst5~1_combout\);

-- Location: IOIBUF_X0_Y4_N15
\A[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A(3),
	o => \A[3]~input_o\);

-- Location: LCCOMB_X1_Y7_N8
\inst1|inst5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst1|inst5~0_combout\ = (\A[2]~input_o\ & \B[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \A[2]~input_o\,
	datad => \B[2]~input_o\,
	combout => \inst1|inst5~0_combout\);

-- Location: IOIBUF_X5_Y0_N15
\B[3]~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B(3),
	o => \B[3]~input_o\);

-- Location: LCCOMB_X1_Y7_N22
\inst2|inst5~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|inst5~0_combout\ = (\A[3]~input_o\ & ((\inst1|inst5~1_combout\) # ((\inst1|inst5~0_combout\) # (\B[3]~input_o\)))) # (!\A[3]~input_o\ & (\B[3]~input_o\ & ((\inst1|inst5~1_combout\) # (\inst1|inst5~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|inst5~1_combout\,
	datab => \A[3]~input_o\,
	datac => \inst1|inst5~0_combout\,
	datad => \B[3]~input_o\,
	combout => \inst2|inst5~0_combout\);

-- Location: LCCOMB_X1_Y7_N0
\inst2|inst2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst2|inst2~combout\ = \A[3]~input_o\ $ (\B[3]~input_o\ $ (((\inst1|inst5~1_combout\) # (\inst1|inst5~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100100110110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \inst1|inst5~1_combout\,
	datab => \A[3]~input_o\,
	datac => \inst1|inst5~0_combout\,
	datad => \B[3]~input_o\,
	combout => \inst2|inst2~combout\);

-- Location: LCCOMB_X1_Y7_N26
\inst1|inst2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst1|inst2~0_combout\ = \B[2]~input_o\ $ (\A[2]~input_o\ $ (\inst|inst5~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[2]~input_o\,
	datac => \A[2]~input_o\,
	datad => \inst|inst5~0_combout\,
	combout => \inst1|inst2~0_combout\);

-- Location: LCCOMB_X1_Y7_N4
\inst|inst2~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst|inst2~0_combout\ = \B[1]~input_o\ $ (\A[1]~input_o\ $ (((\B[0]~input_o\ & \A[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \B[1]~input_o\,
	datab => \B[0]~input_o\,
	datac => \A[1]~input_o\,
	datad => \A[0]~input_o\,
	combout => \inst|inst2~0_combout\);

-- Location: LCCOMB_X1_Y7_N14
\inst3|inst2\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst3|inst2~combout\ = \B[0]~input_o\ $ (\A[0]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \B[0]~input_o\,
	datad => \A[0]~input_o\,
	combout => \inst3|inst2~combout\);

ww_Cout <= \Cout~output_o\;

ww_S(3) <= \S[3]~output_o\;

ww_S(2) <= \S[2]~output_o\;

ww_S(1) <= \S[1]~output_o\;

ww_S(0) <= \S[0]~output_o\;
END structure;


