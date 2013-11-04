LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY regfile IS
PORT ( clock, ctrl_writeEnable, ctrl_reset : IN STD_LOGIC;
   ctrl_writeReg, ctrl_readRegA, ctrl_readRegB : IN STD_LOGIC_VECTOR(4 downto 0);
   data_writeReg    : IN STD_LOGIC_VECTOR(31 downto 0);
   data_readRegA, data_readRegB    : OUT STD_LOGIC_VECTOR(31 downto 0));
END regfile;

ARCHITECTURE structure OF regfile IS
component reg
PORT ( clock, ctrl_writeEnable, ctrl_reset : IN STD_LOGIC;
   data_writeReg    : IN STD_LOGIC_VECTOR(31 downto 0);
   data_readReg    : OUT STD_LOGIC_VECTOR(31 downto 0));
end component;

component tristate
PORT ( input :IN STD_LOGIC_VECTOR(0 TO 31);
ctrl : IN STD_LOGIC;
output: OUT STD_LOGIC_VECTOR(0 TO 31));
end component;

component decoder5to32
PORT (w : IN  STD_LOGIC_VECTOR(0 TO 4) ;
En  : IN  STD_LOGIC ;
y : OUT  STD_LOGIC_VECTOR(0 TO 31) ) ;
end component;

SIGNAL ctrl_write : STD_LOGIC_VECTOR(0 TO 31) ;
SIGNAL ctrl_readA: STD_LOGIC_VECTOR(0 TO 31) ;
SIGNAL ctrl_readB: STD_LOGIC_VECTOR(0 TO 31) ;
SIGNAL reg_out: STD_LOGIC_VECTOR(0 TO 32*32-1) ;


BEGIN
write_decoder: decoder5to32 port map (ctrl_writeReg,ctrl_writeEnable,ctrl_write);
readA_decoder: decoder5to32 port map (ctrl_readRegA, '1',ctrl_readA);
readB_decoder: decoder5to32 port map (ctrl_readRegB, '1',ctrl_readB);

IFF : for i in 0 to 31 generate
	G1: if i=0 generate
		reg_out(32*i to 32*i+31) <= "00000000000000000000000000000000";
	end generate;
	G2: if i/=0 generate
		regcomp: reg port map (clock, (ctrl_writeEnable and ctrl_write(i)),ctrl_reset,data_writeReg,reg_out(32*i to 32*i+31));
	end generate;
	dataReadA: tristate port map (reg_out(32*i to 32*i+31), ctrl_readA(i),data_readRegA);
	dataReadB: tristate port map (reg_out(32*i to 32*i+31), ctrl_readB(i),data_readRegB);
end generate IFF;

END structure;
