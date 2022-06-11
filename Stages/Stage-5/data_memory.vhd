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
  data_out: out std_logic_vector(31 downto 0));
end data_memory;

architecture data_mem of data_memory is
type memory is array(0 to 127) of std_logic_vector(31 downto 0);
signal mem: memory := (
64 => X"E3A00C01",
65 => X"E3A01F41",
66 => X"E0810101",
others => (others => '0'));
--The first 64 vectors are for data memory and next 64 registers are for program memory. PM is read-only memory.

signal testing:integer;

begin
testing <= to_integer(unsigned(address(8 downto 2)));

    data_out <= mem(to_integer(unsigned(address(8 downto 2)))) when read_enables = "1111"; 
    --Last 2 bits are rejected as discussed in class
    process(clock, write_enables, address, data_in) is
        begin
          if clock='1' and clock'event then
            if write_enables(0)='1' then
            	mem(to_integer(unsigned(address(8 downto 2))))(7 downto 0) <= data_in(7 downto 0);
            end if;   
            if write_enables(1)='1' then
            	mem(to_integer(unsigned(address(8 downto 2))))(15 downto 7) <= data_in(15 downto 7);
            end if; 
            if write_enables(2)='1' then
            	mem(to_integer(unsigned(address(8 downto 2))))(23 downto 15) <= data_in(23 downto 15);
            end if; 
            if write_enables(3)='1' then
            	mem(to_integer(unsigned(address(8 downto 2))))(31 downto 24) <= data_in(31 downto 24);
            end if; 
          end if;
        end process;
end data_mem;