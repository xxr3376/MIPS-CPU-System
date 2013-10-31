----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    20:37:46 11/05/2012 
-- Design Name: 
-- Module Name:    Controller - Controller_Behavioral 
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

entity Controller is
	Port ( InstructionInput : in  STD_LOGIC_VECTOR (15 downto 0);
		   RegDst : out  STD_LOGIC_VECTOR(3 downto 0);
		   ALUOp : out  STD_LOGIC_VECTOR (2 downto 0);
		   ALUSrc1 : out  STD_LOGIC;
		   ALUSrc2 : out  STD_LOGIC;
		   Src1 : out STD_LOGIC_VECTOR (3 downto 0);
		   Src2 : out STD_LOGIC_VECTOR (3 downto 0);
		   RegTWrite : out  STD_LOGIC;
		   TType : out STD_LOGIC;
		   MemRead : out  STD_LOGIC;
		   MemWrite : out  STD_LOGIC;
		   RegWrite : out  STD_LOGIC;
		   MemtoReg : out  STD_LOGIC;
		   RegtoMem : out STD_LOGIC --选择是Reg A / B中的数据写入内存
	   );
end Controller;

architecture Controller_Behavioral of Controller is

begin

	process(InstructionInput)
	begin
		case InstructionInput(15 downto 11) is
			when "00000" =>	--ADDSP3
				RegDst <= "0" & InstructionInput(10 downto 8);
				Src1 <= "1001";	--SP
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "00001" => --NOP
				RegDst <= "1000"; --ZERO
				Src1 <= "1000"; --ZERO
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "00010" | "00100" | "00101"  =>
						-- B | BEQZ | BNEZ
				RegDst <= "1000"; --ZERO
				Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "00110" =>	--SLL & SRA
				RegDst <= "0" & InstructionInput(10 downto 8);
				Src1 <= "0" & InstructionInput(7 downto 5); --5-7
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				case InstructionInput(1 downto 0) is
					when "11" =>
						ALUOp <= "101";
					when others =>
						ALUOp <= "100";
				end case;
				TType <= '0';
				RegTWrite <= '0';
			when "01000" =>	--ADDIU3
				RegDst <= "0" & InstructionInput(7 downto 5);
				Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "01001" =>	--ADDIU
				RegDst <= "0" & InstructionInput(10 downto 8);
				Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "01010" =>	--SLTI
				RegDst <= "1000"; --ZERO
				Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "001";
				TType <= '0';
				RegTWrite <= '1';
			when "01100" =>	--ADDSP & BTEQZ & BTNEZ & MTSP
				RegDst <= "1001"; --SP
				--Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				--ALUSrc2 <= '1';	--分情况	
				MemRead <= '0';
				MemWrite <= '0';
				--RegWrite <= '0';	--分情况	
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
				case InstructionInput(10 downto 8) is
					when "011" => --ADDSP
						ALUSrc2 <= '1';
						RegWrite <= '1';
						Src1 <= "1001"; --SP
					when "100" => --MTSP
						ALUSrc2 <= '0';
						RegWrite <= '1';
						Src1 <= "0" & InstructionInput(7 downto 5);
					when others =>
						ALUSrc2 <= '0';
						RegWrite <= '0';
						Src1 <= "1000"; --ZERO
				end case;
			when "01101" =>	--LI
				RegDst <= "0" & InstructionInput(10 downto 8); --8-10
				Src1 <= "1000"; --ZERO
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '1'; --立即数
				ALUSrc2 <= '0';	--0
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "10010" =>	--LW_SP
				RegDst <= "0" & InstructionInput(10 downto 8); --8-10
				Src1 <= "1001"; --SP
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0'; 
				ALUSrc2 <= '1';	--立即数
				MemRead <= '1';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '1';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "10011" =>	--LW
				RegDst <= "0" & InstructionInput(7 downto 5); --5-7
				Src1 <= "0" & instructioninput(10 downto 8); --8-10
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0'; 
				ALUSrc2 <= '1';	--立即数
				MemRead <= '1';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '1';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "11010" =>	--SW_SP
				RegDst <= "1000"; --ZERO
				Src1 <= "1001"; --SP
				Src2 <= "0" & instructioninput(10 downto 8); --8-10
				ALUSrc1 <= '0'; 
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '1';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '1';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "11011" =>	--SW
				RegDst <= "1000"; --ZERO
				Src1 <= "0" & instructioninput(10 downto 8); --8-10
				Src2 <= "0" & instructioninput(7 downto 5); --5-7
				ALUSrc1 <= '0'; 
				ALUSrc2 <= '1';	--立即数
				MemRead <= '0';
				MemWrite <= '1';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '1';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
			when "11100" =>	--ADDU & SUBU
				RegDst <= "0" & InstructionInput(4 downto 2); --2-4
				Src1 <= "0" & InstructionInput(10 downto 8); --8-10
				Src2 <= "0" & InstructionInput(7 downto 5); --5-7
				ALUSrc1 <= '0'; --立即数
				ALUSrc2 <= '0';	--0
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				case InstructionInput(1 downto 0) is
					when "01" =>
						ALUOp <= "000";
					when others =>
						ALUOp <= "001";
				end case;
				TType <= '0';
				RegTWrite <= '0';
			when "11101" => --AND & CMP & JR & MFPC & OR & SLT & SRAV
				--RegDst <= "1000"; --ZERO
				--Src1 <= "1000";	--ZERO
				--Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				--RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '0';
				--ALUOp <= "000";
				--TType <= '0';
				--RegTWrite <= '0';
				case InstructionInput(4 downto 0) is
					when "00000" => --MFPC & JR
						case InstructionInput(7 downto 5) is
							when "010" => --MFPC
								RegDst <= "0" & InstructionInput(10 downto 8); --8-10
								Src1 <= "1010";	--PC
								Src2 <= "1000";	--ZERO
								RegWrite <= '1';
								ALUOp <= "000";
								TType <= '0';
								RegTWrite <= '0';
							when others => --JR
								RegDst <= "1000"; --ZERO
								Src1 <= "0" & InstructionInput(10 downto 8); --8-10
								Src2 <= "1000";	--ZERO
								RegWrite <= '0';
								ALUOp <= "000";
								TType <= '0';
								RegTWrite <= '0';
						end case;
					when "00010" => --SLT
						RegDst <= "1000"; --ZERO
						Src1 <= "0" & InstructionInput(10 downto 8); --8-10
						Src2 <= "0" & InstructionInput(7 downto 5); --5-7
						RegWrite <= '0';
						ALUOp <= "001";
						TType <= '0';
						RegTWrite <= '1';
					when "00111" => --SRAV
						RegDst <= "0" & InstructionInput(7 downto 5); --5-7
						Src1 <= "0" & InstructionInput(7 downto 5); --5-7
						Src2 <= "0" & InstructionInput(10 downto 8); --8-10
						RegWrite <= '1';
						ALUOp <= "101";
						TType <= '0';
						RegTWrite <= '0';
					when "01010" => --CMP
						RegDst <= "1000"; --ZERO
						Src1 <= "0" & InstructionInput(10 downto 8); --8-10
						Src2 <= "0" & InstructionInput(7 downto 5); --5-7
						RegWrite <= '0';
						ALUOp <= "001";
						TType <= '1';
						RegTWrite <= '1';
					when "01100" => --AND
						RegDst <= "0" & InstructionInput(10 downto 8); --8-10
						Src1 <= "0" & InstructionInput(10 downto 8); --8-10
						Src2 <= "0" & InstructionInput(7 downto 5); --5-7
						RegWrite <= '1';
						ALUOp <= "010";
						TType <= '0';
						RegTWrite <= '0';
					when "01101" => --OR
						RegDst <= "0" & InstructionInput(10 downto 8); --8-10
						Src1 <= "0" & InstructionInput(10 downto 8); --8-10
						Src2 <= "0" & InstructionInput(7 downto 5); --5-7
						RegWrite <= '1';
						ALUOp <= "011";
						TType <= '0';
						RegTWrite <= '0';
					when others =>
						RegDst <= "1000"; --ZERO
						Src1 <= "1000";	--ZERO
						Src2 <= "1000";	--ZERO
						RegWrite <= '0';
						ALUOp <= "000";
						TType <= '0';
						RegTWrite <= '0';
				end case;
			when "11110" =>	--MFIH & MTIH
				--RegDst <= "1000"; --ZERO
				--Src1 <= "0" & instructioninput(10 downto 8); --8-10
				Src2 <= "1000"; --ZERO
				ALUSrc1 <= '0'; 
				ALUSrc2 <= '0';	
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
				case InstructionInput(4 downto 0) is
					when "00000" => --MFIH
						Src1 <= "1111";
						RegDst <= "0" & instructioninput(10 downto 8); --8-10
					when "00001" => --MTIH
						Src1 <= "0" & instructioninput(10 downto 8); --8-10
						RegDst <= "1111";
					when others =>
						Src1 <= "1000"; --ZERO
						RegDst <= "1000";
				end case;
			when others =>
				RegDst <= "1000"; --ZERO
				Src1 <= "1000";	--ZERO
				Src2 <= "1000";	--ZERO
				ALUSrc1 <= '0';
				ALUSrc2 <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '0';
				MemtoReg <= '0';
				RegtoMem <= '0';
				ALUOp <= "000";
				TType <= '0';
				RegTWrite <= '0';
		end case;
	end process;
end Controller_Behavioral;

