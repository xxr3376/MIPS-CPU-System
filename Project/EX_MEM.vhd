----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    15:45:27 11/06/2012 
-- Design Name: 
-- Module Name:    EX_MEM - Behavioral 
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

entity EX_MEM is
	Port ( 
			 MemReadInput : in  STD_LOGIC;
			 MemWriteInput : in  STD_LOGIC;
			 RegWriteInput : in  STD_LOGIC;
			 MemtoRegInput : in  STD_LOGIC;
			 AddressInput : in  STD_LOGIC_VECTOR (15 downto 0);
			 DataInput : in  STD_LOGIC_VECTOR (15 downto 0);
			 RegDestInput : in  STD_LOGIC_VECTOR (3 downto 0);

			 MemtoRegOutput : out  STD_LOGIC;
			 RegWriteOutput : out  STD_LOGIC;
			 MemReadOutput : out  STD_LOGIC;
			 MemWriteOutput : out  STD_LOGIC;
			 AddressOutput : out  STD_LOGIC_VECTOR (15 downto 0);
			 DataOutput : out  STD_LOGIC_VECTOR (15 downto 0);
			 RegDestOutput : out  STD_LOGIC_VECTOR (3 downto 0);

			 clock : in  STD_LOGIC;
			 rst : in STD_LOGIC);
end EX_MEM;

architecture Behavioral of EX_MEM is
	signal MemRead	: STD_LOGIC;
	signal MemWrite	: STD_LOGIC;
	signal RegWrite	: STD_LOGIC;
	signal MemtoReg	: STD_LOGIC;
	signal Address  : STD_LOGIC_VECTOR (15 downto 0);
	signal Data     : STD_LOGIC_VECTOR (15 downto 0);
	signal RegDest  : STD_LOGIC_VECTOR (3 downto 0);
begin
	MemtoRegOutput <=	MemtoReg;
	RegWriteOutput <=	RegWrite;
	MemReadOutput  <=	MemRead;
	MemWriteOutput <=	MemWrite;
	AddressOutput  <=	Address;
	DataOutput	  <=	Data;
	RegDestOutput  <=	RegDest;

	process (rst, clock)
	begin
		if rst = '0' then
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead  <= '0';
			MemWrite <= '0';
			Address  <= "0000000000000000";
			Data	 <= "0000000000000000";
			RegDest	 <= "0000";
		elsif clock'event and clock='1' then
			MemtoReg <= MemtoRegInput;
			RegWrite <= RegWriteInput;
			MemRead  <= MemReadInput;
			MemWrite <= MemWriteInput;
			Address  <= AddressInput;
			Data	 <= DataInput;
			RegDest	 <= RegDestInput;
		end if;
	end process;
end Behavioral;

