
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity ALU is
port(
  op1: in std_logic_vector(31 downto 0);
  op2: in std_logic_vector(31 downto 0);
  opcode: in optype;
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
    	when andop =>	--and
        	S <= op1 and op2;
            co <= ci;	
        when eor =>	--eor
        	S <= op1 xor op2;
            co <= ci;
        when sub =>	--sub
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when rsb =>	--rsb
        	sum := std_logic_vector(signed('0' & (not op1)) + signed('0' & op2) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when add =>	--add
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & op2));
            S <= sum(31 downto 0);
            co <= sum(32); 
        when adc =>	--adc
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & op2) + ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when sbc =>	--sbc
        	sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when rsc =>	--rsc
        	sum := std_logic_vector(signed('0' & not op1) + signed('0' & op2) +  ci);
            S <= sum(31 downto 0);
            co <= sum(32);
        when tst =>	--tst
        	S <= op1 and op2;
            co <= ci;
        when teq =>	--teq
        	S <= op1 xor op2;
            co <= ci;
        when cmp =>	--cmp
            sum := std_logic_vector(signed('0' & op1) + signed('0' & (not op2)) + 1);
            S <= sum(31 downto 0);
            co <= sum(32);
        when cmn =>	--cmn	
            sum := std_logic_vector(signed('0' & op1) + signed('0' & op2));
            S <= sum(31 downto 0);
            co <= sum(32);
        when orr =>	--orr
        	S <= op1 or op2;
            co <= ci;
        when mov =>	--mov
        	S <= op2;
            co <= ci;
        when bic =>	--bic
        	S <= op1 and (not op2);
            co <= ci;
        when mvn =>	--mvn
        	S <= (not op2);
            co <= ci;
        when others =>
        	S <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";
            co <= ci;
    end case;
  end process;
end rtl;
