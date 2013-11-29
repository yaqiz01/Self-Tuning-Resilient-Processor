library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity razor_dflipflop is
   port
   ( clock, reset,data,restore_data : in std_logic;
   enable : in  STD_LOGIC_VECTOR(1 downto 0);
      output : out std_logic;
      restore: out std_logic
   );
end entity razor_dflipflop;
 
architecture Behavioral of razor_dflipflop is
begin
   process (clock,reset) is
   begin
      if rising_edge(clock) then  
		 if (enable="11") then 
			output <= restore_data;
			restore <= '1';
         end if;
         if (enable="10") then
			output <= data;
			restore <= '0';
		end if;
      end if;
      if (reset='1') then 
		output <= '0';
		restore <= '0';
      end if;
   end process;
end architecture Behavioral;