
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seg7 is
    Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (6 downto 0));
end seg7;

architecture Behavioral7 of seg7 is
SIGNAL Flip : STD_LOGIC_VECTOR(6 downto 0);
begin
WITH Input SELECT
		Flip	<=	
			"0111111" WHEN "0000",		--0
			"0000110" WHEN "0001",		--1
			"1011011" WHEN "0010",		--2
			"1001111" WHEN "0011",
			"1100110" WHEN "0100",
			"1101101" WHEN "0101",		--5
			"1111100" WHEN "0110",
			"0000111" WHEN "0111",		--7
			"1111111" WHEN "1000",		--8
			"1100111" WHEN "1001",		--9
			"1110111" WHEN "1010",		--A
			"1111100" WHEN "1011",		--b
			"0111001" WHEN "1100",		--C
			"1011110" WHEN "1101",		--d
			"1111001" WHEN "1110",		--E
			"1110001" WHEN OTHERS;		--F
	Output <= Flip;

end Behavioral7;

