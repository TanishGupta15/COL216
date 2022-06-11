
    -- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity datapath is
	port (
    	clk: in std_logic;
        
        
        --Control signals
        
        write_enable_register: in std_logic; --Write enable for register
        Asrc1: in std_logic;
        Fset: in std_logic;
        MW: in std_logic_vector(3 downto 0);
        M2R: in std_logic;
        Rsrc: in std_logic;
        PW: in std_logic;
        IorD: in std_logic;
        MR: in std_logic_vector(3 downto 0);
        IW: in std_logic;
        DW: in std_logic;
        AW: in std_logic;
        BW: in std_logic;
        Asrc2: in std_logic_vector(1 downto 0);
        ReW: in std_logic;
        CI: in std_logic;
        
        instr_class: in instr_class_type;
        operation: in optype;
        DP_subclass: in DP_subclass_type;
        DP_operand_src: in DP_operand_src_type;
        load_store: in load_store_type;
        DT_offset_sign: in DT_offset_sign_type;
        
        --Output 
    	flags: out std_logic_vector(3 downto 0);
       instruction: out std_logic_vector(31 downto 0)
        );
end datapath;

architecture datapath_arch of datapath is 

signal pc_datain: std_logic_vector(31 downto 0) := "00000000000000000000000100000000";
signal pc_dataout: std_logic_vector(31 downto 0) :="00000000000000000000000011111110"; --Since now data memory and program memory is same, I have assumed that program memory is from index 64 onwards


signal set_flags: std_logic_vector(3 downto 0):= "0000";  --NZCV
signal alu_res: std_logic_vector(31 downto 0);
signal alu_carry_out: std_logic;

signal read_add1_reg: std_logic_vector(3 downto 0);
signal read_add2_reg: std_logic_vector(3 downto 0);
signal write_add_reg: std_logic_vector(3 downto 0);
signal data_inp_reg: std_logic_vector(31 downto 0);
signal data_out1_reg: std_logic_vector(31 downto 0);
signal data_out2_reg: std_logic_vector(31 downto 0);

signal op: optype := adc;
signal op1: std_logic_vector(31 downto 0);
signal op2: std_logic_vector(31 downto 0);
signal data_memory_out: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal dp: std_logic := '0';

signal carry_input_ALU: std_logic := '0';

signal mem_address: std_logic_vector(31 downto 0) := "00000000000000000000000100000000";

--Internal registers
signal IR: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal DR: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal A: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal B: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal RES: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

	begin
    --Components
    
     PC: entity work.program_counter port map (
    
    	clk => clk,
        data_in => pc_datain,
        write_enable_pc => PW,
        data_out => pc_dataout
    
    );
    
    
        ALU: entity work.ALU port map (
    	
        op1 => op1,
        op2 => op2,
        opcode => op,
        ci => carry_input_ALU,
        co => alu_carry_out,
        S => alu_res        
    
    );
    
    
        DM: entity work.data_memory port map (
        
    	address => mem_address,
        data_in => B,
        clock => clk,
        write_enables => MW,
        read_enables => MR,
        data_out => data_memory_out
        
    );
    
    
    
    
	RF: entity work.register_file port map (
	
    	read_address1 => read_add1_reg,
        read_address2 => read_add2_reg,
        write_address => write_add_reg,
        data_in => data_inp_reg,
        write_enable => write_enable_register,
        clock => clk,
        data_out1 => data_out1_reg,
        data_out2 => data_out2_reg
    
    );
    
    
    
        FS: entity work.flags port map (
        
    	clock => clk,
    	A_in => op1,
        B_in => op2,
        result => alu_res,
        s_bit => Fset,
        carry_out => alu_carry_out,
        is_dp => dp,
        dp_subclass => DP_subclass,
        
        flags_out => set_flags
 
    );
    
    
    
        --Register assignments
    
    IR <= data_memory_out when IW = '1';
    DR <= data_memory_out when DW = '1';
    A <= data_out1_reg when AW = '1';
    B <= data_out2_reg when BW = '1';
    RES <= alu_res when ReW = '1';
    
    
    
    	--Multiplexers
        
        mem_address <= pc_dataout when IorD = '0' else RES;
		read_add2_reg <= IR(3 downto 0) when Rsrc = '0' else IR(15 downto 12);
        data_inp_reg <= DR when M2R = '1' else RES;
        op <= adc when instr_class = BRN else
              adc when Asrc1 = '0' else
        	  add when (instr_class = DT and DT_offset_sign = plus) else 
			  sub when (instr_class = DT and DT_offset_sign = minus) else
			  operation;
        op1 <= ("00" & pc_dataout(31 downto 2))  when Asrc1 = '0' else A;
        op2 <= 	B when Asrc2 = "00" else
        	   	"00000000000000000000000000000000" when Asrc2 = "01" else
                ("00000000000000000000" & IR(11 downto 0)) when Asrc2 = "10" else
                ("11111111" & IR(23 downto 0)) when IR(23) = '1' else 
                ("00000000" & IR(23 downto 0));
  
    
    --Other signal assignments
    read_add1_reg <= IR(19 downto 16);
    write_add_reg <= IR(15 downto 12);
    flags <= set_flags;
    carry_input_ALU <= '1' when CI = '1' else set_flags(1); 
    pc_datain <= (alu_res(29 downto 0) & "00");
    
    
    dp <= '0' when instr_class = DT or instr_class = MUL or instr_class = BRN or instr_class = none else '1';
    
	instruction <= IR;
	
end datapath_arch;
