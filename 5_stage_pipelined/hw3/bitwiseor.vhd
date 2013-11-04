LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bitwiseor IS
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END bitwiseor;

ARCHITECTURE structure OF bitwiseor IS

BEGIN
	data_result <= data_operandA or data_operandB;
END structure;