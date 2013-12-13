
-- VHDL Instantiation Created from source file IDEX.vhd -- 13:54:03 11/06/2012
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT IDEX
	PORT(
		PCInput : IN std_logic;
		RegDstInput : IN std_logic;
		ALUOPInput : IN std_logic_vector(1 downto 0);
		ALUSrcInput : IN std_logic;
		BranchInput : IN std_logic;
		MemReadInput : IN std_logic;
		MemWriteInput : IN std_logic;
		RegWriteInput : IN std_logic;
		MemtoRegInput : IN std_logic;
		RegAInput : IN std_logic_vector(15 downto 0);
		RegBInput : IN std_logic_vector(15 downto 0);
		Instruction57Input : IN std_logic_vector(2 downto 0);
		Instruction810Input : IN std_logic_vector(2 downto 0);
		ExtendedAddressInput : IN std_logic_vector(15 downto 0);
		RegDstOutput : IN std_logic;
		clock : IN std_logic;          
		PCOutput : OUT std_logic;
		ALUOPOutput : OUT std_logic_vector(1 downto 0);
		ALUSrcOutput : OUT std_logic;
		BranchOutput : OUT std_logic;
		MemReadOutput : OUT std_logic;
		MemWriteOutput : OUT std_logic;
		RegWriteOutput : OUT std_logic;
		MemtoRegOutput : OUT std_logic;
		RegAOutput : OUT std_logic_vector(15 downto 0);
		RegBOutput : OUT std_logic_vector(15 downto 0);
		Instruction57Output : OUT std_logic_vector(2 downto 0);
		Instruction810Output : OUT std_logic_vector(2 downto 0);
		ExtendedAddressOutput : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;

	Inst_IDEX: IDEX PORT MAP(
		PCInput => ,
		RegDstInput => ,
		ALUOPInput => ,
		ALUSrcInput => ,
		BranchInput => ,
		MemReadInput => ,
		MemWriteInput => ,
		RegWriteInput => ,
		MemtoRegInput => ,
		RegAInput => ,
		RegBInput => ,
		Instruction57Input => ,
		Instruction810Input => ,
		ExtendedAddressInput => ,
		PCOutput => ,
		RegDstOutput => ,
		ALUOPOutput => ,
		ALUSrcOutput => ,
		BranchOutput => ,
		MemReadOutput => ,
		MemWriteOutput => ,
		RegWriteOutput => ,
		MemtoRegOutput => ,
		RegAOutput => ,
		RegBOutput => ,
		Instruction57Output => ,
		Instruction810Output => ,
		ExtendedAddressOutput => ,
		clock => 
	);


