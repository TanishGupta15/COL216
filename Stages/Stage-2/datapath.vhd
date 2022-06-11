
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
        Asrc: in std_logic;
        Fset: in std_logic;
        MW: in std_logic_vector(3 downto 0);
        M2R: in std_logic;
        Rsrc: in std_logic;
        Psrc: in std_logic;
        
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

signal pc_datain: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

signal pc_dataout: std_logic_vector(31 downto 0) := "11111111111111111111111111111100";


signal op2: std_logic_vector(31 downto 0);
signal set_flags: std_logic_vector(3 downto 0):= "0000";  --NZCV
signal alu_res: std_logic_vector(31 downto 0);
signal alu_carry_out: std_logic;

signal read_add1_reg: std_logic_vector(3 downto 0);
signal read_add2_reg: std_logic_vector(3 downto 0);
signal write_add_reg: std_logic_vector(3 downto 0);
signal data_inp_reg: std_logic_vector(31 downto 0);
signal data_out1_reg: std_logic_vector(31 downto 0);
signal data_out2_reg: std_logic_vector(31 downto 0);

signal instruction_out: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal op: optype;
signal data_memory_out: std_logic_vector(31 downto 0);
signal pc_offset_sig: std_logic_vector(31 downto 0);
signal dp: std_logic := '0';
signal pc4_sig: std_logic_vector(31 downto 0);

	begin
    --Components
    
    process(instruction_out, Psrc, Rsrc) 
    	variable pc4: std_logic_vector(31 downto 0);
		variable pc_offset: std_logic_vector(31 downto 0);
      	variable shifted_instruction: std_logic_vector(31 downto 0);
    	begin
    pc4 := std_logic_vector(signed(pc_dataout) + ("00000000000000000000000000000100"));
	 
	 if instruction_out(23) = '1' then shifted_instruction := ("111111" & instruction_out(23 downto 0) & "00");
	 else shifted_instruction:= ("000000" & instruction_out(23 downto 0) & "00");
	 end if;
	 
 --   shifted_instruction := ("111111" & instruction_out(23 downto 0) & "00") when instruction_out(23) = '1' else ("000000" & instruction_out(23 downto 0) & "00");
    pc_offset := std_logic_vector(signed(shifted_instruction) + ("00000000000000000000000000000100") + signed(pc4));
    
     pc_offset_sig <= pc_offset;
	 if Psrc = '1' then pc_datain <= pc_offset;
	 else pc_datain <= pc4;
	 end if;
	 
     pc4_sig <= pc4;
--    pc_datain <= pc_offset when Psrc = '1' else pc4;
    
    
    read_add1_reg <= instruction_out(19 downto 16);
	 
	 if Rsrc = '0' then read_add2_reg <= instruction_out(3 downto 0); 
	 else read_add2_reg <= instruction_out(15 downto 12);
	 end if;
	 
--    read_add2_reg <= instruction_out(3 downto 0) when Rsrc = '0' else instruction_out(15 downto 12);
    
    write_add_reg <= instruction_out(15 downto 12);
    end process;
    
  --Check this once!
    
    PC: entity work.program_counter port map (
    
    	clk => clk,
        data_in => pc_datain,
        data_out => pc_dataout
    
    );
    
    op2 <= data_out2_reg when Asrc = '0' else ("00000000000000000000" & instruction_out(11 downto 0));
    op <= add when instr_class = DT and DT_offset_sign = plus else 
			  sub when instr_class = DT and DT_offset_sign = minus else
			  operation;
    
     flags <= set_flags;
    
    ALU: entity work.ALU port map (
    	
        op1 => data_out1_reg,
        op2 => op2,
        opcode => op,
        ci => set_flags(1),
        co => alu_carry_out,
        S => alu_res        
    );
    
    data_inp_reg <= data_memory_out when M2R = '1' else alu_res;

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
    
    DM: entity work.data_memory port map (
    	address => alu_res,
        data_in => data_out2_reg,
        clock => clk,
        write_enables => MW,
        data_out => data_memory_out
    	
    );
    
--     if (instr_class = DP) then 
--     	dp <= '1';
--     else 
--     	dp <= '0';
--     end if;
    
    dp <= '0' when instr_class = DT or instr_class = MUL or instr_class = BRN or instr_class = none else '1';
    
    FS: entity work.flags port map (
    	clock => clk,
    	A_in => data_out1_reg,
        B_in => op2,
        result => alu_res,
        s_bit => Fset,
        carry_out => alu_carry_out,
        is_dp => dp,
        dp_subclass => DP_subclass,
        
        flags_out => set_flags
 
    );
    
	 instruction <= instruction_out;
    
    PM: entity work.program_memory port map (
    	read_address => pc_dataout,
        data_out => instruction_out
    
    );

	
-- 	DE: entity work.Decoder port map (
--     	instruction => instruction_out,
--         instr_class => instr_class,
--         operation => operation,
--         DP_subclass => DP_subclass,
--         DP_operand_src => DP_operand_src,
--         load_store => load_store,
--         DT_offset_sign => DT_offset_sign
    	
--     );
    
    

	
end datapath_arch;
