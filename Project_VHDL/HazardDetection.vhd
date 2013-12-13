library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HazardDetection is
	Port ( PCWrite : out STD_LOGIC;
		   IFIDWrite : out STD_LOGIC;
		   CtrlSignal : out STD_LOGIC;
		   Instruction : in STD_LOGIC_VECTOR (15 downto 0);
		   IDEXRegDest: in STD_LOGIC_VECTOR (3 downto 0);
		   IDEXMemRead : in STD_LOGIC
	   );
end HazardDetection;

architecture Behavioral of HazardDetection is
	signal WaitSignal : STD_LOGIC := '0';
	signal EQFlag : STD_LOGIC;
begin
	PCWrite <= '0' when WaitSignal='1' else '1';
	IFIDWrite <= '0' when WaitSignal='1' else '1';
	CtrlSignal <= '0' when WaitSignal='1' else '1';
	EQFlag <= '1' when IDEXRegDest(2 downto 0)=Instruction(10 downto 8) else '0';
	process(Instruction,IDEXmemRead)
	begin
		case IDEXMemRead is
			when '1' =>
				case Instruction(15 downto 11) is
					when "00100"|"00101"=>
					--BEQZ or BNEZ
						WaitSignal <= EQFlag;
					when "11101"=>
						case Instruction(4 downto 0) is
							--JR
							when "00000" =>
								WaitSignal <= EQFlag;
							when others => 
								WaitSignal <= '0';
						end case;
					when others=>
						WaitSignal <= '0';
				end case;
			when others =>
				WaitSignal <= '0';
		end case;
	end process;
end Behavioral;


