LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY negate_16 IS
PORT ( data   : IN STD_LOGIC_VECTOR(15 downto 0);
   enable : IN STD_LOGIC;
   result    : OUT STD_LOGIC_VECTOR(15 downto 0));
END negate_16;

ARCHITECTURE structure OF negate_16 IS

component add_sub_16
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(15 downto 0);
   carryin : IN STD_LOGIC;
   data_result    : OUT STD_LOGIC_VECTOR(15 downto 0);
   carryout: OUT STD_LOGIC;
   subtract : IN STD_LOGIC);
end component;

SIGNAL flipbits : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL buff:  STD_LOGIC_VECTOR(15 downto 0);

BEGIN
G1:for i in 0 to 15 generate
	flipbits(i) <= not data(i);
end generate;
addone: add_sub_16 port map(flipbits,"0000000000000001",'0',buff,open,'0');
result <= buff when enable = '1' else data;
END structure;