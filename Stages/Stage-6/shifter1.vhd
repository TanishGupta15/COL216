library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity shifter1 is
port(

  input: in std_logic_vector(31 downto 0);
  msb_bit: in std_logic;	
  
  ci: in std_logic; --Carry input  
  shift_amount: in std_logic;
  
  output: out std_logic_vector(31 downto 0);
  co: out std_logic); --Carry output
   
end shifter1;

architecture shifter1_arch of shifter1 is 

begin
	process(input, msb_bit, ci, shift_amount) is
    	begin
        	if(shift_amount = '1') then
            	output(30 downto 0) <= input(31 downto 1);
            	output(31) <= msb_bit;
            	co <= input(0);
            else
            	output <= input;
        		co <= ci; --Check this for ROR!
            end if;
    end process;

end shifter1_arch;