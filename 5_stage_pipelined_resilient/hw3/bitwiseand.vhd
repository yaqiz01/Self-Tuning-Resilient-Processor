LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bitwiseand IS
PORT ( data_operandA, data_operandB     : IN STD_LOGIC_VECTOR(31 downto 0);
   data_result    : OUT STD_LOGIC_VECTOR(31 downto 0));
END bitwiseand;

ARCHITECTURE structure OF bitwiseand IS

BEGIN
data_result <= data_operandA and data_operandB;
END structure;