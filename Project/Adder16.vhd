----------------------------------------------------------------------------------
-- Company:
-- Engineer: 许欣然
--
-- Create Date:    14:20:25 11/06/2012
-- Design Name:
-- Module Name:    Adder16 - Behavioral
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Adder16 is
    Port ( InputA : in  STD_LOGIC_VECTOR (15 downto 0);
           InputB : in  STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end Adder16;

architecture Behavioral of Adder16 is

begin
Output <= InputA + InputB;

end Behavioral;

