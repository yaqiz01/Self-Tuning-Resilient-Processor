LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY alu IS
PORT ( data_operandA, data_operandB   : IN STD_LOGIC_VECTOR(31 downto 0);
       ctrl_ALUopcode : IN STD_LOGIC_VECTOR(4 downto 0); 
       ctrl_shiftamt : IN STD_LOGIC_VECTOR(4 downto 0);
       data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
       isNotEqual, isLessThan  : OUT STD_LOGIC);
END alu;

ARCHITECTURE structure OF alu IS
component carrysaveadder
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   carryin : IN STD_LOGIC;
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0);
   carryout: OUT STD_LOGIC;
   subtract : IN STD_LOGIC);
END component;

component rs_32bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    ctrl_shiftamt : IN STD_LOGIC_VECTOR(4 downto 0);
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;

component ls_32bit
PORT ( data_operandA  : IN STD_LOGIC_VECTOR(31 downto 0);
    ctrl_shiftamt : IN STD_LOGIC_VECTOR(4 downto 0);
    data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END component;

component bitwiseor
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
end component;

component bitwiseand
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
end component;

component tristate
PORT ( input :IN STD_LOGIC_VECTOR(0 TO 31);
ctrl : IN STD_LOGIC;
output: OUT STD_LOGIC_VECTOR(0 TO 31));
end component;

signal rs_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal ls_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal adder_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal and_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal or_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal cp_buffer: STD_LOGIC_VECTOR(31 downto 0);
signal neq_buffer: STD_LOGIC_VECTOR(31 downto 0);

BEGIN

addsub: carrysaveadder port map (data_operandA, data_operandB,'0',adder_buffer,open,ctrl_ALUopcode(0));
rightshift: rs_32bit port map (data_operandA,ctrl_shiftamt,rs_buffer);
leftshift: ls_32bit port map (data_operandA,ctrl_shiftamt,ls_buffer);
op_or: bitwiseor port map (data_operandA,data_operandB,or_buffer);
op_and: bitwiseand port map (data_operandA,data_operandB,and_buffer);

control1: tristate port map (adder_buffer, (not ctrl_ALUopcode(4))and(not ctrl_ALUopcode(3))and(not ctrl_ALUopcode(2))and(not ctrl_ALUopcode(1)),data_result);
control2: tristate port map (and_buffer, (not ctrl_ALUopcode(4))and(not ctrl_ALUopcode(3))and(not ctrl_ALUopcode(2))and(ctrl_ALUopcode(1))and(not ctrl_ALUopcode(0)),data_result);
control3: tristate port map (or_buffer, (not ctrl_ALUopcode(4))and(not ctrl_ALUopcode(3))and(not ctrl_ALUopcode(2))and(ctrl_ALUopcode(1))and(ctrl_ALUopcode(0)),data_result);
control4: tristate port map (ls_buffer, (not ctrl_ALUopcode(4))and(not ctrl_ALUopcode(3))and(ctrl_ALUopcode(2))and(not ctrl_ALUopcode(1))and(not ctrl_ALUopcode(0)),data_result);
control5: tristate port map (rs_buffer, (not ctrl_ALUopcode(4))and(not ctrl_ALUopcode(3))and(ctrl_ALUopcode(2))and(not ctrl_ALUopcode(1))and(ctrl_ALUopcode(0)),data_result);

comp: carrysaveadder port map (data_operandA, data_operandB,'0',cp_buffer,open,'1');

neq_buffer(0) <=cp_buffer(0);
G1: for i in 1 to 31 generate
	neq_buffer(i) <= cp_buffer(i) or neq_buffer(i-1);
end generate;

isNotEqual <= neq_buffer(31);
isLessThan <= cp_buffer(31);

END structure;