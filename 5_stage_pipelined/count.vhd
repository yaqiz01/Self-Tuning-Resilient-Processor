library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity count is
   port
   ( clock,reset,enable : IN STD_LOGIC;     
	  cnt_eq_5,cnt_eq_17,cnt_eq_19 : out std_logic
   );
end entity count;
 
architecture Behavioral of count is

signal data_inputRDYb: STD_LOGIC;

begin
	process (clock,reset,enable) is
	variable cnt : integer := 0;
		begin
		if (rising_edge(clock)) then 
			if(reset='0' and enable = '1') then
				cnt := cnt+1;
			end if;
			if(cnt = 5) then
				cnt_eq_5 <= '1';
			end if;
			if(cnt = 17) then
				cnt_eq_17 <= '1';
			end if;
			if(cnt = 19) then
				cnt_eq_19 <= '1';
			end if;
			if(reset = '1') then
				cnt := 0;
				cnt_eq_5 <= '0';
				cnt_eq_17 <= '0';
				cnt_eq_19 <= '0';
			end if;
		end if; 
   end process;
end architecture Behavioral;