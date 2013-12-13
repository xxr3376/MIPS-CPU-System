
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SignedExtend is
    Port ( Instruction : in  STD_LOGIC_VECTOR (15 downto 0);
           ExtendedAddress : out  STD_LOGIC_VECTOR (15 downto 0));
end SignedExtend;

architecture Behavioral of SignedExtend is


begin
process(Instruction)
begin
case Instruction(15 downto 11) is
	when "00000" | "00100" | "00101" | "01001" | "01010" | "01100" | "10010" | "11010" =>
	-- imm:7-0 sign_extend
		ExtendedAddress(15 downto 8) <= (others=>Instruction(7));
		ExtendedAddress(7 downto 0) <= Instruction(7 downto 0);
	when "00010" =>
	-- imm:10-0 sign_extend
		ExtendedAddress(15 downto 11) <= (others=>Instruction(10));
		ExtendedAddress(10 downto 0) <= Instruction(10 downto 0);
	when "01000" =>
	-- imm:3-0 sign_extend
		ExtendedAddress(15 downto 4) <= (others=>Instruction(3));
		ExtendedAddress(3 downto 0) <= Instruction(3 downto 0);
	when "00110" =>
	--imm:4-2 zero_extend
		ExtendedAddress(15 downto 4) <= (others=>'0');
		if Instruction(4 downto 2) = "000" then  
			ExtendedAddress(3) <= '1';
		else
			ExtendedAddress(3) <= '0';
		end if;
		ExtendedAddress(2 downto 0) <= Instruction(4 downto 2);	
	when "10011" | "11011" =>
	--imm:4-0 sign_extend	
		ExtendedAddress(15 downto 5) <= (others=>Instruction(4));
		ExtendedAddress(4 downto 0) <= Instruction(4 downto 0);
	when "01101" =>
	--imm:7-0 zero_extend
		ExtendedAddress(15 downto 8) <= (others=>'0');
		ExtendedAddress(7 downto 0) <= Instruction(7 downto 0);	
	when others=>
		ExtendedAddress <= (others=>'0');
end case;
end process;

end Behavioral;

