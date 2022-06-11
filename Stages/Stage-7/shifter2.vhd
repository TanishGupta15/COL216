library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity shifter2 is
port(

  input: in std_logic_vector(31 downto 0);
  msb_bits: in std_logic_vector(1 downto 0);	
  
  ci: in std_logic; --Carry input  
  shift_amount: in std_logic;
  
  output: out std_logic_vector(31 downto 0);
  co: out std_logic); --Carry output
   
end shifter2;

architecture shifter2_arch of shifter2 is 

begin
	process(input, msb_bits, ci, shift_amount) is
    	begin
        	if(shift_amount = '1') then
            	output(29 downto 0) <= input(31 downto 2);
            	output(31 downto 30) <= msb_bits(1 downto 0);
                co <= input(1);
            else
            	output <= input;
                co <= ci; --Check this for ROR!
           end if;
    end process;

end shifter2_arch;