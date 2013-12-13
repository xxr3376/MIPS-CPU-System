library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IDRegABypass is
    Port ( RegA : in  STD_LOGIC_VECTOR (15 downto 0);
           SelectA : in  STD_LOGIC_VECTOR (3 downto 0);
           ALURegA : in  STD_LOGIC_VECTOR (15 downto 0);
           MemRegA : in  STD_LOGIC_VECTOR (15 downto 0);
           ALURegWrite : in  STD_LOGIC;
           MemRegWrite : in  STD_LOGIC;
           ALUDest : in  STD_LOGIC_VECTOR (3 downto 0);
           MemDest : in  STD_LOGIC_VECTOR (3 downto 0);
           RegAOutput : out  STD_LOGIC_VECTOR (15 downto 0));
end IDRegABypass;

architecture Behavioral of IDRegABypass is
signal SelectionSignal : STD_LOGIC_VECTOR (1 downto 0);
begin
	with SelectionSignal select
		RegAOutput <= ALURegA when "01",
						  MemRegA when "10",
						  RegA when others;
	SelectionSignal <= "01" when ((ALURegWrite = '1') and (ALUDest /= "1000") and (ALUDest = SelectA)) else
						"10" when ((MemRegWrite = '1') and (MemDest/="1000") and (MemDest=SelectA) and (NOT (ALUDest=SelectA))) else
						"00" ;


end Behavioral;

