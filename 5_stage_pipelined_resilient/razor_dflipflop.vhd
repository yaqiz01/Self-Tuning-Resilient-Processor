library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity razor_dflipflop is
   port
   ( clock, reset,enable,data,restore,restore_data : in std_logic;
      output : out std_logic
   );
end entity razor_dflipflop;
 
architecture Behavioral of razor_dflipflop is
begin
   process (clock,reset) is
   begin
      if rising_edge(clock) then  
		 if (enable='1' and restore = '1') then 
			output <= data;
         end if;
         if (enable = '1' and restore = '0') then  
			output <= restore_data;
		end if;
		--if (enable='1') then 
			--output <= data;
         --end if;
      end if;
      if (reset='1') then output <= '0';
      end if;
   end process;
end architecture Behavioral;