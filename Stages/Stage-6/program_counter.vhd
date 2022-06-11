library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity program_counter is

port(
	clk: in std_logic;
    data_in: in std_logic_vector(31 downto 0);
    
    write_enable_pc: in std_logic;
    data_out: out std_logic_vector(31 downto 0)
    );
end program_counter;

--Remember to change the input address of program memory to 32 bits type

architecture program_counter_arch of program_counter is 

signal reg: std_logic_vector(31 downto 0) := "00000000000000000000000011111110";

begin
	data_out <= reg;
	process(clk)
    	begin
        	if clk='1' and clk'event and write_enable_pc = '1' then
        	reg <= data_in;
    		end if;
    end process;
    
end program_counter_arch;