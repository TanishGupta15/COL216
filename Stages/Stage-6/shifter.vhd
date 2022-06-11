library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity shifter is
port(
  input: in std_logic_vector(31 downto 0);
  output: out std_logic_vector(31 downto 0);
  shift_type: in std_logic_vector(1 downto 0);
  ci: in std_logic; --Carry input
  co: out std_logic; --Carry output
  shift_amount: in std_logic_vector(4 downto 0));
end shifter;

architecture shifter_arch of shifter is 
--Define signals here
signal output01: std_logic_vector (31 downto 0);
signal msb_bit1: std_logic;
signal input_signal: std_logic_vector (31 downto 0);
signal cout1: std_logic;

signal output02: std_logic_vector (31 downto 0);
signal msb_bit2: std_logic_vector (1 downto 0);
signal cout2: std_logic;

signal output04: std_logic_vector (31 downto 0);
signal msb_bit4: std_logic_vector (3 downto 0);
signal cout4: std_logic;

signal output08: std_logic_vector (31 downto 0);
signal msb_bit8: std_logic_vector (7 downto 0);
signal cout8: std_logic;

signal output16: std_logic_vector (31 downto 0);
signal msb_bit16: std_logic_vector (15 downto 0);

begin

	S1: entity work.shifter1 port map (
    	
        input => input_signal,
        shift_amount => shift_amount(0),
        msb_bit => msb_bit1,
        ci => '0',
        output => output01,
        co => cout1
    	
    );
    
    
	S2: entity work.shifter2 port map (
    	
        input => output01,
        shift_amount => shift_amount(1),
        msb_bits => msb_bit2,
        ci => cout1,
        output => output02,
        co => cout2
    	
    );    
    
    
	S4: entity work.shifter4 port map (
    	
        input => output02,
        shift_amount => shift_amount(2),
        msb_bits => msb_bit4,
        ci => cout2,
        output => output04,
        co => cout4
    	
    );  
    
    
	S8: entity work.shifter8 port map (
    	
        input => output04,
        shift_amount => shift_amount(3),
        msb_bits => msb_bit8,
        ci => cout4,
        output => output08,
        co => cout8
    	
    );  
    
    
    
	S16: entity work.shifter16 port map (
    	
        input => output08,
        shift_amount => shift_amount(4),
        msb_bits => msb_bit16,
        ci => cout8,
        output => output16,
        co => co
    	
    );      
    
    
    
    --Signal assignments
    msb_bit1 <= '0' when shift_type = "01" else
    			'0' when shift_type = "00" else
                input(0) when shift_type = "11" else
                input(31);
                
    msb_bit2 <= "00" when shift_type = "01" else
    			"00" when shift_type = "00" else
                output01(1 downto 0) when shift_type = "11" else
                "00" when input(31) = '0' else
                "11";
                
                
    msb_bit4 <= "0000" when shift_type = "01" else
    			"0000" when shift_type = "00" else
                output02(3 downto 0) when shift_type = "11" else
                "0000" when input(31) = '0' else
                "1111";
                
                
    msb_bit8 <= "00000000" when shift_type = "01" else
    			"00000000" when shift_type = "00" else
                output04(7 downto 0) when shift_type = "11" else
                "00000000" when input(31) = '0' else
                "11111111";
                
    msb_bit16 <= "0000000000000000" when shift_type = "01" else
    			 "0000000000000000" when shift_type = "00" else
                output08(15 downto 0) when shift_type = "11" else
                "0000000000000000" when input(31) = '0' else
                "1111111111111111";

	process(input, shift_type) is 
    	begin
        	if(shift_type = "00") then 
        		for i in 0 to 31 loop
                	input_signal(i) <= input(31 - i);
                end loop;
    		else
            	input_signal <= input;
                
            end if;
   end process;
   
   process(output16, shift_type) is 
    	begin
        	if(shift_type = "00") then 
        		for i in 0 to 31 loop
                	output(i) <= output16(31 - i);
                end loop;
    		else
            	output <= output16;
            end if;
   end process;
   
   
end shifter_arch;