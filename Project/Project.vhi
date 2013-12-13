-- Vhdl instantiation template created from schematic /home/pithorn/git/MIPS-CPU-System/Project/Project.sch - Wed Dec  4 00:00:24 2013
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module.
-- 2) To use this template to instantiate this component, cut-and-paste and then edit.
--

   COMPONENT Project
   PORT( InputClock	:	IN	STD_LOGIC; 
          reset	:	IN	STD_LOGIC; 
          led1	:	OUT	STD_LOGIC_VECTOR (6 DOWNTO 0); 
          led2	:	OUT	STD_LOGIC_VECTOR (6 DOWNTO 0); 
          LED_OUTPUT	:	OUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          memoryRW	:	OUT	STD_LOGIC; 
          memoryEN	:	OUT	STD_LOGIC; 
          memoryAddress	:	OUT	STD_LOGIC_VECTOR (17 DOWNTO 0); 
          memoryDatabus	:	INOUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          memoryOE	:	OUT	STD_LOGIC; 
          serialWRN	:	OUT	STD_LOGIC; 
          serialRDN	:	OUT	STD_LOGIC; 
          ram1EN	:	OUT	STD_LOGIC; 
          basicDatabus	:	INOUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          dataReady	:	IN	STD_LOGIC; 
          serialTSRE	:	IN	STD_LOGIC; 
          serialTBRE	:	IN	STD_LOGIC; 
          CLOCK_50M	:	IN	STD_LOGIC; 
          KEY16_INPUT	:	IN	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          CLOCK_11M	:	IN	STD_LOGIC; 
          VGA_hs	:	OUT	STD_LOGIC; 
          VGA_vs	:	OUT	STD_LOGIC; 
          VGA_r	:	OUT	STD_LOGIC_VECTOR (2 DOWNTO 0); 
          VGA_g	:	OUT	STD_LOGIC_VECTOR (2 DOWNTO 0); 
          VGA_b	:	OUT	STD_LOGIC_VECTOR (2 DOWNTO 0); 
          flash_byte	:	OUT	STD_LOGIC; 
          flash_vpen	:	OUT	STD_LOGIC; 
          flash_ce	:	OUT	STD_LOGIC; 
          flash_oe	:	OUT	STD_LOGIC; 
          flash_we	:	OUT	STD_LOGIC; 
          flash_rp	:	OUT	STD_LOGIC; 
          flash_addr	:	OUT	STD_LOGIC_VECTOR (22 DOWNTO 1); 
          flash_data	:	INOUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          keyboard_data	:	IN	STD_LOGIC; 
          keyboard_in	:	IN	STD_LOGIC);
   END COMPONENT;

   UUT: Project PORT MAP(
		InputClock => , 
		reset => , 
		led1 => , 
		led2 => , 
		LED_OUTPUT => , 
		memoryRW => , 
		memoryEN => , 
		memoryAddress => , 
		memoryDatabus => , 
		memoryOE => , 
		serialWRN => , 
		serialRDN => , 
		ram1EN => , 
		basicDatabus => , 
		dataReady => , 
		serialTSRE => , 
		serialTBRE => , 
		CLOCK_50M => , 
		KEY16_INPUT => , 
		CLOCK_11M => , 
		VGA_hs => , 
		VGA_vs => , 
		VGA_r => , 
		VGA_g => , 
		VGA_b => , 
		flash_byte => , 
		flash_vpen => , 
		flash_ce => , 
		flash_oe => , 
		flash_we => , 
		flash_rp => , 
		flash_addr => , 
		flash_data => , 
		keyboard_data => , 
		keyboard_in => 
   );
