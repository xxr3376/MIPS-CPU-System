library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity top is
port(
		datain,clkin,clk50,rst_in	:	in std_logic;
		dataready_out 					:	out std_logic;
		datareceived					:	in std_logic;
		out_rank 						:	out std_logic_vector(5 downto 0)
);
end top;

architecture behave of top is
component Keyboard is
port (
		datain, clkin 					:	in std_logic ; -- PS2 clk and data
		fclk			: in std_logic ;  -- filter clock :5M
		rst : in std_logic;
	--	fok : out std_logic ;  -- data output enable signal
		scancode : out std_logic_vector(7 downto 0) -- scan code signal output
	) ;
end component ;
component divEven is 
	port(clk: in std_logic; 
		 div: out std_logic);
end component;
component seg7 is
port(
code: in std_logic_vector(5 downto 0);
seg_out : out std_logic_vector(6 downto 0)
);
end component;
component keytorank is
	PORT
	(
		key: in std_logic_vector(7 downto 0);
		rank: out std_logic_vector(5 downto 0)
	);
end component;
signal scancode : std_logic_vector(7 downto 0);
signal rst : std_logic;
signal fclk: std_logic;
signal st:	std_logic_vector(3 downto 0):="0000";
signal dataready : std_logic := '0';
signal rank: std_logic_vector(5 downto 0);
signal ranktmp: std_logic_vector(5 downto 0):="000000";
signal lock:std_logic:='0';
begin
rst<=not rst_in;
u0: Keyboard port map(datain,clkin,fclk,rst,scancode);
u2: keytorank port map(scancode,rank);
u3: divEven port map(clk50,fclk);
out_rank<=ranktmp;
dataready_out <= dataready;
process(rank,datareceived,clk50)
begin
if clk50'event and clk50 = '1' then
	if rank = "111110" then--scancode = F0
		st <= "0001";
	else 
		case st is
			when "0001" =>
				dataready <= '1';
				ranktmp <= rank;
				st <= "0000";
			when others =>
				st<="0000";
		end case;
	end if;
	if datareceived = '1' then 
		dataready <= '0';
	end if;
end if;	
end process;
end behave;
