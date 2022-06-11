library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.MyTypes.all;

entity controller is 

	port (
    	clk: in std_logic;
       
        Instr: in std_logic_vector(31 downto 0);
        flags: in std_logic_vector(3 downto 0);
        state: in integer;
        
        RW: out std_logic; --Write enable for register
        Asrc1: out std_logic;
        Fset: out std_logic;
        M2R: out std_logic_vector(1 downto 0);
        Rsrc: out std_logic_vector(1 downto 0);
        PW: out std_logic;
        IorD: out std_logic_vector(1 downto 0);
        MR: out std_logic_vector(3 downto 0);
        IW: out std_logic;
        DW: out std_logic;
        AW: out std_logic;
        BW: out std_logic;
        CW: out std_logic;
        DWrite: out std_logic;
        Asrc2: out std_logic_vector(1 downto 0);
        ReW: out std_logic;
        CI: out std_logic; --will be 1 if ALU carry needs to be 1, 0 if ALU carry needs to be set_flags(1);
        R1src: out std_logic_vector(1 downto 0);
        SI: out std_logic;
        RWsrc: out std_logic;
        mem_write: out std_logic;
        MULW: out std_logic;
        accHighWrite: out std_logic;
        ALUorMULT: out std_logic;
		  
        instr_class: out instr_class_type;
        operation: out optype;
        DP_subclass: out DP_subclass_type;
        DP_operand_src: out DP_operand_src_type;
        shifter_src: out DP_operand_src_type;
        load_store: out load_store_type;
        DT_offset_sign: out DT_offset_sign_type;
        is_signed: out std_logic;
        DT_halfword: out std_logic;
        acc: out std_logic
        );
end controller;

architecture controller_arch of controller is
-- Instruction fields
signal F, OP, Cond : std_logic_vector (1 downto 0);
signal Ubit, Lbit : std_logic;
-- signal Imm : std_logic_vector (7 downto 0);
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
        DT_offset_sign => DT_offset_sign,
    	shifter_src => shifter_src,
        DT_halfword => DT_halfword,
		  is_signed => is_signed,
		  acc => acc
    );
    
    instr_class <= in_class;
    DP_operand_src <= op2_src; 
	instr_cond <= Instr(31 downto 28);
	 
	 CC: entity work.condition_chk port map (
		instr_cond => instr_cond,
		NZCV => flags,
		res => condition_chk_res
	 
	 );
     
--      	Psrc <= condition_chk_res;
     
        PW <= 	'1' when state = 1 else
        		'0' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '1' when (state = 9 and condition_chk_res = '1') else
                '0';
					 
		 MULW <= '1' when state = 13 else
					'0';
                    
       ALUorMULT <= '1' when state = 3 else--is '1' when ALU
       				'0'; 
	
           
       IorD <= 	"00" when state = 1 else
        		"01" when state = 2 else
                "01" when state = 3 else
                "01" when state = 4 else
                "01" when state = 5 else
                "01" when state = 6 and Instr(24) = '1' else
				"10" when state = 6 else
				"01" when state = 7 and Instr(24) = '1' else
				"10" when state = 7 else
				"10" when state = 8 and Instr(24) = '0' else
                "01" when state = 8 else
                "01" when state = 9 else
                "01";
                
       DWrite <= '1' when state = 11 else
       			 '0';	
                
       MR <= 	"1111" when state = 1 else
        		"1111" when state = 2 else
                "1111" when state = 3 else
                "1111" when state = 4 else
                "1111" when state = 5 else
                "1111" when state = 6 else
                "1111" when state = 7 else
                "1111" when state = 8 else
                "1111" when state = 9 else
                "1111";
       accHighWrite <= '1' when state = 12 else 
       				  '0';
                
--        MW <= 	"0000" when state = 1 else
--         		"0000" when state = 2 else
--                 "0000" when state = 3 else
--                 "0000" when state = 4 else
--                 "0000" when state = 5 else
--                 "1111" when state = 6 else
--                 "0000" when state = 7 else
--                 "0000" when state = 8 else
--                 "0000" when state = 9 else
--                 "0000";
                
       mem_write <= '1' when state = 6 else
       				'0';
                
       IW <= 	'1' when state = 1 else
        		'0' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
                '0';
                
                
       DW <= 	'0' when state = 1 else
        		'0' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '1' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
                '0';
                
                
       Rsrc <=  "00" when state = 1 else
				"00" when state = 2 else
                "00" when state = 3 else
                "00" when state = 4 else
                "01" when state = 5 else
                "00" when state = 6 else
                "00" when state = 7 else
                "00" when state = 8 else
                "00" when state = 9 else
                "10" when state = 12 else
                "00";
                
                
       R1src <= "01" when state = 10 else
					 "10" when state = 12 else
					 "00";
                
       RWsrc <= '1' when ((state = 6 or state = 7) and Instr(21) = '1') else
					 '1' when ((state = 6 or state = 7) and Instr(24) = '0') else
					 '1' when (state = 14) else
                '0';
                
                
      SI 	<=  '0' when op2_src = imm and in_class = DP else --SI is opposite for DT instructions than DP instructions
      			'1' when op2_src = reg and in_class = DP else
                '1' when op2_src = imm else
      			'0';
                
                --SI = '1' implies that the input(for the shifter) is taken from register, Remember that the 26th bit is opposite for DP and DT instructions.
                
                
       M2R <= 	"00" when state = 1 else
        		"00" when state = 2 else
                "00" when state = 3 else
                "00" when state = 4 else
                "00" when state = 5 else
                "00" when state = 6 else
                "00" when state = 7 else
                "01" when state = 8 else
                "00" when state = 9 else
                "10" when state = 14 and Instr(23) = '0' else
                "11" when state = 14 else
                "10" when state = 15 else
                "00";
                
                
   	   RW <= 	'0' when state = 1 else
        		'0' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 and OP = "10" else
                '1' when state = 4 else
                '0' when state = 5 else
                '1' when state = 6 and Instr(21) = '1' else
                '1' when state = 6 and Instr(24) = '0' else
                '0' when state = 6 else
                '1' when state = 7 and Instr(21) = '1' else
                '1' when state = 7 and Instr(24) = '0' else
                '0' when state = 7 else
                '1' when state = 8 else
                '0' when state = 9 else
					 '1' when state = 14 else
					 '1' when (state = 15 and Instr(23) = '1') else
                '0';
                
                
      AW <= 	'0' when state = 1 else
        		'1' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
					 '1' when state = 12 else
                '0';
                
                
      BW <= 	'0' when state = 1 else
        		'1' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '1' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
                '0';
                
      CW 	<= 	'1' when state = 10 else
      			'0';
                
                 
                
                
      Asrc1 <= 	'0' when state = 1 else
					 '1' when state = 2 else
                '1' when state = 3 else
                '1' when state = 4 else
                '1' when state = 5 else
                '1' when state = 6 else
                '1' when state = 7 else
                '1' when state = 8 else
                '0' when state = 9 else
                '1';
                
                
     Fset <= 	'0' when state = 1 else
        		'0' when state = 2 else
                '1' when state = 3 and OP = "10" else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
                '0';
                
                
     ReW <= 	'0' when state = 1 else
        		'0' when state = 2 else
                '1' when state = 3 else
                '0' when state = 4 else
                '1' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '0' when state = 9 else
                '0';
                
                
    Asrc2 <=	"01" when state = 1 else
        		"00" when state = 2 else
                "00" when state = 3 else
                "00" when state = 4 else
                "00" when state = 5 and op2_src = imm else --DT instructions have opposite bit set
                "00" when state = 5 and Instr(22) = '0' else
                "10" when state = 5 else
                "00" when state = 6 else
                "00" when state = 7 else
                "00" when state = 8 else 
                "11" when state = 9 else
                "00";
                
                
     	CI <= 	'1' when state = 1 else
        		'0' when state = 2 else
                '0' when state = 3 else
                '0' when state = 4 else
                '0' when state = 5 else
                '0' when state = 6 else
                '0' when state = 7 else
                '0' when state = 8 else
                '1' when state = 9 else
                '0';
       
        
      
    
--     process(flags, Instr, OP, op2_src, Lbit, condition_chk_res, in_class) is
--     begin
--     case in_class is 
-- 		--DP instruction
--         when DP =>
--         	Rsrc <= '0';
--             if OP = "10" then RW <= '0';
--             else RW <= '1';
--             end if;
--             if OP = "00" then Fset <= '0'; 
--             elsif OP = "01" then Fset <= '0';
--             elsif OP = "10" then Fset <= '1';
--             else Fset <= '0';
--             end if;
--             if op2_src = reg then Asrc <= '0';
--             else Asrc <= '1';
--             end if;
-- --             Asrc <= '0' when op2_src = reg else '1';
--             MW <= "0000";
--             M2R <= '0';
--             Psrc <= '0';
--         --DT instructions
--         when DT =>
--         	 --Lbit = 0 means store and 1 means load
--             	Rsrc <= '1';
--                 Fset <= '0';
--                 Asrc <= '1';
--                 if Lbit = '1' then 
--                 	RW <= '1';
--                     MW <= "0000";
--                 else 
--                 	RW <= '0';
--                     MW <= "1111";
--                 end if;
-- --                 RW <= '1' when Lbit = '0' else '0';
-- --                 MW <= "1111" when Lbit = '0' else "0000";
--                 M2R <= '1';
--                 Psrc <= '0';
                
--         when BRN =>
--         		Rsrc <= '0';
--                 Fset <= '0';
--                 Asrc <= '0';
--                 RW <= '0';
--                 MW <= "0000";
--                 M2R <= '0';
					 
-- 					 if (condition_chk_res = '1') then Psrc <= '1';
-- 					 else Psrc <= '0';
-- 					 end if;
--                 --Psrc <= '1;
            
--         when others =>
--         		Rsrc <= '0';
--                 Fset <= '0';
--                 Asrc <= '0';
--                 RW <= '0';
--                 MW <= "0000";
--                 M2R <= '0';
--                 Psrc <= '0';
--    end case;
--    end process;
   
end controller_arch;        
                
            	