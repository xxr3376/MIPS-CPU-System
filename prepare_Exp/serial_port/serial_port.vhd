----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:11:49 10/20/2012 
-- Design Name: 
-- Module Name:    serial_port - Behavioral 
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

entity serial_port is
    Port ( ram1_en : out  STD_LOGIC;
           key_clk : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
			led  : out STD_LOGIC_VECTOR (7 downto 0);
           databus : inout  STD_LOGIC_VECTOR (7 downto 0);
			  wrn : out STD_LOGIC;
			  clk : in STD_LOGIC;
			  rdn : out STD_LOGIC;
			key1 : in STD_LOGIC;
			key2 : in STD_LOGIC;
			key3 : in STD_LOGIC;
			data_ready : in STD_LOGIC;
			seg  : out STD_LOGIC_VECTOR ( 6 downto 0)
		);
end serial_port;

architecture Behavioral of serial_port is
--signal repo : STD_LOGIC_VECTOR (7 downto 0);
type serial_state is (write_state, read_state, rw_state);
signal mode : serial_state := write_state;
signal holder : STD_LOGIC_VECTOR( 7 downto 0);
signal output_flag : STD_LOGIC := '0';
signal status : STD_LOGIC_VECTOR ( 3 downto 0);
signal read_status : STD_LOGIC_VECTOR (1 downto 0) := "00";
signal storage : STD_LOGIC_VECTOR (7 downto 0);
component seg7
	Port ( input : in  STD_LOGIC_VECTOR (3 downto 0);
           output : out  STD_LOGIC_VECTOR (6 downto 0));
end component;


component timer
	Port ( input_clk : in  STD_LOGIC;
           ms_clk : out  STD_LOGIC);
end component;
signal scan_signal : STD_LOGIC := '0';
begin
	s1 : seg7 port map(status, seg);
	databus <= holder when output_flag = '1' else "ZZZZZZZZ";
	scan_timer : timer port map (clk, scan_signal);
	ram1_en <= '1';
	led <= storage;
	process (key1, key2, key3)
	begin
		if key1 = '0' then
			mode <= write_state;
			status <= "0000";
		elsif key2 = '0'then
			mode <= read_state;
			status <= "0001";
		elsif key3 = '0' then
			mode <= rw_state;
			status <= "0010";
		end if;
	end process;

	process (scan_signal)
	begin
		if scan_signal'event and scan_signal = '1' then
			case mode is
				when write_state =>
					rdn <= '1';
					if key_clk = '0' then
						holder <= input;
						output_flag <= '1';
						wrn <= '0';
					else
						output_flag <= '0';
						wrn <= '1';
					end if;
				when read_state =>
					rdn <= '0';
					wrn <= '1';
					output_flag <= '0';
				when rw_state =>
					case read_status is
						when "00" =>
							if data_ready = '1' then
								output_flag <= '0';
								wrn <= '1';
								rdn <= '0';
								read_status <= "01";
							else
								wrn <= '1';
								rdn <= '1';
							end if;
						when "01" =>
							storage<= databus + 1;
							output_flag <= '1';
							read_status <= "10";
							wrn <= '1';
							rdn <= '1';
						when "10" =>
							holder <= storage;
							output_flag <= '1';
							wrn <= '0';
							rdn <= '1';
							read_status <= "11";
						when "11" =>
							output_flag <= '0';
							wrn <= '1';
							rdn <= '1';
							read_status <= "00";
						when others =>
						end case;
				when others =>
			end case;
		end if;
	end process;
end Behavioral;

