LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rs_16bit IS
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END rs_16bit;

ARCHITECTURE structure OF rs_16bit IS

BEGIN
	G1: for i in 0 to 31 generate
		G2: if (i>=16) generate
			data_result(i) <= data_operandA(i) when enable = '0' else data_operandA(31);
		end generate;
		G3: if (i<16) generate
			data_result(i) <= data_operandA(i) when enable = '0' else data_operandA(i+16);
		end generate;
	end generate;
END structure;