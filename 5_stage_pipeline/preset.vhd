library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity preset is
   port
   ( enable : in std_logic;
      output : out std_logic
   );
end entity preset;
 
architecture Behavioral of preset is
begin
   process (enable) is
   variable count: integer := 0;
   begin
      if rising_edge(enable) then  
		 count := 1;
      end if;
     if (count = 0) then
		output <= '0';
	end if;
	if(count = 1) then
		output <= '1';
	end if;
   end process;
end architecture Behavioral;