library IEEE;
use work.MyTypes.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity processor is

	port (
    
    	clk: in std_logic
    
    );
    
end processor;


architecture processor_arch of processor is 


        --Control signals
        
 signal    write_enable_register: std_logic;
 signal    Asrc1: std_logic;
 signal    Fset: std_logic;
 signal    MW: std_logic_vector(3 downto 0);
 signal    M2R: std_logic;
 signal    Rsrc: std_logic;
 
 signal 	PW: std_logic;
 signal 	IorD: std_logic;
 signal 	MR: std_logic_vector(3 downto 0);
 signal 	IW: std_logic;
 signal		DW: std_logic;
 signal		AW: std_logic;
 signal 	BW: std_logic;
 signal		Asrc2: std_logic_vector(1 downto 0);
 signal		ReW: std_logic;
 signal		CI: std_logic;
 signal 	SI: std_logic;
 signal 	CW: std_logic;
 signal 	DWrite: std_logic;
 signal 	R1src: std_logic;
 signal 	COS: std_logic;
 
 signal    instr_class: instr_class_type;
 signal    operation: optype;
 signal    DP_subclass: DP_subclass_type;
 signal    DP_operand_src: DP_operand_src_type;
 signal    shifter_src: DP_operand_src_type;
 signal    load_store: load_store_type;
 signal    DT_offset_sign: DT_offset_sign_type;
        
 signal    flags: std_logic_vector(3 downto 0);
 signal    instruction: std_logic_vector(31 downto 0);


signal 		state: integer;

	begin
        
    	DP: entity work.datapath port map (
        
        	clk => clk,
            write_enable_register => write_enable_register,
            Asrc1 => Asrc1,
            Fset => Fset,
            MW => MW,
            M2R => M2R,
            Rsrc => Rsrc,
            
            PW => PW,
        	IorD => IorD,
        	MR=> MR,
        	IW=> IW,
        	DW=> DW,
        	AW=> AW,
        	BW=> BW,
        	Asrc2=> Asrc2,
        	ReW=> ReW,
        	CI=> CI,
            SI=> SI,
            CW=> CW,
            DWrite=> DWrite,
            R1src => R1src,
				COS => COS,
            
            instr_class => instr_class,
            operation => operation,
            DP_subclass => DP_subclass,
            DP_operand_src => DP_operand_src,
            load_store => load_store,
            DT_offset_sign => DT_offset_sign,
            shifter_src => shifter_src,
            flags => flags,
            instruction => instruction
        
        );
        
        CT: entity work.controller port map (
        	
            clk => clk,
        
        	flags => flags,
        	Instr => instruction,
        	state => state,
        
        	RW => write_enable_register,
        	Asrc1 => Asrc1,
            Fset => Fset,
            MW => MW,
            M2R => M2R,
            Rsrc => Rsrc,
            
            PW => PW,
        	IorD => IorD,
        	MR=> MR,
        	IW=> IW,
        	DW=> DW,
        	AW=> AW,
        	BW=> BW,
        	Asrc2=> Asrc2,
        	ReW=> ReW,
        	CI=> CI,
            CW => CW,
            DWrite=> DWrite,
            SI => SI,
            R1src => R1src,
				COS => COS,
            
            instr_class => instr_class,
            operation => operation,
            DP_subclass => DP_subclass,
            DP_operand_src => DP_operand_src,
            shifter_src => shifter_src,
            load_store => load_store,
            DT_offset_sign => DT_offset_sign
        
        
        );
        
     FSM: entity work.FSM port map(
     
     		clk => clk,
            
     		instr_class => instr_class,
            operation => operation,
            DP_subclass => DP_subclass,
            DP_operand_src => DP_operand_src,
            load_store => load_store,
            DT_offset_sign => DT_offset_sign,
            
            output_state => state
     
     );
        
end processor_arch;