LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY led_ctrl IS
    PORT (	clock: in std_logic;
			led_id: in std_logic_vector(40 downto 1);
			enable: in std_logic;
			ctrl_on: in std_logic;
			reset: in std_logic;
			pin: out std_logic_vector(14 downto 1)
			);
END led_ctrl;

ARCHITECTURE Structure OF led_ctrl IS

component assert_signal is
    PORT (	clock: in std_logic;
			preset_val: in std_logic;
			enable: in std_logic;
			assert_on: in std_logic;
			reset: in std_logic;
			output: out std_logic
			);
end component;

component preset is
   port
   ( enable : in std_logic;
      output : out std_logic
   );
end component;

signal led_r1: std_logic;
signal led_r2: std_logic;
signal led_r3: std_logic;
signal led_r4: std_logic;
signal led_r5: std_logic;
signal led_r6: std_logic;
signal led_r7: std_logic;
signal led_r8: std_logic;
signal led_c1: std_logic;
signal led_c2: std_logic;
signal led_c3: std_logic;
signal led_c4: std_logic;
signal led_c5: std_logic;
signal pin_out: std_logic_vector(14 downto 1);

begin
	pin <= pin_out;
	-- row --
	assert9 : assert_signal port map (clock, '0', enable and led_r1, ctrl_on, reset, pin_out(9));
	assert14 : assert_signal port map (clock, '0', enable and led_r2, ctrl_on, reset, pin_out(14));
	assert8 : assert_signal port map (clock, '0', enable and led_r3, ctrl_on, reset, pin_out(8));
	assert12 : assert_signal port map (clock, '0', enable and led_r4, ctrl_on, reset, pin_out(12));
	assert5 : assert_signal port map (clock, '0', enable and led_r5, ctrl_on, reset, pin_out(5));
	assert1 : assert_signal port map (clock, '0', enable and led_r6, ctrl_on, reset, pin_out(1));
	assert7 : assert_signal port map (clock, '0', enable and led_r7, ctrl_on, reset, pin_out(7));
	assert2 : assert_signal port map (clock, '0', enable and led_r8, ctrl_on, reset, pin_out(2));

	assert13 : assert_signal port map (clock, '1', enable and led_c1, not ctrl_on, reset, pin_out(13));
	assert3 : assert_signal port map (clock, '1', enable and led_c2, not ctrl_on, reset, pin_out(3));
	assert4 : assert_signal port map (clock, '1', enable and led_c3, not ctrl_on, reset, pin_out(4));
	assert11 : assert_signal port map (clock, '1', enable and led_c3, not ctrl_on, reset, pin_out(11));
	assert10 : assert_signal port map (clock, '1', enable and led_c4, not ctrl_on, reset, pin_out(10));
	assert6 : assert_signal port map (clock, '1', enable and led_c5, not ctrl_on, reset, pin_out(6));

	led_r1 <= led_id(1) or led_id(2) or led_id(3) or led_id(4) or led_id(5);
	led_r2 <= led_id(6) or led_id(7) or led_id(8) or led_id(9) or led_id(10);
	led_r3 <= led_id(11) or led_id(12) or led_id(13) or led_id(14) or led_id(15);
	led_r4 <= led_id(16) or led_id(17) or led_id(18) or led_id(19) or led_id(20);
	led_r5 <= led_id(21) or led_id(22) or led_id(23) or led_id(24) or led_id(25);
	led_r6 <= led_id(26) or led_id(27) or led_id(28) or led_id(29) or led_id(30);
	led_r7 <= led_id(31) or led_id(32) or led_id(33) or led_id(34) or led_id(35);
	led_r8 <= led_id(36) or led_id(37) or led_id(38) or led_id(39) or led_id(40);
	
	led_c1 <= led_id(1) or led_id(6) or led_id(11) or led_id(16) or led_id(21) or led_id(26) or led_id(31) or led_id(36);
	led_c2 <= led_id(2) or led_id(7) or led_id(12) or led_id(17) or led_id(22) or led_id(27) or led_id(32) or led_id(37);
	led_c3 <= led_id(3) or led_id(8) or led_id(13) or led_id(18) or led_id(23) or led_id(28) or led_id(33) or led_id(38);
	led_c4 <= led_id(4) or led_id(9) or led_id(14) or led_id(19) or led_id(24) or led_id(29) or led_id(34) or led_id(39);
	led_c5 <= led_id(5) or led_id(10) or led_id(15) or led_id(20) or led_id(25) or led_id(30) or led_id(35) or led_id(40);
	
end;
