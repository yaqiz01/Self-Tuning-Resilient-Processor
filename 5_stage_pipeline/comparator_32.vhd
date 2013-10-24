LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator_32 IS
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
	not_equal: out std_logic;
	less_than: out std_logic);
END comparator_32;

ARCHITECTURE structure OF comparator_32 IS
component carrysaveadder is
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   carryin : IN STD_LOGIC;
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
   carryout: OUT STD_LOGIC;
   subtract : IN STD_LOGIC);
end component;
signal result: std_logic_vector(31 downto 0);
signal buff: std_logic_vector(31 downto 0);

begin
	subtraction: carrysaveadder port map(data_operandA, data_operandB, '0', result, open, '1');
	less_than <= result(31);
	buff(0) <= result(0);
	G1: for i in 1 to 31 generate
		buff(i) <= buff(i-1) or result(i-1);
	end generate;
	not_equal <= buff(31);
end;