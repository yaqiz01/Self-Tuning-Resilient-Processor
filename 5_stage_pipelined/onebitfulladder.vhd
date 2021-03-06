LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY onebitfulladder IS
PORT ( input1, input2 , carryin: IN STD_LOGIC;
   carryout, sum : OuT STD_LOGIC);
END onebitfulladder;

ARCHITECTURE structure OF onebitfulladder IS

BEGIN
sum <= (input1 xor input2) xor carryin;
carryout <= ((input1 xor input2) and carryin) or (input1 and input2);
END structure;
