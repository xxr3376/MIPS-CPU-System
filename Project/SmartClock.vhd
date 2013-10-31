----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:31:15 11/18/2012 
-- Design Name: 
-- Module Name:    SmartClock - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SmartClock is
    Port ( AutoCLK : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           automatic : in  STD_LOGIC;
           out_clock : out  STD_LOGIC);
end SmartClock;
architecture Behavioral of SmartClock is
signal storage : STD_LOGIC_VECTOR (20 downto 0);
signal clockbuffer : STD_LOGIC;
begin
out_clock <= clockbuffer when automatic='1' else storage(2);
process (AutoCLK)
begin
	if AutoCLK'event and AutoCLK='1' then
		storage <= storage + 1;
	end if;
end process;

process(storage(19))
begin
	if storage(20)'event and storage(20)='1' then
		if clk='0' then
				clockbuffer <= NOT clockbuffer;
		end if;
	end if;
end process;

end Behavioral;

