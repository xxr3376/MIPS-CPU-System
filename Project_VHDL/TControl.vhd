
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
           TType : in  STD_LOGIC;
           ALUResult : in  STD_LOGIC_VECTOR (15 downto 0);
           clock : in  STD_LOGIC;
           T : out  STD_LOGIC);
end TControl;

architecture Behavioral of TControl is
signal geFlag, eqFlag : STD_LOGIC;
signal Tholder : STD_LOGIC;
begin
eqFlag <= 	ALUResult(0) or ALUResult(1) or ALUResult(2) or ALUResult(3) or 
				ALUResult(4) or ALUResult(5) or ALUResult(6) or ALUResult(7) or
				ALUResult(8) or ALUResult(9) or ALUResult(10) or ALUResult(11) or
				ALUResult(12) or ALUResult(13) or ALUResult(14) or ALUResult(15);
				
geFlag <= ALUResult (15);
T <= Tholder;

process(clock)
begin
	if clock'event and clock='0' and RegTWrite='1' then	--Բ⸺ؿ
		case TType is
			when '0' =>
				Tholder <= geFlag;
			when '1' =>
				Tholder <= eqFlag;
			when others =>
		end case;
	end if;
end process;
end Behavioral;
