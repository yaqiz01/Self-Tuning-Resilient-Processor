LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder3To8 IS
PORT ( 
   address : IN STD_LOGIC_VECTOR(0 to 2);
   enable: IN STD_LOGIC;
   output : OUT STD_LOGIC_VECTOR(0 to 7));
END decoder3To8;

ARCHITECTURE structure OF decoder3To8 IS
BEGIN

output(7) <= address(2) and address(1) and address(0) and enable;
output(6) <= address(2) and address(1) and (not address(0)) and enable;
output(5) <= address(2) and (not address(1)) and (address(0)) and enable;
output(4) <= address(2) and (not address(1)) and (not address(0)) and enable;
output(3) <= (not address(2)) and address(1) and address(0) and enable;
output(2) <= (not address(2)) and address(1) and (not address(0)) and enable;
output(1) <= (not address(2)) and (not address(1)) and (address(0)) and enable;
output(0) <= (not address(2)) and (not address(1)) and (not address(0)) and enable;
END structure;

