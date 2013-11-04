LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY or_16 IS
PORT ( input : IN STD_LOGIC_VECTOR(15 downto 0);
   output :OUT STD_LOGIC);
END or_16;

ARCHITECTURE structure OF or_16 IS

component dflipflop
port
   ( clock, reset,enable,data : in std_logic;
      output : out std_logic);
END component;

signal buff : STD_LOGIC_VECTOR(15 downto 0);

BEGIN
G1: for i in 1 to 15 generate
	G2: if(i=1) generate
		buff(0) <=input(0);
	end generate;
	buff(i) <= input(i) or buff(i-1);
end generate;
output <= buff(15);
END structure;