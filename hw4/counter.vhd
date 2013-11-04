library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity counter is
   port
   ( mult,clock,enable, reset : in std_logic;
	  cnt_eq_18,cnt_eq_16,cnt_eq_1,counting : out std_logic
   );
end entity counter;
 
architecture Behavioral of counter is

begin
   process (clock) is
   variable cnt : integer := -1;
   variable cycle : integer;
   variable reset_set: boolean:= false;
   begin
		if(mult = '1') then
			cycle := 17;
		else
			cycle :=19;
		end if;
		if (rising_edge(clock) and enable='1' and cnt<cycle) then 
			cnt := cnt + 1;
		end if;
		if (enable = '0') then
			cnt := -1;
		end if;
		if (cnt = 16) then
			cnt_eq_16 <='1';
		else
			cnt_eq_16 <='0';
		end if;
		if (cnt = 18) then
			cnt_eq_18 <='1';
		else
			cnt_eq_18 <='0';
		end if;
		if(cnt = 1) then
			cnt_eq_1 <= '1';
		else
			cnt_eq_1 <='0';
		end if;
		if (cnt>0 and cnt <cycle) then
			counting <='1';
		else
			counting <='0';
		end if;
		if(reset='1' and not reset_set) then
			cnt := -1;
			reset_set := true;
		end if;
		if(reset='0') then
			reset_set:= false;
		end if;
   end process;
end architecture Behavioral;