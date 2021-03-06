Library ieee;
Use ieee.std_logic_1164.all;

Entity led_test is
    port(
         output:   out std_logic_vector(14 downto 1)
        );
End led_test;

Architecture Structure of led_test is

component led_ctrl is
    PORT (	led_id: in std_logic_vector(40 downto 1);
			enable: in std_logic;
			ctrl_on: in std_logic;
			pin: out std_logic_vector(14 downto 1)
			);
end component;

signal led_id: std_logic_vector(40 downto 1) := "0000000000000000000000000000000000000000";

begin
led_control: led_ctrl port map (led_id, '1', '1', output);

led_id(3) <= '1';

end;