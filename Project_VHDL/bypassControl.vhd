library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bypassControl is
    Port ( RegAInput : in  STD_LOGIC_VECTOR (3 downto 0);
           RegBInput : in  STD_LOGIC_VECTOR (3 downto 0);
           EX_MEMRdInput : in  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WBRdInput : in  STD_LOGIC_VECTOR (3 downto 0);
           EX_MEMRegWriteInput : in  STD_LOGIC;
           MEM_WBRegWriteInput : in  STD_LOGIC;
           RegASelectOutput : out  STD_LOGIC_VECTOR (1 downto 0);
           RegBSelectOutput : out  STD_LOGIC_VECTOR (1 downto 0));
end bypassControl;

architecture Behavioral of bypassControl is

begin
	RegASelectOutput <= "01" when ((EX_MEMRegWriteInput = '1') and (EX_MEMRdInput /= "1000") and (EX_MEMRdInput = RegAInput)) else
						"10" when ((MEM_WBRegWriteInput = '1') and (Mem_WBRdInput /= "1000") and (Mem_WBRdInput = RegAInput) and (NOT(EX_MEMRdInput=RegAInput))) else
						"00" ;
	RegBSelectOutput <= "01" when ((EX_MEMRegWriteInput = '1') and (EX_MEMRdInput /= "1000") and (EX_MEMRdInput = RegBInput)) else
						"10" when ((MEM_WBRegWriteInput = '1') and (Mem_WBRdInput /= "1000") and (Mem_WBRdInput = RegBInput) and (NOT(EX_MEMRdInput=RegBInput))) else
						"00" ;
--	RegASelectOutput <= "00";
--	RegBSelectOutput <= "00";
end Behavioral;

