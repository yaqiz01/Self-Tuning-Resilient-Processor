LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rs_32bit IS
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    ctrl_shiftamt : IN STD_LOGIC_VECTOR(4 downto 0);
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END rs_32bit;

ARCHITECTURE structure OF rs_32bit IS
component rs_1bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;
component rs_2bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;
component rs_4bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;
component rs_8bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;
component rs_16bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    enable : IN STD_LOGIC;
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;

signal buff1: STD_LOGIC_VECTOR(31 downto 0);
signal buff2: STD_LOGIC_VECTOR(31 downto 0);
signal buff3: STD_LOGIC_VECTOR(31 downto 0);
signal buff4: STD_LOGIC_VECTOR(31 downto 0);

BEGIN
rs16: rs_16bit port map (data_operandA, ctrl_shiftamt(4),buff1);
rs8: rs_8bit port map (buff1, ctrl_shiftamt(3),buff2);
rs4: rs_4bit port map (buff2, ctrl_shiftamt(2),buff3);
rs2: rs_2bit port map (buff3, ctrl_shiftamt(1),buff4);
rs1: rs_1bit port map (buff4, ctrl_shiftamt(0),data_result);

END structure;