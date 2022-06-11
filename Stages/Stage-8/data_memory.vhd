library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity data_memory is
port(
  address: in std_logic_vector(31 downto 0);
  data_in: in std_logic_vector(31 downto 0);
  clock: in std_logic;
  write_enables: in std_logic_vector(3 downto 0);
  read_enables: in std_logic_vector(3 downto 0);
  mode: in std_logic;
  data_out: out std_logic_vector(31 downto 0));
end data_memory;

architecture data_mem of data_memory is
type memory is array(0 to 127) of std_logic_vector(31 downto 0);
signal mem: memory := (
0 => X"EA000002",
4 => X"E3A0E040",
5 => X"E6000011",
8 => X"EA000002",
12 => X"E3A000A0",
13 => X"E5900000",
14 => X"E6000011",
--Till here were hardcoded ISRs


64 => X"EF000000",
65 => X"EF000000",
66 => X"EF000000",
67 => X"E3A020A0",
68 => X"E5921000",
others => (others => '0'));

signal testing:integer;

begin
testing <= to_integer(unsigned(address(8 downto 2)));

    data_out <= 	X"00000000" when (mode = '0' and (to_integer(unsigned(address(8 downto 2)))) < 64) else 
							mem(to_integer(unsigned(address(8 downto 2)))) when read_enables = "1111"; 
    --Last 2 bits are rejected as discussed in class
    process(clock, write_enables, address, data_in, mode) is
        begin
          if clock='1' and clock'event then
				if (mode = '0' and ((to_integer(unsigned(address(8 downto 2)))) > 64)) then 
					if write_enables(0)='1' then
						mem(to_integer(unsigned(address(8 downto 2))))(7 downto 0) <= data_in(7 downto 0);
					end if;   
					if write_enables(1)='1' then
						mem(to_integer(unsigned(address(8 downto 2))))(15 downto 8) <= data_in(15 downto 8);
					end if; 
					if write_enables(2)='1' then
						mem(to_integer(unsigned(address(8 downto 2))))(23 downto 16) <= data_in(23 downto 16);
					end if; 
					if write_enables(3)='1' then
						mem(to_integer(unsigned(address(8 downto 2))))(31 downto 24) <= data_in(31 downto 24);
					end if; 
				elsif mode = '1' and (to_integer(unsigned(address(8 downto 2))) = 40 and write_enables = "1111") then 
					mem(to_integer(unsigned(address(8 downto 2))))(31 downto 0) <= data_in(31 downto 0);
				end if;
          end if;
        end process;
end data_mem;