
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity ALU is
port(
  op1: in std_logic_vector(31 downto 0);
  op2: in std_logic_vector(31 downto 0);
  opcode: in std_logic_vector(3 downto 0);
  ci: in std_logic; --Carry input
  co: out std_logic; --Carry output
  S: out std_logic_vector(31 downto 0));
end ALU;

architecture rtl of ALU is
begin
  process(op1, op2, ci, opcode) is
    variable sum: std_logic_vector(32 downto 0);
  begin
    case opcode is
    	when "0000" =>	--and
        	S <= op1 and op2;
            co <= ci;	
        when "0001" =>	--eor
        	S <= op1 xor op2;
            co <= ci;
        when "0010" =>	--sub
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "0011" =>	--rsb
        	sum := std_logic_vector(signed('0' & (not op1)) + signed('0' & op2) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "0100" =>	--add
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & op2));
            S <= sum(31 downto 0);
            co <= sum(32); 
        when "0101" =>	--adc
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & op2) + ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "0110" =>	--sbc
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "0111" =>	--rsc
        	sum := std_logic_vector(signed('0' & not op1) + signed('0' & op2) +  ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "1000" =>	--tst
        	S <= op1 and op2;
            co <= ci;
        when "1001" =>	--teq
        	S <= op1 xor op2;
            co <= ci;
        when "1010" =>	--cmp
            sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when "1011" =>	--cmn	
            sum := std_logic_vector(signed('0' & op1) + signed('0' & op2));
            S <= sum(31 downto 0);
            co <= sum(32);
        when "1100" =>	--orr
        	S <= op1 or op2;
            co <= ci;
        when "1101" =>	--mov
        	S <= op2;
            co <= ci;
        when "1110" =>	--bic
        	S <= op1 and (not op2);
            co <= ci;
        when "1111" =>	--mvn
        	S <= (not op2);
            co <= ci;
        when others =>
        	S <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
    end case;
  end process;
end rtl;
