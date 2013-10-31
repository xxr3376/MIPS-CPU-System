----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:19:25 11/22/2012 
-- Design Name: 
-- Module Name:    Logger - Behavioral 
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

entity Logger is
    Port ( Input1 : in  STD_LOGIC;
			  Input2 : in  STD_LOGIC;
			  Input3 : in  STD_LOGIC;
			  Input4 : in  STD_LOGIC;
			  Input5 : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end Logger;

architecture Behavioral of Logger is

begin
Output <= "00000000000" & Input5 & Input4 & Input3 & Input2 & Input1;

end Behavioral;

