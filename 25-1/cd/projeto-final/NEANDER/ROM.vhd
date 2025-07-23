LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ROM IS
	PORT(
		entrada : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
		saida	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END ROM;

ARCHITECTURE arch OF ROM IS
BEGIN

	WITH entrada SELECT
	--  saida <=    "DADO_MEM" WHEN "ADDR_MEM",
		saida <= 	
					-- PROGRAMA: compara posições 0x80 e 0x82. Carrega 1 no AC se são iguais e 0 c.c.
					x"20" when x"00",     -- LDA
					x"80" when x"01",     -- 0x80
					x"60" when x"02",     -- NOT
					x"30" when x"03",     -- ADD
					x"81" when x"04",     -- 0x81
					x"30" when x"05",     -- ADD
					x"82" when x"06",     -- 0x82
					x"A0" when x"07",     -- JZ
					x"0D" when x"08",     -- 0x0D
					x"20" when x"09",     -- LDA
					x"83" when x"0A",     -- 0x83
					x"80" when x"0B",     -- JMP
					x"0F" when x"0C",     -- 0x0F
					x"20" when x"0D",     -- LDA
					x"84" when x"0E",     -- 0x84
					x"F0" when x"0F",     -- HLT
					-- DADOS  --------------
					x"0A" when x"80",	   -- 0x0A = 10
					x"01" when x"81",	   -- 0x01 = 1
					x"0B" when x"82",	   -- 0x0A = 10
					x"00" when x"83",	   -- 0x00 = 0 (not equal)
					x"01" when x"84",	   -- 0x01 = 1 (equal)

					"00000000" WHEN OTHERS;
END arch;