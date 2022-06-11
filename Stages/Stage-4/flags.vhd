-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

--should clock be an input?

entity flags is
	port (
    	clock: std_logic;
    	A_in, B_in, result: in std_logic_vector(31 downto 0); --inputs to ALU and output of ALU
        s_bit: in std_logic;
        carry_out: in std_logic; -- carry output from ALU
        is_dp: in std_logic; --whether the instrction is DP
        dp_subclass: in DP_subclass_type;
        op: in optype;
        flags_out: out std_logic_vector(3 downto 0) := "0000" --"NZCV" 
        );
end entity;

architecture flags_arc of flags is
signal flagv: std_logic_vector(3 downto 0) := "0000";
begin 
	flags_out <= flagv;
	process(clock)
    	begin
--         	if(rising_edge(is_dp)) then
--         		flags_out <= "0000";
--             end if;
            if rising_edge(clock) and s_bit = '1' then --only change the flags if s_bit is 1
            		flagv <= "0000";
                	--Assuming that s-bit is always 1 for cmp
                    flagv(3) <= result(31); --setting the N flag
                    if result = "00000000000000000000000000000000" then 
                    	flagv(2) <= '1'; --Setting the Z flag
                    end if;
                    
                    flagv(1) <= carry_out; --Setting the C flag
                    if op = sub or op = cmp or op = sbc then 
                    	flagv(0) <= ((A_in(31) and not(B_in(31)) and (not(result(31)))) or (not(A_in(31)) and (B_in(31)) and result(31)));
                    elsif op = rsb or op = rsc then 
                    	flagv(0) <= ((not(A_in(31)) and B_in(31) and (not(result(31)))) or ((A_in(31)) and not(B_in(31)) and result(31)));
                    else
                    	flagv(0) <= ((A_in(31) and B_in(31) and (not(result(31)))) or (not(A_in(31)) and not(B_in(31)) and result(31))); --Setting the V flag
-- 			else flags_out <= flagv;
					end if;
                 end if;
    end process;
end flags_arc;