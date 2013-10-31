----------------------------------------------------------------------------------
-- Company:
-- Engineer: 邹林希
--
-- Create Date:    15:22:18 11/06/2012
-- Design Name:
-- Module Name:    ALU - Behavioral
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
Library IEEE;
Use IEEE.Std_logic_1164.all;
USe IEEE.Std_logic_unsigned.all;
use IEEE.Std_logic_arith.all;

ENTITY keytorank IS
	PORT
	(
		key: in std_logic_vector(7 downto 0);
		rank: out std_logic_vector(5 downto 0)
	);
END keytorank ;


ARCHITECTURE behave OF keytorank IS
begin
process(key)
begin
	case key is
		when "01000101"=>
			rank <= "000000";
		when "00010110"=>
			rank <= "000001";	
		when "00011110"=>
			rank <= "000010";
		when "00100110"=>
			rank <= "000011";
		when "00100101"=>
			rank <= "000100";
		when "00101110"=>
			rank <=	"000101";
		when "00110110"=>
			rank <= "000110";
		when "00111101"=>
			rank <= "000111";
		when "00111110"=>
			rank <= "001000";
		when "01000110"=>
			rank <=	"001001";
		when "00011100"=>
			rank <= "001010";
		when "00110010"=>
			rank <= "001011";
		when "00100001"=>
			rank <= "001100";
		when "00100011"=>
			rank <=	"001101";
		when "00100100"=>
			rank <= "001110";
		when "00101011"=>
			rank <= "001111";
		when "00110100"=>
			rank <= "010000";
		when "00110011"=>
			rank <=	"010001";
		when "01000011"=>
			rank <= "010010";
		when "00111011"=>
			rank <= "010011";
		when "01000010"=>
			rank <= "010100";
		when "01001011"=>
			rank <=	"010101";
		when "00110001"=>
			rank <= "010111";
		when "00111010"=>
			rank <= "010110";
		when "01000100"=>
			rank <= "011000";
		when "01001101"=>
			rank <=	"011001";
		when "00010101"=>
			rank <= "011010";
		when "00101101"=>
			rank <= "011011";
		when "00011011"=>
			rank <= "011100";
		when "00101100"=>
			rank <=	"011101";
		when "00111100"=>
			rank <= "011110";
		when "00101010"=>
			rank <= "011111";
		when "00011101"=>
			rank <= "100000";
		when "00100010"=>
			rank <=	"100001";
		when "00110101"=>
			rank <= "100010";
		when "00011010"=>
			rank <= "100011";
		when "00101001"=>
			rank <= "100100";
		when "01000001"=>
			rank <= "100101";		--space
		when "01011010"=>			--Enter
			rank <= "111000";
		when "11110000"=>			--F0
			rank <= "111110";
		when others =>
			rank <= "111111";
	end case;
end process;
end behave;
