library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity controller is 

	port (
    	clk: in std_logic;
        
        flags: in std_logic_vector(3 downto 0);
        Instr: in std_logic_vector(31 downto 0);
        
        
        RW: out std_logic; --Write enable for register
        Asrc: out std_logic;
        Fset: out std_logic;
        MW: out std_logic_vector(3 downto 0);
        M2R: out std_logic;
        Rsrc: out std_logic;
        Psrc: out std_logic;
        
        instr_class: out instr_class_type;
        operation: out optype;
        DP_subclass: out DP_subclass_type;
        DP_operand_src: out DP_operand_src_type;
        load_store: out load_store_type;
        DT_offset_sign: out DT_offset_sign_type
        
        );
end controller;

architecture controller_arch of controller is
-- Instruction fields
signal F, OP, Cond : std_logic_vector (1 downto 0);
signal Ubit, Lbit : std_logic;
signal Imm : std_logic_vector (7 downto 0);
signal Offset : std_logic_vector (11 downto 0);
signal S_offset : std_logic_vector (23 downto 0);
signal Rd, Rn, Rm : integer range 0 to 15;
signal in_class: instr_class_type;
signal op2_src: DP_operand_src_type;
signal instr_cond: std_logic_vector(3 downto 0);
signal condition_chk_res: std_logic;

	begin
	-- concurrent assignments for extracting instruction fields
-- 	F <= Instr (27 downto 26);
 	OP <= Instr (24 downto 23);
-- 	Cond <= Instr (29 downto 28);
 	Ubit <= Instr (23);
 	Lbit <= Instr (20);
-- 	Imm <= Instr (7 downto 0);
-- 	Offset <= Instr (11 downto 0);
-- 	S_offset <= Instr (23 downto 0);

    
    DE: entity work.Decoder port map (
    	instruction => Instr,
        instr_class => in_class,
        operation => operation,
        DP_subclass => DP_subclass,
        DP_operand_src => op2_src,
        load_store => load_store,
        DT_offset_sign => DT_offset_sign
    	
    );
    
    instr_class <= in_class;
    DP_operand_src <= op2_src;
	 
	 instr_cond <= Instr(31 downto 28);
	 
	 CC: entity work.condition_chk port map (
		instr_cond => instr_cond,
		NZCV => flags,
		res => condition_chk_res
	 
	 );
     
    
    process(flags, Instr, OP, op2_src, Lbit, condition_chk_res, in_class) is
    begin
    case in_class is 
		--DP instruction
        when DP =>
        	Rsrc <= '0';
            if OP = "10" then RW <= '0';
            else RW <= '1';
            end if;
            if OP = "00" then Fset <= '0'; 
            elsif OP = "01" then Fset <= '0';
            elsif OP = "10" then Fset <= '1';
            else Fset <= '0';
            end if;
            if op2_src = reg then Asrc <= '0';
            else Asrc <= '1';
            end if;
--             Asrc <= '0' when op2_src = reg else '1';
            MW <= "0000";
            M2R <= '0';
            Psrc <= '0';
        --DT instructions
        when DT =>
        	 --Lbit = 0 means store and 1 means load
            	Rsrc <= '1';
                Fset <= '0';
                Asrc <= '1';
                if Lbit = '1' then 
                	RW <= '1';
                    MW <= "0000";
                else 
                	RW <= '0';
                    MW <= "1111";
                end if;
--                 RW <= '1' when Lbit = '0' else '0';
--                 MW <= "1111" when Lbit = '0' else "0000";
                M2R <= '1';
                Psrc <= '0';
                
        when BRN =>
        		Rsrc <= '0';
                Fset <= '0';
                Asrc <= '0';
                RW <= '0';
                MW <= "0000";
                M2R <= '0';
					 
					 if (condition_chk_res = '1') then Psrc <= '1';
					 else Psrc <= '0';
					 end if;
                --Psrc <= '1;
            
        when others =>
        		Rsrc <= '0';
                Fset <= '0';
                Asrc <= '0';
                RW <= '0';
                MW <= "0000";
                M2R <= '0';
                Psrc <= '0';
   end case;
   end process;
   
end controller_arch;        
                
            	