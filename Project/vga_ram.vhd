----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 邹林希
-- 
-- Create Date:    02:09:20 11/19/2012 
-- Design Name: 
-- Module Name:    vga_ram - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ram is 
    Port ( 
			--input0,input1,input2,input3,input4:in STD_LOGIC_VECTOR(15 DOWNTO 0);
			addr10_in	:		   in	STD_LOGIC_VECTOR(9 DOWNTO 0);--0-239
			char_in		:			in	STD_LOGIC_VECTOR(7 DOWNTO 0);--0-35
			wea_in 		:  		in STD_LOGIC_VECTOR(0 DOWNTO 0);--1 for write
			--for test
--			input			:			in STD_LOGIC_VECTOR(15 DOWNTO 0);
--			k1				:			in STD_LOGIC;
			-- end for test
			reset       :    		in  STD_LOGIC;
			clk_0       :        in  STD_LOGIC; --50M时钟输入
			hs,vs       :        out STD_LOGIC; --行同步、场同步信号
			r,g,b       :        out STD_LOGIC_vector(2 downto 0)
			);
end vga_ram;

architecture Behavioral of vga_ram is
	component blk_mem_gen_v6_1 is
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
	  );
	END component;
	component vga640480 is
	port(
			input0,input1,input2,input3,input4:in STD_LOGIC_VECTOR(15 DOWNTO 0);
			addr10		:		  out	STD_LOGIC_VECTOR(9 DOWNTO 0);
			char			:			in STD_LOGIC_VECTOR(7 DOWNTO 0);
			addr16		:		  out	STD_LOGIC_VECTOR(15 DOWNTO 0);
			q		      :		  in STD_LOGIC_VECTOR(0 DOWNTO 0);
			
			reset       :         in  STD_LOGIC;
			clk25       :		  out std_logic; 
			
			clk_0       :         in  STD_LOGIC; --50M时钟输入
			hs,vs       :         out STD_LOGIC; --行同步、场同步信号
			r,g,b       :         out STD_LOGIC_vector(2 downto 0)
	);
	end component; 
	component vga_mem IS
  PORT (
	 --a for read
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	 --b for write
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
	end component;
	signal mem_wea 	:  STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal addr10read,addr10write 		:  STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal addr16 		:	STD_LOGIC_VECTOR(15 DOWNTO 0);
	signal q,k 			: 	STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal charin,charout,tmp:STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal clk 			:	STD_LOGIC;
	signal changenexttime : std_logic;
begin
	vga: vga640480 port map("0100001100100001","1000011101100101",
									"1100101110101001","0000111111101101","1111000000000000",addr10read,charout,
									addr16,q,reset,clk,clk_0,hs,vs,r,g,b);
	ram: blk_mem_gen_v6_1 port map(clk,"0",addr16,"0",q);
	mem: vga_mem port map(clk,"0",addr10read,"00000000",charout,clk,wea_in,addr10_in,char_in,tmp);--k,addr10write,input(7 downto 0),tmp);
end Behavioral;

