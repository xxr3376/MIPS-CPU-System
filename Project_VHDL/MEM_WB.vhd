library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_WB is
	Port ( RegWriteInput : in  STD_LOGIC;
		   MemtoRegInput : in  STD_LOGIC;
		   ALUDataInput : in  STD_LOGIC_VECTOR (15 downto 0);
		   ReadDataInput : in  STD_LOGIC_VECTOR (15 downto 0);
		   RegDestInput : in  STD_LOGIC_VECTOR (3 downto 0);
		   RegWriteOutput : out  STD_LOGIC;
		   MemtoRegOutput : out  STD_LOGIC;
		   ALUDataOutput : out  STD_LOGIC_VECTOR (15 downto 0);
		   ReadDataOutput : out  STD_LOGIC_VECTOR (15 downto 0);
		   RegDestOutput : out  STD_LOGIC_VECTOR (3 downto 0);
		   clock : in STD_LOGIC;
		   rst : in STD_LOGIC);
end MEM_WB;

architecture Behavioral of MEM_WB is
	signal RegWrite :	STD_LOGIC;
	signal MemtoReg	:	STD_LOGIC; 
	signal ALUData 	:	STD_LOGIC_VECTOR (15 downto 0); 
	signal ReadData	:	STD_LOGIC_VECTOR (15 downto 0); 
	signal RegDest 	:	STD_LOGIC_VECTOR (3 downto 0); 
begin
	RegWriteOutput	<=	RegWrite;
	MemtoRegOutput	<=	MemtoReg;
    ALUDataOutput	<=	ALUData ;
    ReadDataOutput	<=	ReadData;
    RegDestOutput	<=	RegDest ;
	process(rst, clock)
	begin
		if rst='0' then
			RegWrite <= '0';
			MemtoReg <= '0';
			ALUData  <= "0000000000000000";
			ReadData <= "0000000000000000";
			RegDest  <= "0000";
		elsif clock'event and clock = '1' then
			RegWrite    <= RegWriteInput;
			MemtoReg    <= MemtoRegInput;
			ALUData     <= ALUDataInput;
			ReadData    <= ReadDataInput;
			RegDest 	<= RegDestInput;
		end if;
	end process;
end Behavioral;

