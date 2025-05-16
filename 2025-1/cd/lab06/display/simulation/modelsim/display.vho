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

-- DATE "04/26/2025 10:49:54"

-- 
-- Device: Altera EP3C16F484C6 Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIII;
LIBRARY IEEE;
USE CYCLONEIII.CYCLONEIII_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	display IS
    PORT (
	S_A : OUT std_logic;
	A : IN std_logic;
	D : IN std_logic;
	B : IN std_logic;
	C : IN std_logic;
	S_B : OUT std_logic;
	S_C : OUT std_logic;
	S_D : OUT std_logic;
	S_E : OUT std_logic;
	S_F : OUT std_logic;
	S_G : OUT std_logic
	);
END display;

-- Design Ports Information
-- S_A	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_B	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_C	=>  Location: PIN_U8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_D	=>  Location: PIN_F8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_E	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_F	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- S_G	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- C	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- B	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- A	=>  Location: PIN_H1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- D	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF display IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_S_A : std_logic;
SIGNAL ww_A : std_logic;
SIGNAL ww_D : std_logic;
SIGNAL ww_B : std_logic;
SIGNAL ww_C : std_logic;
SIGNAL ww_S_B : std_logic;
SIGNAL ww_S_C : std_logic;
SIGNAL ww_S_D : std_logic;
SIGNAL ww_S_E : std_logic;
SIGNAL ww_S_F : std_logic;
SIGNAL ww_S_G : std_logic;
SIGNAL \S_A~output_o\ : std_logic;
SIGNAL \S_B~output_o\ : std_logic;
SIGNAL \S_C~output_o\ : std_logic;
SIGNAL \S_D~output_o\ : std_logic;
SIGNAL \S_E~output_o\ : std_logic;
SIGNAL \S_F~output_o\ : std_logic;
SIGNAL \S_G~output_o\ : std_logic;
SIGNAL \C~input_o\ : std_logic;
SIGNAL \B~input_o\ : std_logic;
SIGNAL \D~input_o\ : std_logic;
SIGNAL \A~input_o\ : std_logic;
SIGNAL \inst4~0_combout\ : std_logic;
SIGNAL \ALT_INV_inst4~0_combout\ : std_logic;

BEGIN

S_A <= ww_S_A;
ww_A <= A;
ww_D <= D;
ww_B <= B;
ww_C <= C;
S_B <= ww_S_B;
S_C <= ww_S_C;
S_D <= ww_S_D;
S_E <= ww_S_E;
S_F <= ww_S_F;
S_G <= ww_S_G;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_inst4~0_combout\ <= NOT \inst4~0_combout\;

-- Location: IOOBUF_X3_Y29_N9
\S_A~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_inst4~0_combout\,
	devoe => ww_devoe,
	o => \S_A~output_o\);

-- Location: IOOBUF_X7_Y29_N9
\S_B~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_B~output_o\);

-- Location: IOOBUF_X3_Y0_N16
\S_C~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_C~output_o\);

-- Location: IOOBUF_X5_Y29_N23
\S_D~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_D~output_o\);

-- Location: IOOBUF_X3_Y29_N30
\S_E~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_E~output_o\);

-- Location: IOOBUF_X0_Y12_N23
\S_F~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_F~output_o\);

-- Location: IOOBUF_X0_Y6_N9
\S_G~output\ : cycloneiii_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => GND,
	devoe => ww_devoe,
	o => \S_G~output_o\);

-- Location: IOIBUF_X0_Y12_N15
\C~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_C,
	o => \C~input_o\);

-- Location: IOIBUF_X0_Y12_N1
\B~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_B,
	o => \B~input_o\);

-- Location: IOIBUF_X0_Y26_N22
\D~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_D,
	o => \D~input_o\);

-- Location: IOIBUF_X0_Y21_N15
\A~input\ : cycloneiii_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_A,
	o => \A~input_o\);

-- Location: LCCOMB_X1_Y11_N24
\inst4~0\ : cycloneiii_lcell_comb
-- Equation(s):
-- \inst4~0_combout\ = (\B~input_o\ & ((\C~input_o\) # (\D~input_o\ $ (\A~input_o\)))) # (!\B~input_o\ & ((\C~input_o\ $ (\A~input_o\)) # (!\D~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001111111101011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \C~input_o\,
	datab => \B~input_o\,
	datac => \D~input_o\,
	datad => \A~input_o\,
	combout => \inst4~0_combout\);

ww_S_A <= \S_A~output_o\;

ww_S_B <= \S_B~output_o\;

ww_S_C <= \S_C~output_o\;

ww_S_D <= \S_D~output_o\;

ww_S_E <= \S_E~output_o\;

ww_S_F <= \S_F~output_o\;

ww_S_G <= \S_G~output_o\;
END structure;


