LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator_32_fast IS
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
	not_equal: out std_logic
);
END comparator_32_fast;

ARCHITECTURE structure OF comparator_32_fast IS

signal result: std_logic_vector(31 downto 0);
signal buff: std_logic_vector(31 downto 0);

begin
	buff(0) <= result(0);
	G1: for i in 1 to 31 generate
	-- compare each bit
	end generate;
	not_equal <= buff(31);
end;