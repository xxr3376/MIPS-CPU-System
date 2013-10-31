----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- Create Date:    00:54:36 11/18/2012 
-- Design Name: 
-- Module Name:    LED16 - Behavioral 
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

entity LED16 is
    Port ( LED_OUTPUT : out  STD_LOGIC_VECTOR (15 downto 0);
           INPUT : in  STD_LOGIC_VECTOR (15 downto 0));
end LED16;

architecture Behavioral of LED16 is

begin
LED_OUTPUT <= INPUT;

end Behavioral;

