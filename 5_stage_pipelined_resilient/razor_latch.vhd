LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY razor_latch IS
PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
   write_enable :IN STD_LOGIC;
   clock: IN STD_LOGIC;
   reset: IN STD_LOGIC;
   output : OUT STD_LOGIC_VECTOR(31 downto 0);
   shadow_out: OUT STD_LOGIC_VECTOR(31 downto 0);
   error: out std_logic );
END razor_latch;

ARCHITECTURE structure OF razor_latch IS

component reg_32
PORT ( input : IN STD_LOGIC_VECTOR(31 downto 0);
   write_enable :IN STD_LOGIC;
   clock: IN STD_LOGIC;
   reset: IN STD_LOGIC;
   output : OUT STD_LOGIC_VECTOR(31 downto 0)
   );
END component;

component comparator_32
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
	not_equal: out std_logic;
	less_than: out std_logic);
END component;

component razor_dflipflop
   port
   ( clock, reset,enable,data,restore,restore_data : in std_logic;
      output : out std_logic
   );
end component;

signal main_ff_out: STD_LOGIC_VECTOR(31 downto 0);
signal shadow_latch_out: STD_LOGIC_VECTOR(31 downto 0);
signal main_shadow_equal: std_logic;

BEGIN

G1: for i in 31 downto 0 generate
	d: razor_dflipflop port map(clock,reset,write_enable,input(i),'0',shadow_latch_out(i),main_ff_out(i));
end generate;

shadow_latch: reg_32 port map (input, write_enable, not clock, reset, shadow_latch_out);
comparator: comparator_32 port map(main_ff_out,shadow_latch_out,main_shadow_equal,open);
output <= main_ff_out;
shadow_out <= shadow_latch_out;
error <= main_shadow_equal;

END structure;
