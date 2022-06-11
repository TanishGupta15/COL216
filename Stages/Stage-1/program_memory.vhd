library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity program_memory is
port(
  read_address: in std_logic_vector(7 downto 0);
  data_out: out std_logic_vector(31 downto 0));
end program_memory;

architecture prog_mem of program_memory is
type prog_memory is array(0 to 63) of std_logic_vector(31 downto 0);
signal mem: prog_memory := (others=>(others=>'0'));
begin
    data_out <= mem(to_integer(unsigned(read_address(5 downto 0)))); --Only taking the initial 6 bits as discussed in lecture
end prog_mem;
