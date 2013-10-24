library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity unset_rising_clock is
   port
   ( clock, set_val : in std_logic;
      output : out std_logic
   );
end entity unset_rising_clock;
 
architecture Behavioral of unset_rising_clock is
signal set: std_logic;
signal unset: std_logic;
begin
   process (clock,set_val) is
   begin
	--if rising_clock
   end process;
end architecture Behavioral;