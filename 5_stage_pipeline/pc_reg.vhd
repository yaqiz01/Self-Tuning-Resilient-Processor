LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY pc_reg IS
PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
   write_enable :IN STD_LOGIC;
   clock: IN STD_LOGIC;
   reset: IN STD_LOGIC;
   output : OUT STD_LOGIC_VECTOR(31 downto 0));
END pc_reg;

ARCHITECTURE structure OF pc_reg IS
component dflipflop
port
   ( clock, reset,enable,data : in std_logic;
      output : out std_logic);
END component;

BEGIN
G1: for i in 31 downto 0 generate
	d: dflipflop port map(clock,reset,write_enable,input(i),output(i));
end generate;
END structure;
