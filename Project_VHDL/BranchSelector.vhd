library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BranchSelector is
    Port ( TInput : in  STD_LOGIC;
           RegAInput : in  STD_LOGIC_VECTOR (15 downto 0);
			  InstInput : in STD_LOGIC_VECTOR (15 downto 0);
           Output : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end BranchSelector;

architecture Behavioral of BranchSelector is

begin
process(TInput,RegAInput,InstInput)
begin
	case InstInput(15 downto 11) is
		when "00010" =>
		--B imm
			Output <= "01";
		when "00100" =>
		--BEQZ rx imm
			if RegAInput = "0000000000000000" then
				Output <= "01";
			else
				Output <= "00";
			end if;
		when "00101" =>
		--BNEZ rx imm
			if RegAInput /= "0000000000000000" then
				Output <= "01";
			else
				Output <= "00";
			end if;	
		when "01100" =>
			case InstInput(10 downto 8) is
				when "000" =>
				--BTEQZ imm
					if TInput = '0' then
						Output <= "01";
					else
						Output <= "00";
					end if;
				when "001" =>
				--BTNEZ imm
					if TInput /= '0' then
						Output <= "01";
					else
						Output <= "00";
					end if;
				when others =>
					Output <= "00";
			end case;
		
		when "11101" =>
			if InstInput(7 downto 0)= "00000000" then
			--JR rx
				Output <= "10";
			else
				Output <= "00";
			end if;
		when others =>
			Output <= "00";
	end case;
end process;
end Behavioral;

