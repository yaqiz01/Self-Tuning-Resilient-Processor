LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg_11 IS
PORT ( clock, ctrl_writeEnable, ctrl_reset : IN STD_LOGIC;
   data_writeReg    : IN STD_LOGIC_VECTOR(11 downto 0);
   data_readReg    : OUT STD_LOGIC_VECTOR(11 downto 0));
END reg_11;

ARCHITECTURE structure OF reg_11 IS
component dflipflop
   port( clock, reset,enable,data : in std_logic;
      output : out std_logic
   );
end component;
BEGIN
IFF : for i in 0 to 11 generate
	dffcomp: dflipflop port map (clock,ctrl_reset,ctrl_writeEnable,data_writeReg(i),data_readReg(i));
end generate IFF;
END structure;
