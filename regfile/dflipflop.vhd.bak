library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity dflipflop is
   port
   ( clock, reset,enable,data : in std_logic;
      output : out std_logic
   );
end entity dflipflop;
 
architecture Behavioral of dflipflop is
begin
   process (clock) is
   begin
      if rising_edge(clock) then  
		 if (enable='1') then output <= data;
         end if;
      end if;
      if (reset='1') then output <= '0';
      end if;
   end process;
end architecture Behavioral;