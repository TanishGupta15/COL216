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
 signal    Asrc: std_logic;
 signal    Fset: std_logic;
 signal    MW: std_logic_vector(3 downto 0);
 signal    M2R: std_logic;
 signal    Rsrc: std_logic;
 signal    Psrc: std_logic;
        
 signal    instr_class: instr_class_type;
 signal    operation: optype;
 signal    DP_subclass: DP_subclass_type;
 signal    DP_operand_src: DP_operand_src_type;
 signal    load_store: load_store_type;
 signal    DT_offset_sign: DT_offset_sign_type;
        
 signal    flags: std_logic_vector(3 downto 0);
 signal    instruction: std_logic_vector(31 downto 0);

	begin
        
    	DP: entity work.datapath port map (
        
        	clk => clk,
            write_enable_register => write_enable_register,
            Asrc => Asrc,
            Fset => Fset,
            MW => MW,
            M2R => M2R,
            Rsrc => Rsrc,
            Psrc => Psrc,
            instr_class => instr_class,
            operation => operation,
            DP_subclass => DP_subclass,
            DP_operand_src => DP_operand_src,
            load_store => load_store,
            DT_offset_sign => DT_offset_sign,
            flags => flags,
            instruction => instruction
        
        );
        
        CT: entity work.controller port map (
        	
            clk => clk,
        
        	flags => flags,
        	Instr => instruction,
        
        
        	RW => write_enable_register,
        	Asrc => Asrc,
            Fset => Fset,
            MW => MW,
            M2R => M2R,
            Rsrc => Rsrc,
            Psrc => Psrc,
            instr_class => instr_class,
            operation => operation,
            DP_subclass => DP_subclass,
            DP_operand_src => DP_operand_src,
            load_store => load_store,
            DT_offset_sign => DT_offset_sign
        
        
        );
        
end processor_arch;