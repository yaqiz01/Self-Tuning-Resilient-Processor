LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sx_17to32 IS
    PORT (	input	: IN STD_LOGIC_VECTOR(16 downto 0);
			output	: OUT STD_LOGIC_VECTOR(31 downto 0));
END sx_17to32;

ARCHITECTURE Structure OF sx_17to32 IS
begin
G1: for i in 31 downto 17 generate
	output(i) <= input(16);
end generate;
output(16 downto 0) <= input;
end structure;