library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux16 is
    Port ( InputA : in  STD_LOGIC_VECTOR (15 downto 0);
           InputB : in  STD_LOGIC_VECTOR (15 downto 0);
           control1 : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end Mux16;

architecture Behavioral of Mux16 is

begin
with control1 select
Output <= InputA when '0',
			InputB when '1',
			"0000000000000000" when others;

end Behavioral;

