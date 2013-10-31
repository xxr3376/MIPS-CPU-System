----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:00:16 10/19/2012 
-- Design Name: 
-- Module Name:    ram - Behavioral 
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

entity ram is
    Port ( address : out  STD_LOGIC_VECTOR (17 downto 0);
			  address2 : out  STD_LOGIC_VECTOR (17 downto 0);
           data : inout  STD_LOGIC_VECTOR (15 downto 0);
			  data2 : inout  STD_LOGIC_VECTOR (15 downto 0);
			  input :  in  STD_LOGIC_VECTOR (15 downto 0);
			  output_led	: out STD_LOGIC_VECTOR (15 downto 0);
           en : out  STD_LOGIC;
           oe : out  STD_LOGIC;
           rw : out  STD_LOGIC;
			  seg : out STD_LOGIC_VECTOR(6 downto 0);
			  en2 : out  STD_LOGIC;
           oe2 : out  STD_LOGIC;
           rw2 : out  STD_LOGIC;
           clk : in  STD_LOGIC;
			  auto_clk : in STD_LOGIC;
           rst : in  STD_LOGIC;
			  u5, c14 : out STD_LOGIC);
end ram;

architecture Behavioral of ram is

component seg7
	Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (6 downto 0));
end component;
component timer
	Port ( input_clk : in  STD_LOGIC;
           ms_clk : out  STD_LOGIC);
end component;

type st_type is (addr_st,data_st,inc_st,show1_st,sub_st, sub_write_st,show2_st);
--type rst_st_type is (in_inc_st,in_show1_st,in_sub_st,in_show2_st);
signal c_st: st_type;
signal rst_st:STD_LOGIC_VECTOR (1 downto 0) := "00";
signal rw_flag,rw2_flag:STD_LOGIC;
signal address0:STD_LOGIC_VECTOR (17 downto 0);
signal address_tmp:STD_LOGIC_VECTOR (17 downto 0);
signal data_tmp,holder,holder2:STD_LOGIC_VECTOR (15 downto 0);
signal status : STD_LOGIC_VECTOR(3 downto 0);
signal scan_signal : STD_LOGIC := '0';

begin
	s1 : seg7 port map(status, seg);
	scan_timer : timer port map (auto_clk, scan_signal);
	rw  <= rw_flag;
	rw2 <= rw2_flag;
	data  <= holder when rw_flag = '0' else "ZZZZZZZZZZZZZZZZ";
	data2 <= holder2 when rw2_flag = '0' else "ZZZZZZZZZZZZZZZZ";
	u5 <= '1';
	c14 <= '1';
	en<='0';
	en2<='0';
	status <= "00" & rst_st;	
	process(scan_signal)
	variable add_inst : STD_LOGIC_VECTOR(17 downto 0);
	begin
		if scan_signal'event and scan_signal = '1' then
			if rst = '0' then
				if rst_st = "00" then
					address_tmp <= address0;
					address <= address0;
					rst_st <= "01";
					c_st <=show1_st;
					oe <= '0';
					rw_flag <= '1';
				elsif rst_st = "01" then
					address_tmp <= address0;
					address <= address0;
					address2 <= address0;
					rst_st <= "10";
					c_st <= sub_st;
					oe <= '0';
					rw_flag <= '1';
				elsif rst_st = "10" then
					address_tmp <= address0;
					address <= address0;
					address2 <= address0;
					rst_st <= "11";
					c_st <= show2_st;
					oe2 <= '0';
					rw2_flag <= '1';
				elsif rst_st = "11" then
					rst_st <= "00";
					c_st <= addr_st;
				end if;
			elsif clk = '0' then
				case c_st is
					when addr_st =>
						address0<=("00"&input);
						c_st<=data_st;
						output_led<=input;
					when data_st =>
						data_tmp<=input;
						address_tmp<=address0;
						c_st<=inc_st;
						output_led<=input;
					when inc_st =>						
						address<=address_tmp;
						holder<=data_tmp + 1 - 1;--TEST +1
						rw_flag <= '0';
						oe <= '1';
						output_led<=data_tmp;
						address_tmp <= address_tmp + 1;
						
						data_tmp <= data_tmp + 1;
					when show1_st =>
						oe <= '0';
						rw_flag <= '1';
						output_led<=data;
						address <= address_tmp + 1;
						address_tmp <= address_tmp + 1;
						
					when sub_st =>
						add_inst := address_tmp + 1;
						address2<=address_tmp;
						address_tmp <= address_tmp + 1;
						address<=add_inst;
						
						holder2 <= data - 1;
						output_led <= data - 1;
						oe<='0';
						rw_flag <= '1';
						oe2 <= '1';
						rw2_flag <= '0';
					when show2_st =>
						address_tmp <= address_tmp + 1;
						address <= address_tmp + 1;
						address2 <= address_tmp + 1;
						oe2 <= '0';
						rw2_flag <= '1';						
						output_led<=data2;
					when others =>
				end case;
			end if;
			
		end if;
	end process;
end Behavioral;
