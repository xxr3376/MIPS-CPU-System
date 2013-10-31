----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    20:58:57 11/05/2012 
-- Design Name: 
-- Module Name:    IDEX - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDEX is
	Port ( RegTWriteInput : in  STD_LOGIC;
		   RegDstInput : in  STD_LOGIC_VECTOR(3 downto 0);
		   ALUOPInput : in  STD_LOGIC_VECTOR (2 downto 0);
		   ALUSrc1Input : in  STD_LOGIC;
		   ALUSrc2Input : in  STD_LOGIC;
		   TTypeInput : in  STD_LOGIC;
		   MemReadInput : in  STD_LOGIC;
		   MemWriteInput : in  STD_LOGIC;
		   RegWriteInput : in  STD_LOGIC;
		   MemtoRegInput : in  STD_LOGIC;
		   RegAInput  :  in STD_LOGIC_VECTOR (15 downto 0);
		   RegBInput  :  in STD_LOGIC_VECTOR (15 downto 0);
		   Src1Input : in STD_LOGIC_VECTOR (3 downto 0);
		   Src2Input : in STD_LOGIC_VECTOR (3 downto 0);
		   ExtendedAddressInput  :  in  STD_LOGIC_VECTOR (15 downto 0);
		   RegtoMemInput : in STD_LOGIC;

		   RegTWriteOutput: out  STD_LOGIC;
		   RegDstOutput : out  STD_LOGIC_VECTOR (3 downto 0);
		   ALUOPOutput : out  STD_LOGIC_VECTOR (2 downto 0);
		   ALUSrc1Output : out  STD_LOGIC;
		   ALUSrc2Output : out  STD_LOGIC;
		   TTypeOutput : out  STD_LOGIC;
		   MemReadOutput : out  STD_LOGIC;
		   MemWriteOutput : out  STD_LOGIC;
		   RegWriteOutput : out  STD_LOGIC;
		   MemtoRegOutput : out  STD_LOGIC;
		   RegAOutput  :  out STD_LOGIC_VECTOR (15 downto 0);
		   RegBOutput  :  out STD_LOGIC_VECTOR (15 downto 0);
		   Src1Output : out STD_LOGIC_VECTOR (3 downto 0);
		   Src2Output : out STD_LOGIC_VECTOR (3 downto 0);
		   ExtendedAddressOutput  :  out  STD_LOGIC_VECTOR (15 downto 0);
		   RegtoMemOutput : out STD_LOGIC;
		   clock  :  in STD_LOGIC;
		   rst : in STD_LOGIC
	   );
end IDEX;

architecture Behavioral of IDEX is
	signal RegTWrite: STD_LOGIC;
	signal RegDst	: STD_LOGIC_VECTOR(3 downto 0);
	signal ALUOP	: STD_LOGIC_VECTOR (2 downto 0);
	signal ALUSrc1	: STD_LOGIC;
	signal ALUSrc2	: STD_LOGIC;
	signal TType	: STD_LOGIC;
	signal MemRead	: STD_LOGIC;
	signal MemWrite	: STD_LOGIC;
	signal RegWrite	: STD_LOGIC;
	signal MemtoReg	: STD_LOGIC;
	signal RegA		: STD_LOGIC_VECTOR (15 downto 0);
	signal RegB		: STD_LOGIC_VECTOR (15 downto 0);
	signal Src1		: STD_LOGIC_VECTOR (3 downto 0);
	signal Src2		: STD_LOGIC_VECTOR (3 downto 0);
	signal ExtendedAddress  : STD_LOGIC_VECTOR (15 downto 0);
	signal RegtoMem : STD_LOGIC;
begin
	RegTWriteOutput		<= RegTWrite;
	RegDstOutput 		<= RegDst;
	ALUOPOutput 		<= ALUOP;
	ALUSrc1Output 		<= ALUSrc1;
	ALUSrc2Output 		<= ALUSrc2;
	TTypeOutput 		<= TType;
	MemReadOutput 		<= MemRead;
	MemWriteOutput 		<= MemWrite;
	RegWriteOutput 		<= RegWrite;
	MemtoRegOutput 		<= MemtoReg;
	RegAOutput  		<= RegA;
	RegBOutput  		<= RegB;
	Src1Output			<= Src1;
	Src2Output			<= Src2;
	ExtendedAddressOutput <= ExtendedAddress;
	RegtoMemOutput 		<= RegtoMem;
	process(rst, clock)
	begin
		if rst = '0' then
			RegTWrite <= '0';
			RegDst	 <= "0000";
			ALUOP	 <= "000";
			ALUSrc1	 <= '0';
			ALUSrc2	 <= '0';
			TType	 <= '0';
			MemRead	 <= '0';
			MemWrite	 <= '0';
			RegWrite	 <= '0';
			MemtoReg	 <= '0';
			RegA		 <= "0000000000000000";
			RegB		 <= "0000000000000000";
			Src1		 <= "0000";
			Src2		 <= "0000";
			ExtendedAddress   <= "0000000000000000";
			RegtoMem  <= '0';
		elsif clock'event and clock='1' then
			RegTWrite<=RegTWriteInput ;
			RegDst	 <= RegDstInput ;
			ALUOP	 <= ALUOPInput ;
			ALUSrc1	 <= ALUSrc1Input ;
			ALUSrc2	 <= ALUSrc2Input ;
			TType	 <= TTypeInput ;
			MemRead	 <= MemReadInput ;
			MemWrite <=	MemWriteInput;
			RegWrite <=	RegWriteInput;
			MemtoReg <=	MemtoRegInput;
			RegA	 <=	RegAInput ;
			RegB	 <=	RegBInput ;
			Src1	 <=	Src1Input ;
			Src2	 <=	Src2Input ;
			ExtendedAddress <= ExtendedAddressInput;
			RegtoMem  <=RegtoMemInput ;
		end if;
end process;
end Behavioral;

