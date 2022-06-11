library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity data_memory is
port(
  address: in std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
  data_in: in std_logic_vector(31 downto 0);
  clock: in std_logic;
  write_enables: in std_logic_vector(3 downto 0);
  data_out: out std_logic_vector(31 downto 0)  := "00000000000000000000000000000000");
end data_memory;

architecture data_mem of data_memory is
type memory is array(0 to 63) of std_logic_vector(31 downto 0);
signal mem: memory := (others => (others => '0'));
begin
    data_out <= mem(to_integer(unsigned(address(5 downto 0)))); --Last 2 bits are rejected as discussed in class
    process(clock, write_enables, address, data_in) is
        begin
          if clock='1' and clock'event then
            if write_enables(0)='1' then
            	mem(to_integer(unsigned(address(5 downto 0))))(7 downto 0) <= data_in(7 downto 0);
            end if;   
            if write_enables(1)='1' then
            	mem(to_integer(unsigned(address(5 downto 0))))(15 downto 7) <= data_in(15 downto 7);
            end if; 
            if write_enables(2)='1' then
            	mem(to_integer(unsigned(address(5 downto 0))))(23 downto 15) <= data_in(23 downto 15);
            end if; 
            if write_enables(3)='1' then
            	mem(to_integer(unsigned(address(5 downto 0))))(31 downto 24) <= data_in(31 downto 24);
            end if; 
          end if;
        end process;
end data_mem;