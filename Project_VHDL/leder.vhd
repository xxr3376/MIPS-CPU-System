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

entity leder is
	Port ( input16 : in  STD_LOGIC_VECTOR (15 downto 0);
           clock : in  STD_LOGIC;
           led1 : out  STD_LOGIC_VECTOR (6 downto 0);
           led2 : out  STD_LOGIC_VECTOR (6 downto 0));		
end leder;

architecture Behavioral of leder is
	Component seg7
		Port (
			input : in  STD_LOGIC_VECTOR (3 downto 0);
			output : out  STD_LOGIC_VECTOR (6 downto 0));
	End Component;
	
	Signal counter: STD_LOGIC_VECTOR(23 downto 0);
	Signal led1_data: STD_LOGIC_VECTOR (3 downto 0);
	Signal led2_data: STD_LOGIC_VECTOR (3 downto 0);
begin
	l1 : seg7 Port Map (input => led1_data, output => led1);
	l2 : seg7 Port Map (input => led2_data, output => led2);
--	process(clock)
--	begin
--		if clock'event and clock = '1' then
--			counter <= counter + 1;
--		end if;
--	end process;
	with counter(23) select
		led1_data <= input16(3 downto 0) when '0',
							input16(11 downto 8) when others;
	with counter(23) select
		led2_data <= input16(7 downto 4) when '0',
							input16(15 downto 12) when others;
end Behavioral;
