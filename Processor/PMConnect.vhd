library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity PMConnect is
port (
	 Rout: in std_logic_vector(31 downto 0);
    Instruction: in std_logic_vector(31 downto 0);
    Control_State: in std_logic; --Control_State = 1 if FSM State = 6 else it is 0
    Adr: in std_logic_vector(1 downto 0);
    Mout: in std_logic_vector(31 downto 0);
    
    MW: out std_logic_vector(3 downto 0) := "0000";
    Min: out std_logic_vector(31 downto 0) := X"00000000";
    Rin: out std_logic_vector(31 downto 0) := X"00000000"
    
);

end PMConnect;

architecture PMConnect_arch of PMConnect is 

begin
	process(Rout, Instruction, Control_State, Adr, Mout) is
    begin
	case Instruction(27 downto 26) is
    	when "01" => --ldr, str, ldrb, strb
        	case Instruction(20) is
            	when '1' => --load instructions
                	case Instruction(22) is 
                    	when '0' => 	--word transfer, ldr
                        	Rin <= Mout;
                        when others =>  --byte transfer, ldrb
                        	case Adr is
                            	when "00" =>
                        			Rin(31 downto 8) <= X"000000";
                            		Rin(7 downto 0) <= Mout(7 downto 0);
                                when "01" =>
                        			Rin(31 downto 8) <= X"000000";
                            		Rin(7 downto 0) <= Mout(15 downto 8);
                                when "10" =>
                        			Rin(31 downto 8) <= X"000000";
                            		Rin(7 downto 0) <= Mout(23 downto 16);
                                when others =>
                        			Rin(31 downto 8) <= X"000000";
                            		Rin(7 downto 0) <= Mout(31 downto 24);
                                    
                        
                			end case;
                  end case;
               when others => --store instructions
               		case Instruction(22) is 
                    	when '0' => 	--word transfer, str
                        	Min <= Rout;
                            if (Control_State = '1') then
                            	MW <= "1111";
                            else
                            	MW <= "0000";
                            end if;
                        when others =>  --byte transfer, strb
                        	case Adr is
                            	when "00" =>
                        			Min(31 downto 24) <= Rout(7 downto 0);
                                    Min(23 downto 16) <= Rout(7 downto 0);
                                    Min(15 downto 8) <= Rout(7 downto 0);
                                    Min(7 downto 0) <= Rout(7 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "0001";
                            		else
                            			MW <= "0000";
                                    end if;
                                when "01" =>
                        			Min(31 downto 24) <= Rout(7 downto 0);
                                    Min(23 downto 16) <= Rout(7 downto 0);
                                    Min(15 downto 8) <= Rout(7 downto 0);
                                    Min(7 downto 0) <= Rout(7 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "0010";
                            		else
                            			MW <= "0000";
                                    end if;
                                when "10" =>
                        			Min(31 downto 24) <= Rout(7 downto 0);
                                    Min(23 downto 16) <= Rout(7 downto 0);
                                    Min(15 downto 8) <= Rout(7 downto 0);
                                    Min(7 downto 0) <= Rout(7 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "0100";
                            		else
                            			MW <= "0000";
                                    end if;
                                when others =>
                        			Min(31 downto 24) <= Rout(7 downto 0);
                                    Min(23 downto 16) <= Rout(7 downto 0);
                                    Min(15 downto 8) <= Rout(7 downto 0);
                                    Min(7 downto 0) <= Rout(7 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "1000";
                            		else
                            			MW <= "0000";
                                    end if;
                                    
                        
                			end case;
                  	end case;
          		end case;	
        	

		when others => --Essentially this means that "00" 
			case Instruction(6 downto 5) is
            	when "01" => --ldrh and strh
                	case Instruction(20) is 
                    	when '1' => --load instruction, ldrh
                			case Adr is
                            	when "00" =>
                                	Rin(31 downto 16) <= X"0000";
                                    Rin(15 downto 0) <= Mout(15 downto 0);
										when "01" =>
                                	Rin(31 downto 16) <= X"0000";
                                    Rin(15 downto 0) <= Mout(15 downto 0);
										  when others =>
                                	Rin(31 downto 16) <= X"0000";
                                    Rin(15 downto 0) <= Mout(31 downto 16);
                             end case;
                       when others => --store instruction, strh
                       		case Adr is
                            	when "00" =>
                                	Min(31 downto 16) <= Rout(15 downto 0);
                                    Min(15 downto 0) <= Rout(15 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "0011";
                            		else
                            			MW <= "0000";
                                    end if;
										 when "01" =>
                                	Min(31 downto 16) <= Rout(15 downto 0);
                                    Min(15 downto 0) <= Rout(15 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "0011";
                            		else
                            			MW <= "0000";
                                    end if;
                                when others =>
                                	Min(31 downto 16) <= Rout(15 downto 0);
                                    Min(15 downto 0) <= Rout(15 downto 0);
                                    if (Control_State = '1') then
                            			MW <= "1100";
                            		else
                            			MW <= "0000";
                                    end if;
                           	end case;
                     end case;
                when "10" => --ldrsb, I am assuming that Instruction(20) bit will always be '1' in this case, as this can only be a load instruction
                	case Adr is
                    	when "00" =>
                			Rin(31) <= Mout(7);
                    		Rin(30) <= Mout(7);
                            Rin(29) <= Mout(7);
                            Rin(28) <= Mout(7);
                            Rin(27) <= Mout(7);
                            Rin(26) <= Mout(7);
                            Rin(25) <= Mout(7);
                            Rin(24) <= Mout(7);
                            Rin(23) <= Mout(7);
                            Rin(22) <= Mout(7);
                            Rin(21) <= Mout(7);
                            Rin(20) <= Mout(7);
                            Rin(19) <= Mout(7);
                            Rin(18) <= Mout(7);
                            Rin(17) <= Mout(7);
                            Rin(16) <= Mout(7);
                            Rin(15) <= Mout(7);
                            Rin(14) <= Mout(7);
                            Rin(13) <= Mout(7);
                            Rin(12) <= Mout(7);
                            Rin(11) <= Mout(7);
                            Rin(10) <= Mout(7);
                            Rin(9) <= Mout(7);
                            Rin(8) <= Mout(7);
                            Rin(7 downto 0) <= Mout(7 downto 0);
                       when "01" =>
                			Rin(31) <= Mout(15);
                    		Rin(30) <= Mout(15);
                            Rin(29) <= Mout(15);
                            Rin(28) <= Mout(15);
                            Rin(27) <= Mout(15);
                            Rin(26) <= Mout(15);
                            Rin(25) <= Mout(15);
                            Rin(24) <= Mout(15);
                            Rin(23) <= Mout(15);
                            Rin(22) <= Mout(15);
                            Rin(21) <= Mout(15);
                            Rin(20) <= Mout(15);
                            Rin(19) <= Mout(15);
                            Rin(18) <= Mout(15);
                            Rin(17) <= Mout(15);
                            Rin(16) <= Mout(15);
                            Rin(15) <= Mout(15);
                            Rin(14) <= Mout(15);
                            Rin(13) <= Mout(15);
                            Rin(12) <= Mout(15);
                            Rin(11) <= Mout(15);
                            Rin(10) <= Mout(15);
                            Rin(9) <= Mout(15);
                            Rin(8) <= Mout(15);
                            Rin(7 downto 0) <= Mout(15 downto 8);
                       when "10" =>
                			Rin(31) <= Mout(23);
                    		Rin(30) <= Mout(23);
                            Rin(29) <= Mout(23);
                            Rin(28) <= Mout(23);
                            Rin(27) <= Mout(23);
                            Rin(26) <= Mout(23);
                            Rin(25) <= Mout(23);
                            Rin(24) <= Mout(23);
                            Rin(23) <= Mout(23);
                            Rin(22) <= Mout(23);
                            Rin(21) <= Mout(23);
                            Rin(20) <= Mout(23);
                            Rin(19) <= Mout(23);
                            Rin(18) <= Mout(23);
                            Rin(17) <= Mout(23);
                            Rin(16) <= Mout(23);
                            Rin(15) <= Mout(23);
                            Rin(14) <= Mout(23);
                            Rin(13) <= Mout(23);
                            Rin(12) <= Mout(23);
                            Rin(11) <= Mout(23);
                            Rin(10) <= Mout(23);
                            Rin(9) <= Mout(23);
                            Rin(8) <= Mout(23);
                            Rin(7 downto 0) <= Mout(23 downto 16);
                      when others =>
                			Rin(31) <= Mout(31);
                    		Rin(30) <= Mout(31);
                            Rin(29) <= Mout(31);
                            Rin(28) <= Mout(31);
                            Rin(27) <= Mout(31);
                            Rin(26) <= Mout(31);
                            Rin(25) <= Mout(31);
                            Rin(24) <= Mout(31);
                            Rin(23) <= Mout(31);
                            Rin(22) <= Mout(31);
                            Rin(21) <= Mout(31);
                            Rin(20) <= Mout(31);
                            Rin(19) <= Mout(31);
                            Rin(18) <= Mout(31);
                            Rin(17) <= Mout(31);
                            Rin(16) <= Mout(31);
                            Rin(15) <= Mout(31);
                            Rin(14) <= Mout(31);
                            Rin(13) <= Mout(31);
                            Rin(12) <= Mout(31);
                            Rin(11) <= Mout(31);
                            Rin(10) <= Mout(31);
                            Rin(9) <= Mout(31);
                            Rin(8) <= Mout(31);
                            Rin(7 downto 0) <= Mout(31 downto 24);
                end case;
            when others => --This should mean "11" as we are not defining for 00, this is ldrsh
            	case Adr is
                	when "00" =>
                			Rin(31) <= Mout(15);
                    		Rin(30) <= Mout(15);
                            Rin(29) <= Mout(15);
                            Rin(28) <= Mout(15);
                            Rin(27) <= Mout(15);
                            Rin(26) <= Mout(15);
                            Rin(25) <= Mout(15);
                            Rin(24) <= Mout(15);
                            Rin(23) <= Mout(15);
                            Rin(22) <= Mout(15);
                            Rin(21) <= Mout(15);
                            Rin(20) <= Mout(15);
                            Rin(19) <= Mout(15);
                            Rin(18) <= Mout(15);
                            Rin(17) <= Mout(15);
                            Rin(16) <= Mout(15);
                            Rin(15 downto 0) <= Mout(15 downto 0);
                	when "01" =>
                			Rin(31) <= Mout(15);
                    		Rin(30) <= Mout(15);
                            Rin(29) <= Mout(15);
                            Rin(28) <= Mout(15);
                            Rin(27) <= Mout(15);
                            Rin(26) <= Mout(15);
                            Rin(25) <= Mout(15);
                            Rin(24) <= Mout(15);
                            Rin(23) <= Mout(15);
                            Rin(22) <= Mout(15);
                            Rin(21) <= Mout(15);
                            Rin(20) <= Mout(15);
                            Rin(19) <= Mout(15);
                            Rin(18) <= Mout(15);
                            Rin(17) <= Mout(15);
                            Rin(16) <= Mout(15);
                            Rin(15 downto 0) <= Mout(15 downto 0);
                    when others =>
                			Rin(31) <= Mout(31);
                    		Rin(30) <= Mout(31);
                            Rin(29) <= Mout(31);
                            Rin(28) <= Mout(31);
                            Rin(27) <= Mout(31);
                            Rin(26) <= Mout(31);
                            Rin(25) <= Mout(31);
                            Rin(24) <= Mout(31);
                            Rin(23) <= Mout(31);
                            Rin(22) <= Mout(31);
                            Rin(21) <= Mout(31);
                            Rin(20) <= Mout(31);
                            Rin(19) <= Mout(31);
                            Rin(18) <= Mout(31);
                            Rin(17) <= Mout(31);
                            Rin(16) <= Mout(31);
                            Rin(15 downto 0) <= Mout(31 downto 16);
                            
          		end case;  --Adr case
            end case; --Instruction(6 downto 5) case
        end case; --Instruction(27 downto 26) case
	end process;
end PMConnect_arch;