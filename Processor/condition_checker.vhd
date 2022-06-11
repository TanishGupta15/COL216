-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity condition_chk is 
	port (
    	instr_cond: in std_logic_vector(3 downto 0); --Bits 31 to 28 of instruction field
        NZCV: in std_logic_vector(3 downto 0);
        res: out std_logic --Whether condition true or not
        );
        
end entity;

architecture condition_chk_arch of condition_chk is

signal N: std_logic := '0';
signal Z: std_logic := '0';
signal C: std_logic := '0';
signal V: std_logic := '0';
--Defined these signals to improve the readability of the code


begin
	N <= NZCV(3);
   Z <= NZCV(2);
   C <= NZCV(1);
   V <= NZCV(0);
	process(instr_cond, N, Z, V, C)
    	begin
        	
            
        	res <= '0'; --default value
            
            --Refer slide 7 of lec04
        	case instr_cond is
            	when "0000" => --eq
                	if Z = '1' then res <= '1'; end if;
                when "0001"=> --ne
                	if Z = '0' then res <= '1'; end if;
                when "0010" => --hs/cs (c set)
                	if C = '1' then res <= '1'; end if;
                when "0011" => --lo/cc (c clear)
                	if C = '0' then res <= '1'; end if;
                when "0100" => --mi(minus)
                	if N = '1' then res <= '1'; end if;
                when "0101" => --pl(plus)
                	if N = '0' then res <= '1'; end if;
                when "0110" => --vs (v set)
                	if V = '1' then res <= '1'; end if;
                when "0111" => --vc (v clear)
                	if V = '0' then res <= '1'; end if;
                when "1000" => --hi
                	if (V = '1' and Z = '0') then res <= '1'; end if;
                when "1001" => --ls
                    if (C = '0' and Z = '1') then res <= '1'; end if;
                when "1010" => --ge
                	if ((N xor V) = '0') then res <= '1'; end if;
                when "1011" => --lt
                	if ((N xor V) = '1') then res <= '1'; end if;
                when "1100" => --gt
                	if ((Z = '0') and ((N xor V) = '0')) then res <= '1'; end if;
                when "1101" => --le
                	if ((Z = '1') and ((N xor V) = '1')) then res <= '1'; end if;
                when "1110" => --al
                	res <= '1';
                when others => 
                	res <= '0';
           end case;
           
    end process;
end condition_chk_arch;
                  