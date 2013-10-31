----------------------------------------------------------------------------------
-- Company: 
-- Engineer: –Ì–¿»ª
-- 
-- Create Date:    20:13:09 11/05/2012 
-- Design Name: 
-- Module Name:    IFID - Behavioral 
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
entity IFID is
	Port ( InstructionInput : in  STD_LOGIC_VECTOR (15 downto 0);
		   PCInput : in  STD_LOGIC_VECTOR (15 downto 0);
		   InstructionOutput : out  STD_LOGIC_VECTOR (15 downto 0);
		   PCOutput : out  STD_LOGIC_VECTOR (15 downto 0);
		   clock : in  STD_LOGIC;
		   rst : in STD_LOGIC;
			WriteIN : in STD_LOGIC);
end IFID;

architecture Behavioral of IFID is
	signal Instruction : STD_LOGIC_VECTOR (15 downto 0) := "0000100000000000";
	signal PC : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
begin
	InstructionOutput <= Instruction;
	PCOutput <= PC;
	process(rst, clock)
	begin
		if rst='0' then
			Instruction <= "0000100000000000";
			PC <= "0000000000000000";
		elsif clock'event and clock = '1' then
			if WriteIN = '1' then
				Instruction <= InstructionInput;
				PC <= PCInput;
			end if;
		end if;
	end process;
end Behavioral;
