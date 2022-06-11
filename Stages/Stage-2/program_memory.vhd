library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity program_memory is
port(
  read_address: in std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
  data_out: out std_logic_vector(31 downto 0)  := "00000000000000000000000000000000" );
end program_memory;

architecture prog_mem of program_memory is
type prog_memory is array(0 to 63) of std_logic_vector(31 downto 0);
signal mem : prog_memory :=(0 => X"E3A00000",
1 => X"E3A01001",
2 => X"E3A02000",
3 => X"E3500018",
4 => X"0A000003",
5 => X"E5801000",
6 => X"E2811001",
7 => X"E2800004",
8 => X"EAFFFFF9",
9 => X"E3A00000",
10 => X"E3500018",
11 => X"0A000003",
12 => X"E5901000",
13 => X"E0822001",
14 => X"E2800004",
15 => X"EAFFFFF9",
others => X"00000000"
);

begin
    data_out <= mem(to_integer(unsigned(read_address(7 downto 2)))); --Only taking the initial 6 bits as discussed in lecture
end prog_mem;
