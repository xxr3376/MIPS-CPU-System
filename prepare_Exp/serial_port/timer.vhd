----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- Create Date:    23:05:01 10/18/2012 
-- Design Name: 
-- Module Name:    leder - Behavioral 
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

entity timer is
	Port ( input_clk : in  STD_LOGIC;
           ms_clk : out  STD_LOGIC);
end timer;
architecture Behavioral of timer is
	Signal counter: STD_LOGIC_VECTOR(20 downto 0);
begin
	process(input_clk)
	begin
		if input_clk'event and input_clk = '1' then
			counter <= counter + 1;
		end if;
	end process;
	ms_clk <= counter(20);
end Behavioral;

