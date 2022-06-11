-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity FSM is 
	port (
    	clk: in std_logic;
                
        instr_class: in instr_class_type;
        operation: in optype;
        DP_subclass: in DP_subclass_type;
        DP_operand_src: in DP_operand_src_type;
        load_store: in load_store_type;
        DT_offset_sign: in DT_offset_sign_type;
        
        
        output_state: out integer);
end FSM;

architecture FSM_arch of FSM is

signal present_state: integer := 0;
--State 0 is like the null state where FSM will be before anything starts, as soon as first rising edge is recieved the FSM moves to the 1st state i.e. State 1.

begin
	output_state <= present_state;
	process(clk)
    	begin
        	if(rising_edge(clk)) then 
            	if(present_state = 0) then
                	present_state <= 1;
          		elsif(present_state = 1) then
                	present_state <= 2;
                elsif(present_state = 2) then
                	if(instr_class = DP) then --This means DP instruction
                    	present_state <= 3;
                    elsif(instr_class = DT) then
                    	present_state <= 5;
                    else --This means the instruction is Branch
                    	present_state <= 9;
                    end if;
                elsif(present_state <= 3) then
                	present_state <= 4;
                elsif(present_state <= 4) then
                	present_state <= 1;
                elsif(present_state <= 5) then
                	if(load_store = store) then
                    	present_state <= 6;
                    else 
                    	present_state <= 7;
                    end if;
                elsif(present_state <= 6) then
                	present_state <= 1;
                elsif(present_state <= 7) then
                	 present_state <= 8;
                elsif(present_state <= 8) then
                	present_state <= 1;
                elsif(present_state <= 9) then
                	present_state <= 1;
                else --Won't reach here ever though 
                	present_state <= 0;
                end if;
            			
            
            end if;
            
    end process;
    
end FSM_arch;