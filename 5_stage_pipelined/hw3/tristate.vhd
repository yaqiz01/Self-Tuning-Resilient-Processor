LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tristate IS
PORT ( input :IN STD_LOGIC_VECTOR(0 TO 31);
ctrl : IN STD_LOGIC;
output: OUT STD_LOGIC_VECTOR(0 TO 31));
END tristate;

ARCHITECTURE behavioral OF tristate IS
begin
process (ctrl,input) is
begin
	if (ctrl = '1') then
		output <= input;
	else
		iff: for i in 0 to 31 loop
			output(i) <= 'Z';
		end loop iff;
	end if;
end process;
end behavioral;
