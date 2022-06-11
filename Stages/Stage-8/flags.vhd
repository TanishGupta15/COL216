-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity flags is
	port (
    	clock: std_logic;
    	A_in, B_in, result: in std_logic_vector(31 downto 0); --inputs to ALU and output of ALU
        mult_res: in std_logic_vector(63 downto 0);
        carry_out_shifter: in std_logic;
        long_or_short_multiply: in std_logic;
        shift_amount: in std_logic_vector(4 downto 0);
        s_bit: in std_logic;
        carry_out: in std_logic; -- carry output from ALU
        is_dp: in std_logic; --whether the instrction is DP
        dp_subclass: in DP_subclass_type;
        op: in optype;
		  swi: in std_logic;
		  rte: in std_logic;
          state3: in std_logic;
          state18: in std_logic;
          instr_class: in instr_class_type;
		  reset: in std_logic;
        flags_out: out std_logic_vector(3 downto 0); --"NZCV" 
		  mode: out std_logic := '0' --0 means user mode and 1 means supervisor mode
        );
end entity;

architecture flags_arc of flags is
begin 
	process(clock, swi, rte, reset, s_bit, state18, state3)
    	begin
				if swi = '1' then 
					mode <= '1';
                end if;
				
				if rte = '1' and state18 = '1' then
					mode <= '0';
                end if;
					
				if reset = '1' and state18 = '1' then 
					mode <= '1';
                end if;
			
--             if rising_edge(clock) and shifter_carry_set = '1' then
--             	flags_out(1) <= carry_out_shifter;
                
                
            if rising_edge(clock) then --only change the flags if s_bit is 1
            	if(instr_class = MUL and s_bit = '1') then
                   if(long_or_short_multiply = '0') then --This means short multiply
                    flags_out(3) <= mult_res(31); --setting the N flag
                    	if mult_res(31 downto 0) = "00000000000000000000000000000000" then 
                    	flags_out(2) <= '1'; --Setting the Z flag
                        else flags_out(2) <= '0';
                    	end if;
                    else
                     flags_out(3) <= mult_res(63);
                     	if mult_res = X"0000000000000000" then flags_out(2) <= '1'; else flags_out(2) <= '0';
                        end if;
                    end if;    	
                elsif (instr_class = DP and s_bit = '0' and state3 = '1') then 
                	--Assuming that s-bit is always 1 for cmp
                 
                 	if(dp_subclass = comp) then 
                          
                      flags_out(3) <= result(31); --setting the N flag

                      if result = "00000000000000000000000000000000" then 
                          flags_out(2) <= '1'; --Setting the Z flag
                      else
                          flags_out(2) <= '0';
                      end if;

                      flags_out(1) <= carry_out; --Setting the C flag
                      if op = sub or op = cmp or op = sbc then 
                          flags_out(0) <= ((A_in(31) and not(B_in(31)) and (not(result(31)))) or (not(A_in(31)) and (B_in(31)) and result(31)));
                      elsif op = rsb or op = rsc then 
                          flags_out(0) <= ((not(A_in(31)) and B_in(31) and (not(result(31)))) or ((A_in(31)) and not(B_in(31)) and result(31)));
                      else
                          flags_out(0) <= ((A_in(31) and B_in(31) and (not(result(31)))) or (not(A_in(31)) and not(B_in(31)) and result(31))); --Setting the V flag
                      end if;
                    elsif(dp_subclass = test) then 
                      flags_out(3) <= result(31); --setting the N flag

                      if result = "00000000000000000000000000000000" then 
                          flags_out(2) <= '1'; --Setting the Z flag
                      else
                          flags_out(2) <= '0';
                      end if;
                      
                    end if;
                 
                 elsif (instr_class = DP and s_bit = '1') then --Here sbit is 1
                 	if (dp_subclass = arith or dp_subclass = comp) then 
                      flags_out(3) <= result(31); --setting the N flag

                      if result = "00000000000000000000000000000000" then 
                          flags_out(2) <= '1'; --Setting the Z flag
                      else
                          flags_out(2) <= '0';
                      end if;

                      flags_out(1) <= carry_out; --Setting the C flag
                      if op = sub or op = cmp or op = sbc then 
                          flags_out(0) <= ((A_in(31) and not(B_in(31)) and (not(result(31)))) or (not(A_in(31)) and (B_in(31)) and result(31)));
                      elsif op = rsb or op = rsc then 
                          flags_out(0) <= ((not(A_in(31)) and B_in(31) and (not(result(31)))) or ((A_in(31)) and not(B_in(31)) and result(31)));
                      else
                          flags_out(0) <= ((A_in(31) and B_in(31) and (not(result(31)))) or (not(A_in(31)) and not(B_in(31)) and result(31))); --Setting the V flag
                      end if;
                    else
                    	if(shift_amount = "00000") then
                          flags_out(3) <= result(31); --setting the N flag

                          if result = "00000000000000000000000000000000" then 
                              flags_out(2) <= '1'; --Setting the Z flag
                          else
                              flags_out(2) <= '0';
                          end if;
                    	else
                        	flags_out(3) <= result(31); --setting the N flag

                          if result = "00000000000000000000000000000000" then 
                              flags_out(2) <= '1'; --Setting the Z flag
                          else
                              flags_out(2) <= '0';
                          end if;
                          
                          	flags_out(1) <= carry_out_shifter;
                            
                         end if;
                    
                    end if;
                    	
                 
                 end if;
                end if;
    end process;
end flags_arc;