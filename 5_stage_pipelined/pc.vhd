LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY pc IS
    PORT (	clock, reset, enable, sel_set : IN STD_LOGIC;
			set_value : in STD_LOGIC_VECTOR(31 downto 0);
			pc_value	: Out STD_LOGIC_VECTOR(31 downto 0) );
END pc;

ARCHITECTURE structure OF pc IS
component pc_reg is
PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
   write_enable :IN STD_LOGIC;
   clock: IN STD_LOGIC;
   reset: IN STD_LOGIC;
   output : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;
component add_one is
PORT ( input : IN STD_LOGIC_Vector(31 downto 0);
   carryout : out std_logic;
   sum : OuT STD_LOGIC_Vector(31 downto 0));
end component;

signal pc_in	: STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
signal pc_out: STD_LOGIC_VECTOR(31 downto 0);
signal pc_out_buff: STD_LOGIC_VECTOR(31 downto 0);
signal sum : STD_LOGIC_VECTOR(31 downto 0);

begin
	pc_counter: pc_reg port map (pc_in,enable, clock,reset, pc_out_buff);
	adder: add_one port map (pc_out_buff,open, sum);
	pc_value <= pc_out;
	pc_out <= sum when sel_set = '0' else set_value;
	pc_in <= pc_out;
end structure; 
