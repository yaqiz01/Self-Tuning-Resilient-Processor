LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ls_2bit IS
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END ls_2bit;

ARCHITECTURE structure OF ls_2bit IS

BEGIN
	G1: for i in 0 to 31 generate
		G2: if (i=0 or i=1) generate
			data_result(i) <= data_operandA(i) when enable = '0' else '0';
		end generate;
		G3: if (i/=0 and i/=1) generate
			data_result(i) <= data_operandA(i) when enable = '0' else data_operandA(i-2);
		end generate;
	end generate;
END structure;