----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    21:42:32 11/11/2012 
-- Design Name: 
-- Module Name:    TContrl - Behavioral 
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

entity TControl is
    Port ( RegTWrite : in  STD_LOGIC;
           BranchType : in  STD_LOGIC;
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           clock : in  STD_LOGIC;
           T : out  STD_LOGIC);
end TControl;

architecture Behavioral of TControl is

begin


end Behavioral;

