library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity shifter8 is
port(

  input: in std_logic_vector(31 downto 0);
  msb_bits: in std_logic_vector(7 downto 0);	
  
  ci: in std_logic; --Carry input  
  shift_amount: in std_logic;
  
  output: out std_logic_vector(31 downto 0);
  co: out std_logic); --Carry output
   
end shifter8;

architecture shifter8_arch of shifter8 is 

begin
	process(input, msb_bits, ci, shift_amount) is
    	begin
        	if(shift_amount = '1') then
            	output(23 downto 0) <= input(31 downto 8);
            	output(31 downto 24) <= msb_bits(7 downto 0);
                co <= input(7);
            else 
            	output <= input;
                co <= ci;
            end if; --Check this for ROR!
    end process;

end shifter8_arch;