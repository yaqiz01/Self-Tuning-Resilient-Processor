LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY add_one IS
PORT ( input : IN STD_LOGIC_Vector(31 downto 0);
   carryout : out std_logic;
   sum : OuT STD_LOGIC_Vector(31 downto 0));
END add_one;

ARCHITECTURE structure OF add_one IS

component onebitfulladder is
PORT ( input1, input2 , carryin: IN STD_LOGIC;
   carryout, sum : OuT STD_LOGIC);
ENd component;

signal buff: std_logic_vector(31 downto 0);
BEGIN

buff(0) <= '1';
G1: for i in 0 to 30 generate
	adder2: onebitfulladder port map (input(i), '0', buff(i), buff(i+1), sum(i));
end generate;
adder3: onebitfulladder port map (input(30), '0', buff(30), carryout, sum(31));
END structure;
