LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RAM_TB IS 
-- empty
END ENTITY;

ARCHITECTURE BEV OF RAM_TB IS


SIGNAL ADDRESS : STD_LOGIC_VECTOR(7 DOWNTO 0):="00000000";
SIGNAL DATAOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL CLK : STD_LOGIC;
SIGNAL WR_EN : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
SIGNAL DATAIN : STD_LOGIC_VECTOR(31 DOWNTO 0);

-- DUT component
COMPONENT data_memory IS
    PORT(address: in std_logic_vector(7 downto 0);
  data_in: in std_logic_vector(31 downto 0);
  clock: in std_logic;
  write_enables: in std_logic_vector(3 downto 0);
  data_out: out std_logic_vector(31 downto 0));
END COMPONENT;

BEGIN

  -- Connect DUT
  UUT: data_memory PORT MAP(ADDRESS, DATAIN, CLK, WR_EN, DATAOUT);

  PROCESS
  BEGIN
  	--Write data
    WR_EN <= "0001";
    CLK <= '0';
    WAIT FOR 50 ns;
    CLK <= '1';
    ADDRESS <= "10000000";
    DATAIN <= "00000000000000000010000000110011";
    WAIT FOR 5 ns; --To account for the delta delay
    assert(DATAOUT="00000000000000000000000000110011") report "Fail" severity error;
  	WAIT FOR 45 ns;
    WR_EN <= "0011";
    CLK <= '0';
    WAIT FOR 50 ns;
    CLK <= '1';
    ADDRESS <= "10010000";
    DATAIN <= "00111100001100110011001100110011";
    WAIT FOR 50 ns;
    WR_EN <= "0101";
    CLK <= '0';
    WAIT FOR 50 ns;
    CLK <= '1';
    ADDRESS <= "10100000";
    DATAIN <= "00110011001100110011001100110011";
    WAIT FOR 100 ns;
    -- Read data from RAM
    WR_EN <= "0000";
    ADDRESS<="10000000";
    wait for 5 ns;
    assert(DATAOUT="00000000000000000000000000110011") REPORT "FAIL 0/0" SEVERITY ERROR;
    WAIT FOR 100 ns;
    ADDRESS<="10010000";
    wait for 5 ns;
    assert(DATAOUT="00000000000000000011001100110011") REPORT "FAIL 0/0" SEVERITY ERROR;
    WAIT FOR 100 ns;
    ADDRESS<="10100000";
    wait for 5 ns;
    assert(DATAOUT="00000000001100110000000000110011") REPORT "FAIL 0/0" SEVERITY ERROR;
    
    ASSERT FALSE REPORT "Test done. Open EPWave to see signals." SEVERITY NOTE;
    WAIT;
  END PROCESS;

END BEV;

