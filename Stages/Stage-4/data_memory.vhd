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
64 => X"E3A00000",
65 => X"E3A01001",
66 => X"E3A02002",
67 => X"E3A03003",
68 => X"E3A04004",
69 => X"E2A05005",
70 => X"E0006001",
71 => X"E0017002",
72 => X"E0028003",
73 => X"E0039004",
74 => X"E004A005",
75 => X"E0206001",
76 => X"E0217002",
77 => X"E0228003",
78 => X"E0239004",
79 => X"E024A005",
80 => X"E0406001",
81 => X"E0427001",
82 => X"E0428000",
83 => X"E0449001",
84 => X"E045A006",
85 => X"E0606001",
86 => X"E2617003",
87 => X"E2658002",
88 => X"E0806001",
89 => X"E0807002",
90 => X"E0868007",
91 => X"E1E06000",
92 => X"E1E07001",
93 => X"E1E08002",
94 => X"E1C06001",
95 => X"E1C17002",
96 => X"E1C28003",
97 => X"E1806001",
98 => X"E1817002",
99 => X"E1828003",
100 => X"E1100001",
101 => X"E1110002",
102 => X"E1120003",
103 => X"E1300001",
104 => X"E1310002",
105 => X"E1320003",
106 => X"E1500001",
107 => X"E1510002",
108 => X"E1520002",
109 => X"E1700001",
110 => X"E1710002",
111 => X"E3520002",
112 => X"E0A06001",
113 => X"E0A17002",
114 => X"E0406001",
115 => X"E0A28003",
116 => X"E0C16000",
117 => X"E0C07001",
118 => X"E0E06001",
119 => X"E2E17002",
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