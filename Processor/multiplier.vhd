library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity multiplier is 
	port (
    	op1: in std_logic_vector(31 downto 0);
		op2: in std_logic_vector(31 downto 0);
		is_signed: in std_logic; --1 if instruction is smull else 0
		accumulator: in std_logic_vector(63 downto 0);
		result: out std_logic_vector(63 downto 0)
        );
        
end entity;

architecture multiplier_arch of multiplier is

signal x1, x2 : std_logic;
signal p_s: std_logic_vector(65 downto 0);
signal temp: std_logic_vector(63 downto 0);

begin
	x1 <= op1(31) when is_signed = '1' else '0';
	x2 <= op2(31) when is_signed = '1' else '0';
	
	p_s <= std_logic_vector(signed(x1 & op1) * signed(x2 & op2));
	temp <= p_s(63 downto 0);
	result <= std_logic_vector(signed(temp) + signed(accumulator));

end architecture;