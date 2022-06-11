library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity register_file is
port(
  read_address1: in std_logic_vector(3 downto 0);
  read_address2: in std_logic_vector(3 downto 0);
  write_address: in std_logic_vector(3 downto 0);
  data_in: in std_logic_vector(31 downto 0);
  write_enable: in std_logic;
  clock: in std_logic;
  data_out1: out std_logic_vector(31 downto 0);
  data_out2: out std_logic_vector(31 downto 0));
end register_file;

architecture reg of register_file is
type registers is array(0 to 15) of std_logic_vector(31 downto 0);
signal regis: registers;
begin
  data_out1 <= regis(to_integer(unsigned(read_address1)));
  data_out2 <= regis(to_integer(unsigned(read_address2)));
  process(clock, write_address, write_enable, data_in) is
  begin
    if clock='1' and clock'event and write_enable = '1' then
        regis(to_integer(unsigned(write_address))) <= data_in;
    end if;
  end process;
end reg;
