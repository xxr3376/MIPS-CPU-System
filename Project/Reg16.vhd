----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:10:24 11/06/2012 
-- Design Name: 
-- Module Name:    Reg16 - Behavioral 
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

entity Reg16 is
    Port ( Input : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0);
           clk : in  STD_LOGIC;
			  clock : in STD_LOGIC);
end Reg16;

architecture Behavioral of Reg16 is
signal storage : STD_LOGIC_VECTOR (15 downto 0);
begin
	output <= storage;
	process(clk, clock)
	begin
		if clock'event and clock='0' then
			if clk = '1' then
				storage <= input;
			end if;
		end if;
	end process;
	
end Behavioral;

