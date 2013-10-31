library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity divEven is -- 
	generic(N: integer:=20; half: integer:=10; size: integer:=4);
	port(clk: in std_logic;
		 div: out std_logic);
end divEven;

architecture behav of divEven is
	signal result: std_logic:='0';
	signal cnt: std_logic_vector(size downto 0):=(others=>'0');
begin
	process(clk)
	begin
		if (clk'event and clk='1') then
			if (cnt<half-1) then
				cnt<=cnt+1;
			else
				cnt<=(others=>'0');
				result<=not(result);
			end if;
		end if;
		div<=result;
	end process;
end behav;
	
			
			
		
			