----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    16:02:24 11/06/2012 
-- Design Name: 
-- Module Name:    DataMemory - Behavioral 
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

entity DataMemory is
    Port ( address : in  STD_LOGIC_VECTOR (15 downto 0);
           dataInput : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
			  MemWrite : in STD_LOGIC;
			  MemRead : in STD_LOGIC
			  );
end DataMemory;

architecture Behavioral of DataMemory is

begin


end Behavioral;

