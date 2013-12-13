library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MuxT16 is
    Port ( InputA : in  STD_LOGIC_VECTOR (15 downto 0);
           InputB : in  STD_LOGIC_VECTOR (15 downto 0);
           InputC : in  STD_LOGIC_VECTOR (15 downto 0);
           control : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (15 downto 0));
end MuxT16;

architecture Behavioral of MuxT16 is

begin
with control select
Output <= InputA when "00",
			InputB when "01",
			InputC when "10",
			"0000000000000000" when others;

end Behavioral;

