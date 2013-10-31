----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    01:04:56 11/21/2012 
-- Design Name: 
-- Module Name:    DebugInputPort - Behavioral 
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

entity DebugInputPort is
    Port ( KEY_INPUT : in  STD_LOGIC_VECTOR (15 downto 0);
           Output0_3 : out  STD_LOGIC_VECTOR (3 downto 0);
			  ClockSelection : out STD_LOGIC);
end DebugInputPort;

architecture Behavioral of DebugInputPort is

begin
Output0_3 <= KEY_INPUT(3 downto 0);
ClockSelection <= KEY_INPUT(4);

end Behavioral;

