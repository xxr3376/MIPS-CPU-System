library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Project is
   port ( CLOCK_11M     : in    std_logic; 
          CLOCK_50M     : in    std_logic; 
          dataReady     : in    std_logic; 
          InputClock    : in    std_logic; 
          keyboard_data : in    std_logic; 
          keyboard_in   : in    std_logic; 
          KEY16_INPUT   : in    std_logic_vector (15 downto 0); 
          reset         : in    std_logic; 
          serialTBRE    : in    std_logic; 
          serialTSRE    : in    std_logic; 
          flash_addr    : out   std_logic_vector (22 downto 1); 
          flash_byte    : out   std_logic; 
          flash_ce      : out   std_logic; 
          flash_oe      : out   std_logic; 
          flash_rp      : out   std_logic; 
          flash_vpen    : out   std_logic; 
          flash_we      : out   std_logic; 
          LED_OUTPUT    : out   std_logic_vector (15 downto 0); 
          led1          : out   std_logic_vector (6 downto 0); 
          led2          : out   std_logic_vector (6 downto 0); 
          memoryAddress : out   std_logic_vector (17 downto 0); 
          memoryEN      : out   std_logic; 
          memoryOE      : out   std_logic; 
          memoryRW      : out   std_logic; 
          ram1EN        : out   std_logic; 
          serialRDN     : out   std_logic; 
          serialWRN     : out   std_logic; 
          VGA_b         : out   std_logic_vector (2 downto 0); 
          VGA_g         : out   std_logic_vector (2 downto 0); 
          VGA_hs        : out   std_logic; 
          VGA_r         : out   std_logic_vector (2 downto 0); 
          VGA_vs        : out   std_logic; 
          basicDatabus  : inout std_logic_vector (7 downto 0); 
          flash_data    : inout std_logic_vector (15 downto 0); 
          memoryDatabus : inout std_logic_vector (15 downto 0));
end Project;

architecture BEHAVIORAL of Project is
   signal CPU_CLOCK                        : std_logic;
   signal Extend                           : std_logic_vector (15 downto 0);
   signal instruction                      : std_logic_vector (15 downto 0);
   signal cpu_IFID_PCInput                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_RegWrite                         : std_logic;
   signal cpu_MuxT16_3_control                         : std_logic_vector (1 downto 0);
   signal cpu_TControl_T                         : std_logic;
   signal cpu_IDEX_RegTWriteOutput                         : std_logic;
   signal cpu_RegisterFile_RegB                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_SelectA                         : std_logic_vector (3 downto 0);
   signal cpu_RegisterFile_SelectB                         : std_logic_vector (3 downto 0);
   signal cpu_Controller_TType                         : std_logic;
   signal cpu_Controller_MemRead                         : std_logic;
   signal cpu_Controller_MemWrite                         : std_logic;
   signal cpu_Controller_RegWrite                         : std_logic;
   signal cpu_Controller_MemtoReg                         : std_logic;
   signal cpu_Controller_ALUOp                         : std_logic_vector (2 downto 0);
   signal cpu_Controller_RegTWrite                         : std_logic;
   signal cpu_Controller_ALUSrc1                         : std_logic;
   signal cpu_Controller_ALUSrc2                         : std_logic;
   signal cpu_Controller_RegtoMem                         : std_logic;
   signal cpu_Controller_RegDst                         : std_logic_vector (3 downto 0);
   signal cpu_MuxT16_3_InputB                         : std_logic_vector (15 downto 0);
   signal cpu_IDEX_ALUSrc1Output                         : std_logic;
   signal cpu_IDEX_ALUSrc2Output                         : std_logic;
   signal cpu_IDEX_TTypeOutput                         : std_logic;
   signal cpu_IDEX_MemWriteOutput                         : std_logic;
   signal cpu_IDEX_MemtoRegOutput                         : std_logic;
   signal cpu_IDEX_RegBOutput                         : std_logic_vector (15 downto 0);
   signal cpu_IDEX_ExtendedAddressOutput                         : std_logic_vector (15 downto 0);
   signal cpu_IDEX_RegDstOutput                         : std_logic_vector (3 downto 0);
   signal cpu_bypassControl_RegBSelectOutput                         : std_logic_vector (1 downto 0);
   signal cpu_bypassControl_RegASelectOutput                         : std_logic_vector (1 downto 0);
   signal cpu_IDEX_Src1Output                         : std_logic_vector (3 downto 0);
   signal cpu_IDEX_Src2Output                         : std_logic_vector (3 downto 0);
   signal cpu_Mux16_1_InputA                         : std_logic_vector (15 downto 0);
   signal cpu_Mux16_2_InputA                         : std_logic_vector (15 downto 0);
   signal cpu_IDEX_RegtoMemOutput                         : std_logic;
   signal cpu_Mux16_3_Output                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_PCInput                         : std_logic_vector (15 downto 0);
   signal cpu_IDEX_ALUOPOutput                         : std_logic_vector (2 downto 0);
   signal cpu_EX_MEM_RegDestOutput                         : std_logic_vector (3 downto 0);
   signal cpu_MuxT16_3_Output                         : std_logic_vector (15 downto 0);
   signal cpu_SmartClock_out_clock                         : std_logic;
   signal cpu_EX_MEM_MemReadOutput                         : std_logic;
   signal cpu_EX_MEM_MemWriteOutput                         : std_logic;
   signal cpu_EX_MEM_DataOutput                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_DebugInput                         : std_logic_vector (3 downto 0);
   signal cpu_IDEX_RegAOutput                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_SelectC                         : std_logic_vector (3 downto 0);
   signal cpu_ALU_dataB                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_InputData                         : std_logic_vector (15 downto 0);
   signal cpu_LED16_INPUT                         : std_logic_vector (15 downto 0);
   signal cpu_Mux16_4_InputA                         : std_logic_vector (15 downto 0);
   signal cpu_RegisterFile_RegA                        : std_logic_vector (15 downto 0);
   signal cpu_IDEX_RegWriteOutput                        : std_logic;
   signal cpu_Mux16_4_control1                        : std_logic;
   signal cpu_Mux16_4_InputB                        : std_logic_vector (15 downto 0);
   signal cpu_Mux16_4_Output                        : std_logic_vector (15 downto 0);
   signal cpu_EX_MEM_RegWriteOutput                        : std_logic;
   signal cpu_ALU_dataA                        : std_logic_vector (15 downto 0);
   signal cpu_MuxT16_3_InputC                        : std_logic_vector (15 downto 0);
   signal cpu_PCReg_WriteIN                        : std_logic;
   signal cpu_IDEX_MemReadOutput                        : std_logic;
   signal cpu_SmartClock_automatic                        : std_logic;
   signal cpu_PCReg_Output                        : std_logic_vector (15 downto 0);
   signal cpu_ALU_result                        : std_logic_vector (15 downto 0);
   signal cpu_IFID_WriteIN                        : std_logic;
   signal cpu_IFID_InstructionInput                        : std_logic_vector (15 downto 0);
   signal cpu_MemoryController_VGA_write                        : std_logic_vector (0 downto 0);
   signal cpu_MemoryController_VGA_addr                        : std_logic_vector (9 downto 0);
   signal cpu_MemoryController_VGA_char                        : std_logic_vector (7 downto 0);
   signal cpu_MemoryController_Keyboard_Dataready                        : std_logic;
   signal cpu_MemoryController_Keyboard_Data                        : std_logic_vector (5 downto 0);
   signal cpu_MemoryController_Keyboard_wrn                        : std_logic;
   signal memoryOE_DUMMY                   : std_logic;
   signal serialRDN_DUMMY                  : std_logic;
   signal memoryRW_DUMMY                   : std_logic;
   signal serialWRN_DUMMY                  : std_logic;
   signal cpu_MEM_WB_MemtoRegInput_openSignal : std_logic;
   signal cpu_MEM_WB_ReadDataInput_openSignal : std_logic_vector (15 downto 0);
   signal cpu_SignedExtend_2_MemtoRegInput_openSignal   : std_logic_vector (15 downto 0);
   component RegisterFile
      port ( RegWrite    : in    std_logic; 
             SelectA     : in    std_logic_vector (3 downto 0); 
             SelectB     : in    std_logic_vector (3 downto 0); 
             PCInput     : in    std_logic_vector (15 downto 0); 
             SelectC     : in    std_logic_vector (3 downto 0); 
             InputData   : in    std_logic_vector (15 downto 0); 
             DebugInput  : in    std_logic_vector (3 downto 0); 
             RegA        : out   std_logic_vector (15 downto 0); 
             RegB        : out   std_logic_vector (15 downto 0); 
             DebugOutput : out   std_logic_vector (15 downto 0); 
             clock       : in    std_logic);
   end component;
   
   component Controller
      port ( InstructionInput : in    std_logic_vector (15 downto 0); 
             ALUSrc1          : out   std_logic; 
             ALUSrc2          : out   std_logic; 
             RegTWrite        : out   std_logic; 
             TType            : out   std_logic; 
             MemRead          : out   std_logic; 
             MemWrite         : out   std_logic; 
             RegWrite         : out   std_logic; 
             MemtoReg         : out   std_logic; 
             RegtoMem         : out   std_logic; 
             RegDst           : out   std_logic_vector (3 downto 0); 
             ALUOp            : out   std_logic_vector (2 downto 0); 
             Src1             : out   std_logic_vector (3 downto 0); 
             Src2             : out   std_logic_vector (3 downto 0));
   end component;
   
   component IFID
      port ( clock             : in    std_logic; 
             rst               : in    std_logic; 
             InstructionInput  : in    std_logic_vector (15 downto 0); 
             PCInput           : in    std_logic_vector (15 downto 0); 
             InstructionOutput : out   std_logic_vector (15 downto 0); 
             PCOutput          : out   std_logic_vector (15 downto 0); 
             WriteIN           : in    std_logic);
   end component;
   
   component SignedExtend
      port ( Instruction     : in    std_logic_vector (15 downto 0); 
             ExtendedAddress : out   std_logic_vector (15 downto 0));
   end component;
   
   component IDEX
      port ( RegTWriteInput        : in    std_logic; 
             ALUSrc1Input          : in    std_logic; 
             ALUSrc2Input          : in    std_logic; 
             TTypeInput            : in    std_logic; 
             MemReadInput          : in    std_logic; 
             MemWriteInput         : in    std_logic; 
             RegWriteInput         : in    std_logic; 
             MemtoRegInput         : in    std_logic; 
             RegtoMemInput         : in    std_logic; 
             clock                 : in    std_logic; 
             RegDstInput           : in    std_logic_vector (3 downto 0); 
             ALUOPInput            : in    std_logic_vector (2 downto 0); 
             RegAInput             : in    std_logic_vector (15 downto 0); 
             RegBInput             : in    std_logic_vector (15 downto 0); 
             Src1Input             : in    std_logic_vector (3 downto 0); 
             Src2Input             : in    std_logic_vector (3 downto 0); 
             ExtendedAddressInput  : in    std_logic_vector (15 downto 0); 
             RegTWriteOutput       : out   std_logic; 
             ALUSrc1Output         : out   std_logic; 
             ALUSrc2Output         : out   std_logic; 
             TTypeOutput           : out   std_logic; 
             MemReadOutput         : out   std_logic; 
             MemWriteOutput        : out   std_logic; 
             RegWriteOutput        : out   std_logic; 
             MemtoRegOutput        : out   std_logic; 
             RegtoMemOutput        : out   std_logic; 
             RegDstOutput          : out   std_logic_vector (3 downto 0); 
             ALUOPOutput           : out   std_logic_vector (2 downto 0); 
             RegAOutput            : out   std_logic_vector (15 downto 0); 
             RegBOutput            : out   std_logic_vector (15 downto 0); 
             Src1Output            : out   std_logic_vector (3 downto 0); 
             Src2Output            : out   std_logic_vector (3 downto 0); 
             ExtendedAddressOutput : out   std_logic_vector (15 downto 0); 
             rst                   : in    std_logic);
   end component;
   
   component ALU
      port ( dataA     : in    std_logic_vector (15 downto 0); 
             dataB     : in    std_logic_vector (15 downto 0); 
             operation : in    std_logic_vector (2 downto 0); 
             result    : out   std_logic_vector (15 downto 0));
   end component;
   
   component Mux16
      port ( control1 : in    std_logic; 
             InputA   : in    std_logic_vector (15 downto 0); 
             InputB   : in    std_logic_vector (15 downto 0); 
             Output   : out   std_logic_vector (15 downto 0));
   end component;
   
   component EX_MEM
      port ( MemReadInput   : in    std_logic; 
             MemWriteInput  : in    std_logic; 
             RegWriteInput  : in    std_logic; 
             MemtoRegInput  : in    std_logic; 
             clock          : in    std_logic; 
             rst            : in    std_logic; 
             AddressInput   : in    std_logic_vector (15 downto 0); 
             DataInput      : in    std_logic_vector (15 downto 0); 
             RegDestInput   : in    std_logic_vector (3 downto 0); 
             MemtoRegOutput : out   std_logic; 
             RegWriteOutput : out   std_logic; 
             MemReadOutput  : out   std_logic; 
             MemWriteOutput : out   std_logic; 
             AddressOutput  : out   std_logic_vector (15 downto 0); 
             DataOutput     : out   std_logic_vector (15 downto 0); 
             RegDestOutput  : out   std_logic_vector (3 downto 0));
   end component;
   
   component MEM_WB
      port ( RegWriteInput  : in    std_logic; 
             MemtoRegInput  : in    std_logic; 
             clock          : in    std_logic; 
             ALUDataInput   : in    std_logic_vector (15 downto 0); 
             ReadDataInput  : in    std_logic_vector (15 downto 0); 
             RegDestInput   : in    std_logic_vector (3 downto 0); 
             RegWriteOutput : out   std_logic; 
             MemtoRegOutput : out   std_logic; 
             ALUDataOutput  : out   std_logic_vector (15 downto 0); 
             ReadDataOutput : out   std_logic_vector (15 downto 0); 
             RegDestOutput  : out   std_logic_vector (3 downto 0); 
             rst            : in    std_logic);
   end component;
   
   component bypassControl
      port ( EX_MEMRegWriteInput : in    std_logic; 
             MEM_WBRegWriteInput : in    std_logic; 
             RegAInput           : in    std_logic_vector (3 downto 0); 
             RegBInput           : in    std_logic_vector (3 downto 0); 
             EX_MEMRdInput       : in    std_logic_vector (3 downto 0); 
             Mem_WBRdInput       : in    std_logic_vector (3 downto 0); 
             RegASelectOutput    : out   std_logic_vector (1 downto 0); 
             RegBSelectOutput    : out   std_logic_vector (1 downto 0));
   end component;
   
   component MuxT16
      port ( InputA  : in    std_logic_vector (15 downto 0); 
             InputB  : in    std_logic_vector (15 downto 0); 
             InputC  : in    std_logic_vector (15 downto 0); 
             control : in    std_logic_vector (1 downto 0); 
             Output  : out   std_logic_vector (15 downto 0));
   end component;
   
   component Adder16
      port ( InputA : in    std_logic_vector (15 downto 0); 
             InputB : in    std_logic_vector (15 downto 0); 
             Output : out   std_logic_vector (15 downto 0));
   end component;
   
   component TControl
      port ( RegTWrite : in    std_logic; 
             TType     : in    std_logic; 
             clock     : in    std_logic; 
             ALUResult : in    std_logic_vector (15 downto 0); 
             T         : out   std_logic);
   end component;
   
   component BranchSelector
      port ( TInput    : in    std_logic; 
             RegAInput : in    std_logic_vector (15 downto 0); 
             InstInput : in    std_logic_vector (15 downto 0); 
             Output    : out   std_logic_vector (1 downto 0));
   end component;
   
   component PCReg
      port ( clk     : in    std_logic; 
             rst     : in    std_logic; 
             Input   : in    std_logic_vector (15 downto 0); 
             Output  : out   std_logic_vector (15 downto 0); 
             WriteIN : in    std_logic);
   end component;
   
   component PCPlus1
      port ( Input  : in    std_logic_vector (15 downto 0); 
             Output : out   std_logic_vector (15 downto 0));
   end component;
   
   component leder
      port ( clock   : in    std_logic; 
             input16 : in    std_logic_vector (15 downto 0); 
             led1    : out   std_logic_vector (6 downto 0); 
             led2    : out   std_logic_vector (6 downto 0));
   end component;
   
   component LED16
      port ( INPUT      : in    std_logic_vector (15 downto 0); 
             LED_OUTPUT : out   std_logic_vector (15 downto 0));
   end component;
   
   component SmartClock
      port ( AutoCLK   : in    std_logic; 
             clk       : in    std_logic; 
             automatic : in    std_logic; 
             out_clock : out   std_logic);
   end component;
   
   component MemoryController
      port ( clock              : in    std_logic; 
             MemWrite           : in    std_logic; 
             MemRead            : in    std_logic; 
             serialDATA_READY   : in    std_logic; 
             serialTSRE         : in    std_logic; 
             serialTBRE         : in    std_logic; 
             reset              : in    std_logic; 
             address1           : in    std_logic_vector (15 downto 0); 
             address2           : in    std_logic_vector (15 downto 0); 
             dataInput          : in    std_logic_vector (15 downto 0); 
             extendDatabus      : inout std_logic_vector (15 downto 0); 
             basicDatabus       : inout std_logic_vector (7 downto 0); 
             flash_data         : inout std_logic_vector (15 downto 0); 
             stdClock           : out   std_logic; 
             memoryEN           : out   std_logic; 
             memoryOE           : out   std_logic; 
             memoryRW           : out   std_logic; 
             serialWRN          : out   std_logic; 
             serialRDN          : out   std_logic; 
             ram1EN             : out   std_logic; 
             flash_byte         : out   std_logic; 
             flash_vpen         : out   std_logic; 
             flash_ce           : out   std_logic; 
             flash_oe           : out   std_logic; 
             flash_we           : out   std_logic; 
             flash_rp           : out   std_logic; 
             output1            : out   std_logic_vector (15 downto 0); 
             output2            : out   std_logic_vector (15 downto 0); 
             memoryAddress      : out   std_logic_vector (17 downto 0); 
             flash_addr         : out   std_logic_vector (22 downto 1); 
             VGA_addr           : out   std_logic_vector (9 downto 0); 
             VGA_write          : out   std_logic_vector (0 downto 0); 
             VGA_char           : out   std_logic_vector (7 downto 0); 
             Keyboard_Dataready : in    std_logic; 
             Keyboard_Data      : in    std_logic_vector (5 downto 0); 
             Keyboard_wrn       : out   std_logic);
   end component;
   
   component DebugInputPort
      port ( KEY_INPUT      : in    std_logic_vector (15 downto 0); 
             Output0_3      : out   std_logic_vector (3 downto 0); 
             ClockSelection : out   std_logic);
   end component;
   
   component Logger
      port ( Input1 : in    std_logic; 
             Input2 : in    std_logic; 
             Input3 : in    std_logic; 
             Input4 : in    std_logic; 
             Input5 : in    std_logic; 
             Output : out   std_logic_vector (15 downto 0));
   end component;
   
   component IDRegABypass
      port ( ALURegWrite : in    std_logic; 
             MemRegWrite : in    std_logic; 
             RegA        : in    std_logic_vector (15 downto 0); 
             SelectA     : in    std_logic_vector (3 downto 0); 
             ALURegA     : in    std_logic_vector (15 downto 0); 
             MemRegA     : in    std_logic_vector (15 downto 0); 
             ALUDest     : in    std_logic_vector (3 downto 0); 
             MemDest     : in    std_logic_vector (3 downto 0); 
             RegAOutput  : out   std_logic_vector (15 downto 0));
   end component;
   
   component HazardDetection
      port ( IDEXMemRead : in    std_logic; 
             Instruction : in    std_logic_vector (15 downto 0); 
             PCWrite     : out   std_logic; 
             IFIDWrite   : out   std_logic; 
             CtrlSignal  : out   std_logic; 
             IDEXRegDest : in    std_logic_vector (3 downto 0));
   end component;
   
   component vga_ram
      port ( reset     : in    std_logic; 
             clk_0     : in    std_logic; 
             hs        : out   std_logic; 
             vs        : out   std_logic; 
             r         : out   std_logic_vector (2 downto 0); 
             g         : out   std_logic_vector (2 downto 0); 
             b         : out   std_logic_vector (2 downto 0); 
             addr10_in : in    std_logic_vector (9 downto 0); 
             char_in   : in    std_logic_vector (7 downto 0); 
             wea_in    : in    std_logic_vector (0 downto 0));
   end component;
   
   component top
      port ( datain        : in    std_logic; 
             clkin         : in    std_logic; 
             clk50         : in    std_logic; 
             rst_in        : in    std_logic; 
             datareceived  : in    std_logic; 
             dataready_out : out   std_logic; 
             out_rank      : out   std_logic_vector (5 downto 0));
   end component;
   
begin
   memoryOE <= memoryOE_DUMMY;
   memoryRW <= memoryRW_DUMMY;
   serialRDN <= serialRDN_DUMMY;
   serialWRN <= serialWRN_DUMMY;
   cpu_RegisterFile : RegisterFile
      port map (clock=>CPU_CLOCK,
                DebugInput(3 downto 0)=>cpu_RegisterFile_DebugInput(3 downto 0),
                InputData(15 downto 0)=>cpu_RegisterFile_InputData(15 downto 0),
                PCInput(15 downto 0)=>cpu_RegisterFile_PCInput(15 downto 0),
                RegWrite=>cpu_RegisterFile_RegWrite,
                SelectA(3 downto 0)=>cpu_RegisterFile_SelectA(3 downto 0),
                SelectB(3 downto 0)=>cpu_RegisterFile_SelectB(3 downto 0),
                SelectC(3 downto 0)=>cpu_RegisterFile_SelectC(3 downto 0),
                DebugOutput=>open,
                RegA(15 downto 0)=>cpu_RegisterFile_RegA(15 downto 0),
                RegB(15 downto 0)=>cpu_RegisterFile_RegB(15 downto 0));
   
   cpu_Controller : Controller
      port map (InstructionInput(15 downto 0)=>instruction(15 downto 0),
                ALUOp(2 downto 0)=>cpu_Controller_ALUOp(2 downto 0),
                ALUSrc1=>cpu_Controller_ALUSrc1,
                ALUSrc2=>cpu_Controller_ALUSrc2,
                MemRead=>cpu_Controller_MemRead,
                MemtoReg=>cpu_Controller_MemtoReg,
                MemWrite=>cpu_Controller_MemWrite,
                RegDst(3 downto 0)=>cpu_Controller_RegDst(3 downto 0),
                RegtoMem=>cpu_Controller_RegtoMem,
                RegTWrite=>cpu_Controller_RegTWrite,
                RegWrite=>cpu_Controller_RegWrite,
                Src1(3 downto 0)=>cpu_RegisterFile_SelectA(3 downto 0),
                Src2(3 downto 0)=>cpu_RegisterFile_SelectB(3 downto 0),
                TType=>cpu_Controller_TType);
   
   cpu_IFID : IFID
      port map (clock=>CPU_CLOCK,
                InstructionInput(15 downto 0)=>cpu_IFID_InstructionInput(15 downto 0),
                PCInput(15 downto 0)=>cpu_IFID_PCInput(15 downto 0),
                rst=>reset,
                WriteIN=>cpu_IFID_WriteIN,
                InstructionOutput(15 downto 0)=>instruction(15 downto 0),
                PCOutput(15 downto 0)=>cpu_RegisterFile_PCInput(15 downto 0));
   
   cpu_SignedExtend_1 : SignedExtend
      port map (Instruction(15 downto 0)=>instruction(15 downto 0),
                ExtendedAddress(15 downto 0)=>Extend(15 downto 0));
   
   cpu_IDEX : IDEX
      port map (ALUOPInput(2 downto 0)=>cpu_Controller_ALUOp(2 downto 0),
                ALUSrc1Input=>cpu_Controller_ALUSrc1,
                ALUSrc2Input=>cpu_Controller_ALUSrc2,
                clock=>CPU_CLOCK,
                ExtendedAddressInput(15 downto 0)=>Extend(15 downto 0),
                MemReadInput=>cpu_Controller_MemRead,
                MemtoRegInput=>cpu_Controller_MemtoReg,
                MemWriteInput=>cpu_Controller_MemWrite,
                RegAInput(15 downto 0)=>cpu_RegisterFile_RegA(15 downto 0),
                RegBInput(15 downto 0)=>cpu_RegisterFile_RegB(15 downto 0),
                RegDstInput(3 downto 0)=>cpu_Controller_RegDst(3 downto 0),
                RegtoMemInput=>cpu_Controller_RegtoMem,
                RegTWriteInput=>cpu_Controller_RegTWrite,
                RegWriteInput=>cpu_Controller_RegWrite,
                rst=>reset,
                Src1Input(3 downto 0)=>cpu_RegisterFile_SelectA(3 downto 0),
                Src2Input(3 downto 0)=>cpu_RegisterFile_SelectB(3 downto 0),
                TTypeInput=>cpu_Controller_TType,
                ALUOPOutput(2 downto 0)=>cpu_IDEX_ALUOPOutput(2 downto 0),
                ALUSrc1Output=>cpu_IDEX_ALUSrc1Output,
                ALUSrc2Output=>cpu_IDEX_ALUSrc2Output,
                ExtendedAddressOutput(15 downto 0)=>cpu_IDEX_ExtendedAddressOutput(15 downto 0),
                MemReadOutput=>cpu_IDEX_MemReadOutput,
                MemtoRegOutput=>cpu_IDEX_MemtoRegOutput,
                MemWriteOutput=>cpu_IDEX_MemWriteOutput,
                RegAOutput(15 downto 0)=>cpu_IDEX_RegAOutput(15 downto 0),
                RegBOutput(15 downto 0)=>cpu_IDEX_RegBOutput(15 downto 0),
                RegDstOutput(3 downto 0)=>cpu_IDEX_RegDstOutput(3 downto 0),
                RegtoMemOutput=>cpu_IDEX_RegtoMemOutput,
                RegTWriteOutput=>cpu_IDEX_RegTWriteOutput,
                RegWriteOutput=>cpu_IDEX_RegWriteOutput,
                Src1Output(3 downto 0)=>cpu_IDEX_Src1Output(3 downto 0),
                Src2Output(3 downto 0)=>cpu_IDEX_Src2Output(3 downto 0),
                TTypeOutput=>cpu_IDEX_TTypeOutput);
   
   cpu_ALU : ALU
      port map (dataA(15 downto 0)=>cpu_ALU_dataA(15 downto 0),
                dataB(15 downto 0)=>cpu_ALU_dataB(15 downto 0),
                operation(2 downto 0)=>cpu_IDEX_ALUOPOutput(2 downto 0),
                result(15 downto 0)=>cpu_ALU_result(15 downto 0));
   
   cpu_Mux16_1 : Mux16
      port map (control1=>cpu_IDEX_ALUSrc2Output,
                InputA(15 downto 0)=>cpu_Mux16_1_InputA(15 downto 0),
                InputB(15 downto 0)=>cpu_IDEX_ExtendedAddressOutput(15 downto 0),
                Output(15 downto 0)=>cpu_ALU_dataB(15 downto 0));
   cpu_Mux16_2 : Mux16
      port map (control1=>cpu_IDEX_ALUSrc1Output,
                InputA(15 downto 0)=>cpu_Mux16_2_InputA(15 downto 0),
                InputB(15 downto 0)=>cpu_IDEX_ExtendedAddressOutput(15 downto 0),
                Output(15 downto 0)=>cpu_ALU_dataA(15 downto 0));
   
   cpu_Mux16_3 : Mux16
      port map (control1=>cpu_IDEX_RegtoMemOutput,
                InputA(15 downto 0)=>cpu_Mux16_2_InputA(15 downto 0),
                InputB(15 downto 0)=>cpu_Mux16_1_InputA(15 downto 0),
                Output(15 downto 0)=>cpu_Mux16_3_Output(15 downto 0));

   cpu_Mux16_4 : Mux16
      port map (control1=>cpu_Mux16_4_control1,
                InputA(15 downto 0)=>cpu_Mux16_4_InputA(15 downto 0),
                InputB(15 downto 0)=>cpu_Mux16_4_InputB(15 downto 0),
                Output(15 downto 0)=>cpu_Mux16_4_Output(15 downto 0));
   
   
   cpu_EX_MEM : EX_MEM
      port map (AddressInput(15 downto 0)=>cpu_ALU_result(15 downto 0),
                clock=>CPU_CLOCK,
                DataInput(15 downto 0)=>cpu_Mux16_3_Output(15 downto 0),
                MemReadInput=>cpu_IDEX_MemReadOutput,
                MemtoRegInput=>cpu_IDEX_MemtoRegOutput,
                MemWriteInput=>cpu_IDEX_MemWriteOutput,
                RegDestInput(3 downto 0)=>cpu_IDEX_RegDstOutput(3 downto 0),
                RegWriteInput=>cpu_IDEX_RegWriteOutput,
                rst=>reset,
                AddressOutput(15 downto 0)=>cpu_Mux16_4_InputA(15 downto 0),
                DataOutput(15 downto 0)=>cpu_EX_MEM_DataOutput(15 downto 0),
                MemReadOutput=>cpu_EX_MEM_MemReadOutput,
                MemtoRegOutput=>cpu_Mux16_4_control1,
                MemWriteOutput=>cpu_EX_MEM_MemWriteOutput,
                RegDestOutput(3 downto 0)=>cpu_EX_MEM_RegDestOutput(3 downto 0),
                RegWriteOutput=>cpu_EX_MEM_RegWriteOutput);
   
   cpu_MEM_WB : MEM_WB
      port map (ALUDataInput(15 downto 0)=>cpu_Mux16_4_Output(15 downto 0),
                clock=>CPU_CLOCK,
                MemtoRegInput=>cpu_MEM_WB_MemtoRegInput_openSignal,
                ReadDataInput(15 downto 0)=>cpu_MEM_WB_ReadDataInput_openSignal(15 
            downto 0),
                RegDestInput(3 downto 0)=>cpu_EX_MEM_RegDestOutput(3 downto 0),
                RegWriteInput=>cpu_EX_MEM_RegWriteOutput,
                rst=>reset,
                ALUDataOutput(15 downto 0)=>cpu_RegisterFile_InputData(15 downto 0),
                MemtoRegOutput=>open,
                ReadDataOutput=>open,
                RegDestOutput(3 downto 0)=>cpu_RegisterFile_SelectC(3 downto 0),
                RegWriteOutput=>cpu_RegisterFile_RegWrite);
   
   cpu_bypassControl : bypassControl
      port map (EX_MEMRdInput(3 downto 0)=>cpu_EX_MEM_RegDestOutput(3 downto 0),
                EX_MEMRegWriteInput=>cpu_EX_MEM_RegWriteOutput,
                Mem_WBRdInput(3 downto 0)=>cpu_RegisterFile_SelectC(3 downto 0),
                MEM_WBRegWriteInput=>cpu_RegisterFile_RegWrite,
                RegAInput(3 downto 0)=>cpu_IDEX_Src1Output(3 downto 0),
                RegBInput(3 downto 0)=>cpu_IDEX_Src2Output(3 downto 0),
                RegASelectOutput(1 downto 0)=>cpu_bypassControl_RegASelectOutput(1 downto 0),
                RegBSelectOutput(1 downto 0)=>cpu_bypassControl_RegBSelectOutput(1 downto 0));
   
   cpu_MuxT16_1 : MuxT16
      port map (control(1 downto 0)=>cpu_bypassControl_RegASelectOutput(1 downto 0),
                InputA(15 downto 0)=>cpu_IDEX_RegAOutput(15 downto 0),
                InputB(15 downto 0)=>cpu_Mux16_4_InputA(15 downto 0),
                InputC(15 downto 0)=>cpu_RegisterFile_InputData(15 downto 0),
                Output(15 downto 0)=>cpu_Mux16_2_InputA(15 downto 0));
   
   cpu_MuxT16_2 : MuxT16
      port map (control(1 downto 0)=>cpu_bypassControl_RegBSelectOutput(1 downto 0),
                InputA(15 downto 0)=>cpu_IDEX_RegBOutput(15 downto 0),
                InputB(15 downto 0)=>cpu_Mux16_4_InputA(15 downto 0),
                InputC(15 downto 0)=>cpu_RegisterFile_InputData(15 downto 0),
                Output(15 downto 0)=>cpu_Mux16_1_InputA(15 downto 0));
   
   cpu_MuxT16_3 : MuxT16
      port map (control(1 downto 0)=>cpu_MuxT16_3_control(1 downto 0),
                InputA(15 downto 0)=>cpu_IFID_PCInput(15 downto 0),
                InputB(15 downto 0)=>cpu_MuxT16_3_InputB(15 downto 0),
                InputC(15 downto 0)=>cpu_MuxT16_3_InputC(15 downto 0),
                Output(15 downto 0)=>cpu_MuxT16_3_Output(15 downto 0));
   
   cpu_Adder16 : Adder16
      port map (InputA(15 downto 0)=>cpu_RegisterFile_PCInput(15 downto 0),
                InputB(15 downto 0)=>Extend(15 downto 0),
                Output(15 downto 0)=>cpu_MuxT16_3_InputB(15 downto 0));
   
   cpu_TControl : TControl
      port map (ALUResult(15 downto 0)=>cpu_ALU_result(15 downto 0),
                clock=>CPU_CLOCK,
                RegTWrite=>cpu_IDEX_RegTWriteOutput,
                TType=>cpu_IDEX_TTypeOutput,
                T=>cpu_TControl_T);
   
   cpu_BranchSelector : BranchSelector
      port map (InstInput(15 downto 0)=>instruction(15 downto 0),
                RegAInput(15 downto 0)=>cpu_MuxT16_3_InputC(15 downto 0),
                TInput=>cpu_TControl_T,
                Output(1 downto 0)=>cpu_MuxT16_3_control(1 downto 0));
   
   cpu_PCReg : PCReg
      port map (clk=>CPU_CLOCK,
                Input(15 downto 0)=>cpu_MuxT16_3_Output(15 downto 0),
                rst=>reset,
                WriteIN=>cpu_PCReg_WriteIN,
                Output(15 downto 0)=>cpu_PCReg_Output(15 downto 0));
   
   cpu_PCPlus1 : PCPlus1
      port map (Input(15 downto 0)=>cpu_PCReg_Output(15 downto 0),
                Output(15 downto 0)=>cpu_IFID_PCInput(15 downto 0));
   
   cpu_leder : leder
      port map (clock=>CLOCK_11M,
                input16(15 downto 0)=>cpu_PCReg_Output(15 downto 0),
                led1(6 downto 0)=>led1(6 downto 0),
                led2(6 downto 0)=>led2(6 downto 0));
   
   cpu_LED16 : LED16
      port map (INPUT(15 downto 0)=>cpu_LED16_INPUT(15 downto 0),
                LED_OUTPUT(15 downto 0)=>LED_OUTPUT(15 downto 0));
   
   cpu_SmartClock : SmartClock
      port map (AutoCLK=>CLOCK_50M,
                automatic=>cpu_SmartClock_automatic,
                clk=>InputClock,
                out_clock=>cpu_SmartClock_out_clock);
   
   cpu_MemoryController : MemoryController
      port map (address1(15 downto 0)=>cpu_PCReg_Output(15 downto 0),
                address2(15 downto 0)=>cpu_Mux16_4_InputA(15 downto 0),
                clock=>cpu_SmartClock_out_clock,
                dataInput(15 downto 0)=>cpu_EX_MEM_DataOutput(15 downto 0),
                Keyboard_Data(5 downto 0)=>cpu_MemoryController_Keyboard_Data(5 downto 0),
                Keyboard_Dataready=>cpu_MemoryController_Keyboard_Dataready,
                MemRead=>cpu_EX_MEM_MemReadOutput,
                MemWrite=>cpu_EX_MEM_MemWriteOutput,
                reset=>reset,
                serialDATA_READY=>dataReady,
                serialTBRE=>serialTBRE,
                serialTSRE=>serialTSRE,
                flash_addr(22 downto 1)=>flash_addr(22 downto 1),
                flash_byte=>flash_byte,
                flash_ce=>flash_ce,
                flash_oe=>flash_oe,
                flash_rp=>flash_rp,
                flash_vpen=>flash_vpen,
                flash_we=>flash_we,
                Keyboard_wrn=>cpu_MemoryController_Keyboard_wrn,
                memoryAddress(17 downto 0)=>memoryAddress(17 downto 0),
                memoryEN=>memoryEN,
                memoryOE=>memoryOE_DUMMY,
                memoryRW=>memoryRW_DUMMY,
                output1(15 downto 0)=>cpu_IFID_InstructionInput(15 downto 0),
                output2(15 downto 0)=>cpu_Mux16_4_InputB(15 downto 0),
                ram1EN=>ram1EN,
                serialRDN=>serialRDN_DUMMY,
                serialWRN=>serialWRN_DUMMY,
                stdClock=>CPU_CLOCK,
                VGA_addr(9 downto 0)=>cpu_MemoryController_VGA_addr(9 downto 0),
                VGA_char(7 downto 0)=>cpu_MemoryController_VGA_char(7 downto 0),
                VGA_write(0)=>cpu_MemoryController_VGA_write(0),
                basicDatabus(7 downto 0)=>basicDatabus(7 downto 0),
                extendDatabus(15 downto 0)=>memoryDatabus(15 downto 0),
                flash_data(15 downto 0)=>flash_data(15 downto 0));
   
   cpu_DebugInputPort : DebugInputPort
      port map (KEY_INPUT(15 downto 0)=>KEY16_INPUT(15 downto 0),
                ClockSelection=>cpu_SmartClock_automatic,
                Output0_3(3 downto 0)=>cpu_RegisterFile_DebugInput(3 downto 0));
   
   cpu_Logger : Logger
      port map (Input1=>cpu_MemoryController_Keyboard_Dataready,
                Input2=>memoryOE_DUMMY,
                Input3=>memoryRW_DUMMY,
                Input4=>serialWRN_DUMMY,
                Input5=>serialRDN_DUMMY,
                Output(15 downto 0)=>cpu_LED16_INPUT(15 downto 0));
   
   cpu_IDRegABypass : IDRegABypass
      port map (ALUDest(3 downto 0)=>cpu_IDEX_RegDstOutput(3 downto 0),
                ALURegA(15 downto 0)=>cpu_ALU_result(15 downto 0),
                ALURegWrite=>cpu_IDEX_RegWriteOutput,
                MemDest(3 downto 0)=>cpu_EX_MEM_RegDestOutput(3 downto 0),
                MemRegA(15 downto 0)=>cpu_Mux16_4_Output(15 downto 0),
                MemRegWrite=>cpu_EX_MEM_RegWriteOutput,
                RegA(15 downto 0)=>cpu_RegisterFile_RegA(15 downto 0),
                SelectA(3 downto 0)=>cpu_RegisterFile_SelectA(3 downto 0),
                RegAOutput(15 downto 0)=>cpu_MuxT16_3_InputC(15 downto 0));
   
   cpu_HazardDetection : HazardDetection
      port map (IDEXMemRead=>cpu_IDEX_MemReadOutput,
                IDEXRegDest(3 downto 0)=>cpu_Controller_RegDst(3 downto 0),
                Instruction(15 downto 0)=>instruction(15 downto 0),
                CtrlSignal=>open,
                IFIDWrite=>cpu_IFID_WriteIN,
                PCWrite=>cpu_PCReg_WriteIN);
   
   cpu_SignedExtend_2 : SignedExtend
      port map (Instruction(15 downto 0)=>cpu_SignedExtend_2_MemtoRegInput_openSignal(15 
            downto 0),
                ExtendedAddress=>open);
   
   cpu_vga_ram : vga_ram
      port map (addr10_in(9 downto 0)=>cpu_MemoryController_VGA_addr(9 downto 0),
                char_in(7 downto 0)=>cpu_MemoryController_VGA_char(7 downto 0),
                clk_0=>CLOCK_50M,
                reset=>reset,
                wea_in(0)=>cpu_MemoryController_VGA_write(0),
                b(2 downto 0)=>VGA_b(2 downto 0),
                g(2 downto 0)=>VGA_g(2 downto 0),
                hs=>VGA_hs,
                r(2 downto 0)=>VGA_r(2 downto 0),
                vs=>VGA_vs);
   
   cpu_top : top
      port map (clkin=>keyboard_in,
                clk50=>CLOCK_50M,
                datain=>keyboard_data,
                datareceived=>cpu_MemoryController_Keyboard_wrn,
                rst_in=>reset,
                dataready_out=>cpu_MemoryController_Keyboard_Dataready,
                out_rank(5 downto 0)=>cpu_MemoryController_Keyboard_Data(5 downto 0));
   
end BEHAVIORAL;


