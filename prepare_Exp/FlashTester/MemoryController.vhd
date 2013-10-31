----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 许欣然
-- 
-- Create Date:    16:02:24 11/06/2012 
-- Design Name: 
-- Module Name:    MemoryController - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--address1 is processed eariler than address2
--recommend use address1 for InstructionMemory,
--	address2 for MemoryController

entity MemoryController is
	Port ( address1 : in  STD_LOGIC_VECTOR (15 downto 0);
		   output1 : out  STD_LOGIC_VECTOR (15 downto 0);
		   address2 : in  STD_LOGIC_VECTOR (15 downto 0);
		   output2 : out  STD_LOGIC_VECTOR (15 downto 0);
		   clock : in STD_LOGIC;
		   stdClock : out STD_LOGIC; -- for standard CPU clock

	-- only for address 2
		   dataInput : in  STD_LOGIC_VECTOR (15 downto 0); --only for address2
		   MemWrite : in STD_LOGIC;
		   MemRead : in STD_LOGIC;
	-- connection with memory
		   memoryAddress : out STD_LOGIC_VECTOR (17 downto 0);
		   extendDatabus : inout STD_LOGIC_VECTOR(15 downto 0);
		   memoryEN : out STD_LOGIC;
		   memoryOE : out STD_LOGIC;
		   memoryRW : out STD_LOGIC;
	-- connection with serial port
		   serialWRN : out STD_LOGIC;
		   serialRDN : out STD_LOGIC;
		   serialDATA_READY : in STD_LOGIC;
		   serialTSRE : in STD_LOGIC;
		   serialTBRE : in STD_LOGIC;
		   basicDatabus : inout STD_LOGIC_VECTOR(7 downto 0);
		   ram1EN : out STD_LOGIC;
		   reset : in STD_LOGIC;

	-- connection with FLASH

		   flash_byte : out std_logic;--BYTE#
		   flash_vpen : out std_logic;
		   flash_ce : out std_logic;
		   flash_oe : out std_logic;
		   flash_we : out std_logic;
		   flash_rp : out std_logic;
	--flash_sts : in std_logic;
		   flash_addr : out std_logic_vector(22 downto 1);
		   flash_data : inout std_logic_vector(15 downto 0)

	   );
end MemoryController;

architecture Behavioral of MemoryController is
	type state_type is (BOOT, BOOT_FLASH, BOOT_RAM1, BOOT_RAM2, BOOT_READY, READ1, IDEL1, RW2, IDEL2);
	signal state : state_type := BOOT;
	signal readin, holder, addressTemp : STD_LOGIC_VECTOR (15 downto 0);
	signal serialHolder : STD_LOGIC_VECTOR (7 downto 0);
	signal buffer1, buffer2 :  STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
	signal bus_flag : STD_LOGIC;
	signal serial_flag : STD_LOGIC;
	signal BF01 : STD_LOGIC_VECTOR (15 downto 0);
	component flash_io
		Port ( addr : in  STD_LOGIC_VECTOR (22 downto 1);
			   data_in : in  STD_LOGIC_VECTOR (15 downto 0);
			   data_out : out  STD_LOGIC_VECTOR (15 downto 0);
			   clk : in std_logic;--随便什么时钟
			   reset : in std_logic;

			   flash_byte : out std_logic;--BYTE#
			   flash_vpen : out std_logic;
			   flash_ce : out std_logic;
			   flash_oe : out std_logic;
			   flash_we : out std_logic;
			   flash_rp : out std_logic;
			  --flash_sts : in std_logic;
			   flash_addr : out std_logic_vector(22 downto 1);
			   flash_data : inout std_logic_vector(15 downto 0);

			   ctl_read : in  STD_LOGIC;
			   ctl_write : in  STD_LOGIC;
			   ctl_erase : in STD_LOGIC
		   );
	end component;
	signal ctl_read, ctl_write, ctl_erase : std_logic;
	signal flash_addr_input : std_logic_vector(22 downto 1);
	signal flash_data_input : std_logic_vector(15 downto 0);
	signal flash_data_output : std_logic_vector(15 downto 0);
	signal FLASHPC: STD_LOGIC_VECTOR(15 downto 0) := x"FFFF";
	signal clk_flash : STD_LOGIC;
	signal FLASH_HOLDER : STD_LOGIC_VECTOR(15 downto 0);
	signal FLASH_COUNTER : STD_LOGIC_VECTOR (7 downto 0);
begin
	flash : flash_io PORT MAP (
								  addr => flash_addr_input,
								  data_in => flash_data_input,
								  data_out => flash_data_output,
								  clk => clock,
								  reset => reset,
								  flash_byte => flash_byte,
								  flash_vpen => flash_vpen,
								  flash_ce => flash_ce,
								  flash_oe => flash_oe,
								  flash_we => flash_we,
								  flash_rp => flash_rp,
		--flash_sts => flash_sts,
								  flash_addr => flash_addr,
								  flash_data => flash_data,
								  ctl_read => ctl_read,
								  ctl_write => ctl_write,
								  ctl_erase => ctl_erase
							  );

	ctl_write <= '1';
	ctl_erase <= '1';
	with state select
		ctl_read <= '0' when BOOT_FLASH,
						'1' when others;
	output1 <= buffer1;
	output2 <= buffer2;
	memoryEN <= '0';
	ram1EN <= '1';	--disable ram1
	BF01(0) <= serialTSRE and serialTBRE;
	BF01(1) <= serialDATA_READY;
	BF01(15 downto 2) <= "00000000000000";
	extendDatabus <= holder when bus_flag = '0' else "ZZZZZZZZZZZZZZZZ";
	basicDatabus <= serialHolder when serial_flag = '0' else "ZZZZZZZZ";
	memoryAddress <= "00" & addressTemp;
	with state select
		addressTemp <= address2 when IDEL2 | RW2,
					   address1 when IDEL1 | READ1,
						FLASHPC when BOOT_FLASH | BOOT_RAM1 | BOOT_RAM2,
					   "0000000000000000" when others;
	with state select
		memoryOE <= NOT MemRead when RW2,
					'1' when BOOT_FLASH | BOOT_RAM1 | BOOT_RAM2,
					'0' when others;
	with state select
		bus_flag <= NOT MemWrite when RW2 | IDEL1,
					'0' when BOOT_RAM1 | BOOT_RAM2,
					'1' when others;
	with state select
		serial_flag <= NOT MemWrite when RW2 | IDEL1 | IDEL2,
					   '1' when others;
	serialWRN <= NOT MemWrite when (address2=x"BF00" and state=RW2) else '1';
	serialRDN <= NOT MemRead when (address2=x"BF00" and (state=IDEL1 or state=RW2 or state=IDEL2)) else '1';
	memoryRW <= '1' when (address2=x"BF00" and state=RW2) else 
				NOT MemWrite when state=RW2 else 
				'0' when (state=BOOT_RAM2) else 
				'1';
	with state select
		holder <= FLASH_HOLDER when BOOT_FLASH | BOOT_RAM1 | BOOT_RAM2,
				  dataInput when others;
	serialHolder <= dataInput (7 downto 0);
	with state select
		stdClock <= '1' when IDEL1 | READ1,
					'0' when others;
	process(clock, reset)
	begin
		if reset='0' then
			state <= BOOT;
			buffer1 <= extendDatabus;
		elsif clock'event and clock='1' then
			case state is
				when BOOT =>
					state <= BOOT_FLASH;
					FLASH_COUNTER <= "00000000";
				when BOOT_FLASH =>
					case FLASH_COUNTER is
						when "00000000" =>
							flash_addr_input <= FLASHPC + 1;
							FLASHPC <= FLASHPC + 1;
							FLASH_COUNTER <= FLASH_COUNTER + 1;
						when "11111111" =>
							FLASH_HOLDER <= flash_data_output;
							state <= BOOT_RAM1;
							FLASH_COUNTER <= "00000000";
						when others =>
							FLASH_COUNTER <= FLASH_COUNTER + 1;
					end case;
				when BOOT_RAM1=>
					state <= BOOT_RAM2;
				when BOOT_RAM2=>
					if (FLASHPC < x"0FFF") then
						state <= BOOT_FLASH;
					else
						state <= BOOT_READY;
					end if;
				when BOOT_READY =>
					state <= READ1;
				when READ1 =>
					state <= IDEL1;
					buffer1 <= extendDatabus;
				when IDEL1 =>
					state <= RW2;
				when RW2 =>
					state <= IDEL2;			
					case address2 is
						when x"BF01" =>
							buffer2 <= BF01;
						when x"BF00" =>
							buffer2 <= "00000000" & basicDatabus;
						when others =>
							buffer2 <= extendDatabus;
					end case;
				when others => --include IDEL2, BOOT
					state <= READ1;
			end case;
		end if;
	end process;
end Behavioral;

