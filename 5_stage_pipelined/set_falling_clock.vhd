library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity set_falling_clock is
   port
   ( clock, set_val : in std_logic;
      output : out std_logic
   );
end entity set_falling_clock;
 
architecture Behavioral of set_falling_clock is
begin
   process (clock, set_val) is
   begin
	  if falling_edge(clock) then  
		 output <= set_val;
  	  end if;
   end process;
end architecture Behavioral;