LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ls_8bit IS
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END ls_8bit;

ARCHITECTURE structure OF ls_8bit IS

BEGIN
	G1: for i in 0 to 31 generate
		G2: if (i<=7) generate
			data_result(i) <= data_operandA(i) when enable = '0' else '0';
		end generate;
		G3: if (i>7) generate
			data_result(i) <= data_operandA(i) when enable = '0' else data_operandA(i-8);
		end generate;
	end generate;
END structure;