--------------------------------------------------------------------------------
-- Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.4
--  \   \         Application : sch2hdl
--  /   /         Filename : Project.vhf
-- /___/   /\     Timestamp : 12/04/2013 00:00:15
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: /home/pithorn/Xilinx/14.4/ISE_DS/ISE/bin/lin64/unwrapped/sch2hdl -intstyle ise -family spartan3e -flat -suppress -vhdl Project.vhf -w /home/pithorn/git/MIPS-CPU-System/Project/Project.sch
--Design Name: Project
--Device: spartan3e
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

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
   signal XLXN_209                         : std_logic_vector (15 downto 0);
   signal XLXN_374                         : std_logic;
   signal XLXN_577                         : std_logic_vector (1 downto 0);
   signal XLXN_578                         : std_logic;
   signal XLXN_598                         : std_logic;
   signal XLXN_661                         : std_logic_vector (15 downto 0);
   signal XLXN_668                         : std_logic_vector (3 downto 0);
   signal XLXN_669                         : std_logic_vector (3 downto 0);
   signal XLXN_701                         : std_logic;
   signal XLXN_702                         : std_logic;
   signal XLXN_703                         : std_logic;
   signal XLXN_704                         : std_logic;
   signal XLXN_705                         : std_logic;
   signal XLXN_706                         : std_logic_vector (2 downto 0);
   signal XLXN_707                         : std_logic;
   signal XLXN_708                         : std_logic;
   signal XLXN_709                         : std_logic;
   signal XLXN_710                         : std_logic;
   signal XLXN_711                         : std_logic_vector (3 downto 0);
   signal XLXN_712                         : std_logic_vector (15 downto 0);
   signal XLXN_713                         : std_logic;
   signal XLXN_714                         : std_logic;
   signal XLXN_716                         : std_logic;
   signal XLXN_722                         : std_logic;
   signal XLXN_724                         : std_logic;
   signal XLXN_727                         : std_logic_vector (15 downto 0);
   signal XLXN_728                         : std_logic_vector (15 downto 0);
   signal XLXN_730                         : std_logic_vector (3 downto 0);
   signal XLXN_731                         : std_logic_vector (1 downto 0);
   signal XLXN_732                         : std_logic_vector (1 downto 0);
   signal XLXN_733                         : std_logic_vector (3 downto 0);
   signal XLXN_736                         : std_logic_vector (3 downto 0);
   signal XLXN_739                         : std_logic_vector (15 downto 0);
   signal XLXN_741                         : std_logic_vector (15 downto 0);
   signal XLXN_743                         : std_logic;
   signal XLXN_744                         : std_logic_vector (15 downto 0);
   signal XLXN_745                         : std_logic_vector (15 downto 0);
   signal XLXN_759                         : std_logic_vector (2 downto 0);
   signal XLXN_760                         : std_logic_vector (3 downto 0);
   signal XLXN_768                         : std_logic_vector (15 downto 0);
   signal XLXN_851                         : std_logic;
   signal XLXN_855                         : std_logic;
   signal XLXN_856                         : std_logic;
   signal XLXN_871                         : std_logic_vector (15 downto 0);
   signal XLXN_981                         : std_logic_vector (3 downto 0);
   signal XLXN_984                         : std_logic_vector (15 downto 0);
   signal XLXN_985                         : std_logic_vector (3 downto 0);
   signal XLXN_992                         : std_logic_vector (15 downto 0);
   signal XLXN_995                         : std_logic_vector (15 downto 0);
   signal XLXN_998                         : std_logic_vector (15 downto 0);
   signal XLXN_999                         : std_logic_vector (15 downto 0);
   signal XLXN_1004                        : std_logic_vector (15 downto 0);
   signal XLXN_1007                        : std_logic;
   signal XLXN_1008                        : std_logic;
   signal XLXN_1009                        : std_logic_vector (15 downto 0);
   signal XLXN_1011                        : std_logic_vector (15 downto 0);
   signal XLXN_1014                        : std_logic;
   signal XLXN_1021                        : std_logic_vector (15 downto 0);
   signal XLXN_1024                        : std_logic_vector (15 downto 0);
   signal XLXN_1028                        : std_logic;
   signal XLXN_1032                        : std_logic;
   signal XLXN_1042                        : std_logic;
   signal XLXN_1043                        : std_logic_vector (15 downto 0);
   signal XLXN_1045                        : std_logic_vector (15 downto 0);
   signal XLXN_1074                        : std_logic;
   signal XLXN_1075                        : std_logic_vector (15 downto 0);
   signal XLXN_1122                        : std_logic_vector (0 downto 0);
   signal XLXN_1123                        : std_logic_vector (9 downto 0);
   signal XLXN_1124                        : std_logic_vector (7 downto 0);
   signal XLXN_1125                        : std_logic;
   signal XLXN_1126                        : std_logic_vector (5 downto 0);
   signal XLXN_1127                        : std_logic;
   signal memoryOE_DUMMY                   : std_logic;
   signal serialRDN_DUMMY                  : std_logic;
   signal memoryRW_DUMMY                   : std_logic;
   signal serialWRN_DUMMY                  : std_logic;
   signal XLXI_46_MemtoRegInput_openSignal : std_logic;
   signal XLXI_46_ReadDataInput_openSignal : std_logic_vector (15 downto 0);
   signal XLXI_82_Instruction_openSignal   : std_logic_vector (15 downto 0);
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
   XLXI_4 : RegisterFile
      port map (clock=>CPU_CLOCK,
                DebugInput(3 downto 0)=>XLXN_981(3 downto 0),
                InputData(15 downto 0)=>XLXN_995(15 downto 0),
                PCInput(15 downto 0)=>XLXN_745(15 downto 0),
                RegWrite=>XLXN_374,
                SelectA(3 downto 0)=>XLXN_668(3 downto 0),
                SelectB(3 downto 0)=>XLXN_669(3 downto 0),
                SelectC(3 downto 0)=>XLXN_985(3 downto 0),
                DebugOutput=>open,
                RegA(15 downto 0)=>XLXN_1004(15 downto 0),
                RegB(15 downto 0)=>XLXN_661(15 downto 0));
   
   XLXI_5 : Controller
      port map (InstructionInput(15 downto 0)=>instruction(15 downto 0),
                ALUOp(2 downto 0)=>XLXN_706(2 downto 0),
                ALUSrc1=>XLXN_708,
                ALUSrc2=>XLXN_709,
                MemRead=>XLXN_702,
                MemtoReg=>XLXN_705,
                MemWrite=>XLXN_703,
                RegDst(3 downto 0)=>XLXN_711(3 downto 0),
                RegtoMem=>XLXN_710,
                RegTWrite=>XLXN_707,
                RegWrite=>XLXN_704,
                Src1(3 downto 0)=>XLXN_668(3 downto 0),
                Src2(3 downto 0)=>XLXN_669(3 downto 0),
                TType=>XLXN_701);
   
   XLXI_6 : IFID
      port map (clock=>CPU_CLOCK,
                InstructionInput(15 downto 0)=>XLXN_1075(15 downto 0),
                PCInput(15 downto 0)=>XLXN_209(15 downto 0),
                rst=>reset,
                WriteIN=>XLXN_1074,
                InstructionOutput(15 downto 0)=>instruction(15 downto 0),
                PCOutput(15 downto 0)=>XLXN_745(15 downto 0));
   
   XLXI_7 : SignedExtend
      port map (Instruction(15 downto 0)=>instruction(15 downto 0),
                ExtendedAddress(15 downto 0)=>Extend(15 downto 0));
   
   XLXI_8 : IDEX
      port map (ALUOPInput(2 downto 0)=>XLXN_706(2 downto 0),
                ALUSrc1Input=>XLXN_708,
                ALUSrc2Input=>XLXN_709,
                clock=>CPU_CLOCK,
                ExtendedAddressInput(15 downto 0)=>Extend(15 downto 0),
                MemReadInput=>XLXN_702,
                MemtoRegInput=>XLXN_705,
                MemWriteInput=>XLXN_703,
                RegAInput(15 downto 0)=>XLXN_1004(15 downto 0),
                RegBInput(15 downto 0)=>XLXN_661(15 downto 0),
                RegDstInput(3 downto 0)=>XLXN_711(3 downto 0),
                RegtoMemInput=>XLXN_710,
                RegTWriteInput=>XLXN_707,
                RegWriteInput=>XLXN_704,
                rst=>reset,
                Src1Input(3 downto 0)=>XLXN_668(3 downto 0),
                Src2Input(3 downto 0)=>XLXN_669(3 downto 0),
                TTypeInput=>XLXN_701,
                ALUOPOutput(2 downto 0)=>XLXN_759(2 downto 0),
                ALUSrc1Output=>XLXN_713,
                ALUSrc2Output=>XLXN_714,
                ExtendedAddressOutput(15 downto 0)=>XLXN_728(15 downto 0),
                MemReadOutput=>XLXN_1032,
                MemtoRegOutput=>XLXN_724,
                MemWriteOutput=>XLXN_722,
                RegAOutput(15 downto 0)=>XLXN_984(15 downto 0),
                RegBOutput(15 downto 0)=>XLXN_727(15 downto 0),
                RegDstOutput(3 downto 0)=>XLXN_730(3 downto 0),
                RegtoMemOutput=>XLXN_743,
                RegTWriteOutput=>XLXN_598,
                RegWriteOutput=>XLXN_1007,
                Src1Output(3 downto 0)=>XLXN_733(3 downto 0),
                Src2Output(3 downto 0)=>XLXN_736(3 downto 0),
                TTypeOutput=>XLXN_716);
   
   XLXI_24 : ALU
      port map (dataA(15 downto 0)=>XLXN_1021(15 downto 0),
                dataB(15 downto 0)=>XLXN_992(15 downto 0),
                operation(2 downto 0)=>XLXN_759(2 downto 0),
                result(15 downto 0)=>XLXN_1045(15 downto 0));
   
   XLXI_25 : Mux16
      port map (control1=>XLXN_714,
                InputA(15 downto 0)=>XLXN_739(15 downto 0),
                InputB(15 downto 0)=>XLXN_728(15 downto 0),
                Output(15 downto 0)=>XLXN_992(15 downto 0));
   
   XLXI_27 : EX_MEM
      port map (AddressInput(15 downto 0)=>XLXN_1045(15 downto 0),
                clock=>CPU_CLOCK,
                DataInput(15 downto 0)=>XLXN_744(15 downto 0),
                MemReadInput=>XLXN_1032,
                MemtoRegInput=>XLXN_724,
                MemWriteInput=>XLXN_722,
                RegDestInput(3 downto 0)=>XLXN_730(3 downto 0),
                RegWriteInput=>XLXN_1007,
                rst=>reset,
                AddressOutput(15 downto 0)=>XLXN_999(15 downto 0),
                DataOutput(15 downto 0)=>XLXN_871(15 downto 0),
                MemReadOutput=>XLXN_855,
                MemtoRegOutput=>XLXN_1008,
                MemWriteOutput=>XLXN_856,
                RegDestOutput(3 downto 0)=>XLXN_760(3 downto 0),
                RegWriteOutput=>XLXN_1014);
   
   XLXI_46 : MEM_WB
      port map (ALUDataInput(15 downto 0)=>XLXN_1011(15 downto 0),
                clock=>CPU_CLOCK,
                MemtoRegInput=>XLXI_46_MemtoRegInput_openSignal,
                ReadDataInput(15 downto 0)=>XLXI_46_ReadDataInput_openSignal(15 
            downto 0),
                RegDestInput(3 downto 0)=>XLXN_760(3 downto 0),
                RegWriteInput=>XLXN_1014,
                rst=>reset,
                ALUDataOutput(15 downto 0)=>XLXN_995(15 downto 0),
                MemtoRegOutput=>open,
                ReadDataOutput=>open,
                RegDestOutput(3 downto 0)=>XLXN_985(3 downto 0),
                RegWriteOutput=>XLXN_374);
   
   XLXI_50 : bypassControl
      port map (EX_MEMRdInput(3 downto 0)=>XLXN_760(3 downto 0),
                EX_MEMRegWriteInput=>XLXN_1014,
                Mem_WBRdInput(3 downto 0)=>XLXN_985(3 downto 0),
                MEM_WBRegWriteInput=>XLXN_374,
                RegAInput(3 downto 0)=>XLXN_733(3 downto 0),
                RegBInput(3 downto 0)=>XLXN_736(3 downto 0),
                RegASelectOutput(1 downto 0)=>XLXN_732(1 downto 0),
                RegBSelectOutput(1 downto 0)=>XLXN_731(1 downto 0));
   
   XLXI_51 : MuxT16
      port map (control(1 downto 0)=>XLXN_732(1 downto 0),
                InputA(15 downto 0)=>XLXN_984(15 downto 0),
                InputB(15 downto 0)=>XLXN_999(15 downto 0),
                InputC(15 downto 0)=>XLXN_995(15 downto 0),
                Output(15 downto 0)=>XLXN_741(15 downto 0));
   
   XLXI_52 : MuxT16
      port map (control(1 downto 0)=>XLXN_731(1 downto 0),
                InputA(15 downto 0)=>XLXN_727(15 downto 0),
                InputB(15 downto 0)=>XLXN_999(15 downto 0),
                InputC(15 downto 0)=>XLXN_995(15 downto 0),
                Output(15 downto 0)=>XLXN_739(15 downto 0));
   
   XLXI_53 : Adder16
      port map (InputA(15 downto 0)=>XLXN_745(15 downto 0),
                InputB(15 downto 0)=>Extend(15 downto 0),
                Output(15 downto 0)=>XLXN_712(15 downto 0));
   
   XLXI_54 : MuxT16
      port map (control(1 downto 0)=>XLXN_577(1 downto 0),
                InputA(15 downto 0)=>XLXN_209(15 downto 0),
                InputB(15 downto 0)=>XLXN_712(15 downto 0),
                InputC(15 downto 0)=>XLXN_1024(15 downto 0),
                Output(15 downto 0)=>XLXN_768(15 downto 0));
   
   XLXI_56 : TControl
      port map (ALUResult(15 downto 0)=>XLXN_1045(15 downto 0),
                clock=>CPU_CLOCK,
                RegTWrite=>XLXN_598,
                TType=>XLXN_716,
                T=>XLXN_578);
   
   XLXI_59 : Mux16
      port map (control1=>XLXN_713,
                InputA(15 downto 0)=>XLXN_741(15 downto 0),
                InputB(15 downto 0)=>XLXN_728(15 downto 0),
                Output(15 downto 0)=>XLXN_1021(15 downto 0));
   
   XLXI_60 : Mux16
      port map (control1=>XLXN_743,
                InputA(15 downto 0)=>XLXN_741(15 downto 0),
                InputB(15 downto 0)=>XLXN_739(15 downto 0),
                Output(15 downto 0)=>XLXN_744(15 downto 0));
   
   XLXI_63 : BranchSelector
      port map (InstInput(15 downto 0)=>instruction(15 downto 0),
                RegAInput(15 downto 0)=>XLXN_1024(15 downto 0),
                TInput=>XLXN_578,
                Output(1 downto 0)=>XLXN_577(1 downto 0));
   
   XLXI_64 : PCReg
      port map (clk=>CPU_CLOCK,
                Input(15 downto 0)=>XLXN_768(15 downto 0),
                rst=>reset,
                WriteIN=>XLXN_1028,
                Output(15 downto 0)=>XLXN_1043(15 downto 0));
   
   XLXI_65 : PCPlus1
      port map (Input(15 downto 0)=>XLXN_1043(15 downto 0),
                Output(15 downto 0)=>XLXN_209(15 downto 0));
   
   XLXI_66 : leder
      port map (clock=>CLOCK_11M,
                input16(15 downto 0)=>XLXN_1043(15 downto 0),
                led1(6 downto 0)=>led1(6 downto 0),
                led2(6 downto 0)=>led2(6 downto 0));
   
   XLXI_67 : LED16
      port map (INPUT(15 downto 0)=>XLXN_998(15 downto 0),
                LED_OUTPUT(15 downto 0)=>LED_OUTPUT(15 downto 0));
   
   XLXI_68 : SmartClock
      port map (AutoCLK=>CLOCK_50M,
                automatic=>XLXN_1042,
                clk=>InputClock,
                out_clock=>XLXN_851);
   
   XLXI_73 : MemoryController
      port map (address1(15 downto 0)=>XLXN_1043(15 downto 0),
                address2(15 downto 0)=>XLXN_999(15 downto 0),
                clock=>XLXN_851,
                dataInput(15 downto 0)=>XLXN_871(15 downto 0),
                Keyboard_Data(5 downto 0)=>XLXN_1126(5 downto 0),
                Keyboard_Dataready=>XLXN_1125,
                MemRead=>XLXN_855,
                MemWrite=>XLXN_856,
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
                Keyboard_wrn=>XLXN_1127,
                memoryAddress(17 downto 0)=>memoryAddress(17 downto 0),
                memoryEN=>memoryEN,
                memoryOE=>memoryOE_DUMMY,
                memoryRW=>memoryRW_DUMMY,
                output1(15 downto 0)=>XLXN_1075(15 downto 0),
                output2(15 downto 0)=>XLXN_1009(15 downto 0),
                ram1EN=>ram1EN,
                serialRDN=>serialRDN_DUMMY,
                serialWRN=>serialWRN_DUMMY,
                stdClock=>CPU_CLOCK,
                VGA_addr(9 downto 0)=>XLXN_1123(9 downto 0),
                VGA_char(7 downto 0)=>XLXN_1124(7 downto 0),
                VGA_write(0)=>XLXN_1122(0),
                basicDatabus(7 downto 0)=>basicDatabus(7 downto 0),
                extendDatabus(15 downto 0)=>memoryDatabus(15 downto 0),
                flash_data(15 downto 0)=>flash_data(15 downto 0));
   
   XLXI_75 : DebugInputPort
      port map (KEY_INPUT(15 downto 0)=>KEY16_INPUT(15 downto 0),
                ClockSelection=>XLXN_1042,
                Output0_3(3 downto 0)=>XLXN_981(3 downto 0));
   
   XLXI_76 : Logger
      port map (Input1=>XLXN_1125,
                Input2=>memoryOE_DUMMY,
                Input3=>memoryRW_DUMMY,
                Input4=>serialWRN_DUMMY,
                Input5=>serialRDN_DUMMY,
                Output(15 downto 0)=>XLXN_998(15 downto 0));
   
   XLXI_77 : IDRegABypass
      port map (ALUDest(3 downto 0)=>XLXN_730(3 downto 0),
                ALURegA(15 downto 0)=>XLXN_1045(15 downto 0),
                ALURegWrite=>XLXN_1007,
                MemDest(3 downto 0)=>XLXN_760(3 downto 0),
                MemRegA(15 downto 0)=>XLXN_1011(15 downto 0),
                MemRegWrite=>XLXN_1014,
                RegA(15 downto 0)=>XLXN_1004(15 downto 0),
                SelectA(3 downto 0)=>XLXN_668(3 downto 0),
                RegAOutput(15 downto 0)=>XLXN_1024(15 downto 0));
   
   XLXI_79 : Mux16
      port map (control1=>XLXN_1008,
                InputA(15 downto 0)=>XLXN_999(15 downto 0),
                InputB(15 downto 0)=>XLXN_1009(15 downto 0),
                Output(15 downto 0)=>XLXN_1011(15 downto 0));
   
   XLXI_81 : HazardDetection
      port map (IDEXMemRead=>XLXN_1032,
                IDEXRegDest(3 downto 0)=>XLXN_711(3 downto 0),
                Instruction(15 downto 0)=>instruction(15 downto 0),
                CtrlSignal=>open,
                IFIDWrite=>XLXN_1074,
                PCWrite=>XLXN_1028);
   
   XLXI_82 : SignedExtend
      port map (Instruction(15 downto 0)=>XLXI_82_Instruction_openSignal(15 
            downto 0),
                ExtendedAddress=>open);
   
   XLXI_83 : vga_ram
      port map (addr10_in(9 downto 0)=>XLXN_1123(9 downto 0),
                char_in(7 downto 0)=>XLXN_1124(7 downto 0),
                clk_0=>CLOCK_50M,
                reset=>reset,
                wea_in(0)=>XLXN_1122(0),
                b(2 downto 0)=>VGA_b(2 downto 0),
                g(2 downto 0)=>VGA_g(2 downto 0),
                hs=>VGA_hs,
                r(2 downto 0)=>VGA_r(2 downto 0),
                vs=>VGA_vs);
   
   XLXI_84 : top
      port map (clkin=>keyboard_in,
                clk50=>CLOCK_50M,
                datain=>keyboard_data,
                datareceived=>XLXN_1127,
                rst_in=>reset,
                dataready_out=>XLXN_1125,
                out_rank(5 downto 0)=>XLXN_1126(5 downto 0));
   
end BEHAVIORAL;


