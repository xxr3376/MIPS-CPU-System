----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    11:38:34 11/17/2012 
-- Design Name: 
-- Module Name:    PCReg - Behavioral 
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

entity PCReg is
    Port ( Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  WriteIN : in STD_LOGIC);
end PCReg;

architecture Behavioral of PCReg is
signal storage : STD_LOGIC_VECTOR (15 downto 0);
begin
	output <= storage;
	process(rst, clk)
	begin
		if rst='0' then
			storage <= "0000000000000000";
		elsif clk'event and clk = '1' then
			if WriteIN = '1' then
				storage <= input;
			end if;
		end if;
	end process;
end Behavioral;

