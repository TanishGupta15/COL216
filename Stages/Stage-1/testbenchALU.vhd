library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component ALU is
port(
  op1: in std_logic_vector(31 downto 0);
  op2: in std_logic_vector(31 downto 0);
  opcode: in std_logic_vector(3 downto 0);
  ci: in std_logic; --Carry input
  co: out std_logic; --Carry output
  S: out std_logic_vector(31 downto 0));
end component;

signal a_in, b_in, q_out: std_logic_vector(31 downto 0);
signal cin, cout: std_logic;
signal opcode: std_logic_vector(3 downto 0);

begin

  -- Connect DUT
  DUT: ALU port map(a_in, b_in, opcode, cin, cout, q_out);

  process
  begin
   opcode <= "0000";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '0') report "Fail " severity error;

opcode <= "0000";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '1') report "Fail " severity error;

opcode <= "0000";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '0') report "Fail " severity error;

opcode <= "0000";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '1') report "Fail " severity error;

opcode <= "0000";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '0') report "Fail " severity error;

opcode <= "0000";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '1') report "Fail " severity error;

opcode <= "0000";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '0') report "Fail " severity error;

opcode <= "0000";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '1') report "Fail " severity error;

opcode <= "0001";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000101000" and cout = '0') report "Fail " severity error;

opcode <= "0001";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000101000" and cout = '1') report "Fail " severity error;

opcode <= "0001";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111101111011000" and cout = '0') report "Fail " severity error;

opcode <= "0001";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111101111011000" and cout = '1') report "Fail " severity error;

opcode <= "0001";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111101111001000" and cout = '0') report "Fail " severity error;

opcode <= "0001";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111101111001000" and cout = '1') report "Fail " severity error;

opcode <= "0001";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000111000" and cout = '0') report "Fail " severity error;

opcode <= "0001";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000111000" and cout = '1') report "Fail " severity error;

opcode <= "0010";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0010";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0010";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0010";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0010";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0010";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0010";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0010";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0011";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0011";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0011";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0011";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0011";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0011";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0011";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0011";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0100";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0100";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0100";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0100";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0100";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0100";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0100";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0100";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0101";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0101";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001001" and cout = '1') report "Fail " severity error;

opcode <= "0101";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0101";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011001" and cout = '0') report "Fail " severity error;

opcode <= "0101";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0101";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101001" and cout = '1') report "Fail " severity error;

opcode <= "0101";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0101";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111001" and cout = '0') report "Fail " severity error;

opcode <= "0110";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '0') report "Fail " severity error;

opcode <= "0110";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "0110";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001000111" and cout = '1') report "Fail " severity error;

opcode <= "0110";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0110";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110110111" and cout = '0') report "Fail " severity error;

opcode <= "0110";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0110";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '1') report "Fail " severity error;

opcode <= "0110";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0111";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '1') report "Fail " severity error;

opcode <= "0111";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "0111";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110110111" and cout = '0') report "Fail " severity error;

opcode <= "0111";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "0111";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001000111" and cout = '1') report "Fail " severity error;

opcode <= "0111";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "0111";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '0') report "Fail " severity error;

opcode <= "0111";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1000";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '0') report "Fail " severity error;

opcode <= "1000";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '1') report "Fail " severity error;

opcode <= "1000";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '0') report "Fail " severity error;

opcode <= "1000";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '1') report "Fail " severity error;

opcode <= "1000";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '0') report "Fail " severity error;

opcode <= "1000";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '1') report "Fail " severity error;

opcode <= "1000";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '0') report "Fail " severity error;

opcode <= "1000";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '1') report "Fail " severity error;

opcode <= "1001";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000101000" and cout = '0') report "Fail " severity error;

opcode <= "1001";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000101000" and cout = '1') report "Fail " severity error;

opcode <= "1001";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111101111011000" and cout = '0') report "Fail " severity error;

opcode <= "1001";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111101111011000" and cout = '1') report "Fail " severity error;

opcode <= "1001";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111101111001000" and cout = '0') report "Fail " severity error;

opcode <= "1001";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111101111001000" and cout = '1') report "Fail " severity error;

opcode <= "1001";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000111000" and cout = '0') report "Fail " severity error;

opcode <= "1001";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000111000" and cout = '1') report "Fail " severity error;

opcode <= "1010";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1010";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1010";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "1010";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "1010";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "1010";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "1010";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1010";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1011";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "1011";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111010001001000" and cout = '1') report "Fail " severity error;

opcode <= "1011";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1011";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1011";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1011";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1011";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "1011";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000101110111000" and cout = '0') report "Fail " severity error;

opcode <= "1100";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000111000" and cout = '0') report "Fail " severity error;

opcode <= "1100";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000111000" and cout = '1') report "Fail " severity error;

opcode <= "1100";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111101111111000" and cout = '0') report "Fail " severity error;

opcode <= "1100";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111101111111000" and cout = '1') report "Fail " severity error;

opcode <= "1100";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111111111011000" and cout = '0') report "Fail " severity error;

opcode <= "1100";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111111111011000" and cout = '1') report "Fail " severity error;

opcode <= "1100";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000011111111000" and cout = '0') report "Fail " severity error;

opcode <= "1100";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000011111111000" and cout = '1') report "Fail " severity error;

opcode <= "1101";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1101";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '1') report "Fail " severity error;

opcode <= "1101";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '0') report "Fail " severity error;

opcode <= "1101";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1101";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '0') report "Fail " severity error;

opcode <= "1101";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000011000" and cout = '1') report "Fail " severity error;

opcode <= "1101";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '0') report "Fail " severity error;

opcode <= "1101";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111101000" and cout = '1') report "Fail " severity error;

opcode <= "1110";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '0') report "Fail " severity error;

opcode <= "1110";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000000000100000" and cout = '1') report "Fail " severity error;

opcode <= "1110";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '0') report "Fail " severity error;

opcode <= "1110";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111100000010000" and cout = '1') report "Fail " severity error;

opcode <= "1110";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '0') report "Fail " severity error;

opcode <= "1110";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111000000" and cout = '1') report "Fail " severity error;

opcode <= "1110";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '0') report "Fail " severity error;

opcode <= "1110";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000010000010000" and cout = '1') report "Fail " severity error;

opcode <= "1111";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '0') report "Fail " severity error;

opcode <= "1111";
a_in <= "11111111111111111111100000110000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '1') report "Fail " severity error;

opcode <= "1111";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '0') report "Fail " severity error;

opcode <= "1111";
a_in <= "11111111111111111111100000110000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '1') report "Fail " severity error;

opcode <= "1111";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='0';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '0') report "Fail " severity error;

opcode <= "1111";
a_in <= "00000000000000000000011111010000";
b_in <= "11111111111111111111110000011000";
cin<='1';
wait for 1 ns;
assert(q_out="00000000000000000000001111100111" and cout = '1') report "Fail " severity error;

opcode <= "1111";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='0';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '0') report "Fail " severity error;

opcode <= "1111";
a_in <= "00000000000000000000011111010000";
b_in <= "00000000000000000000001111101000";
cin<='1';
wait for 1 ns;
assert(q_out="11111111111111111111110000010111" and cout = '1') report "Fail " severity error;




    assert false report "Test done." severity note;
    wait;
  end process;
end tb;
