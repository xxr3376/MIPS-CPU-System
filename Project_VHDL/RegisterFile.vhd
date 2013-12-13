library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Ĵ	"0"+Ĵ
--ZERO	1000
--SP	1001
--PC	1010
--IH	1111

entity RegisterFile is
    Port ( SelectA : in  STD_LOGIC_VECTOR (3 downto 0);
           SelectB : in  STD_LOGIC_VECTOR (3 downto 0);
			  PCInput : in STD_LOGIC_VECTOR (15 downto 0);
           RegA : out  STD_LOGIC_VECTOR (15 downto 0);
           RegB : out  STD_LOGIC_VECTOR (15 downto 0);
           SelectC : in  STD_LOGIC_VECTOR (3 downto 0);
           InputData : in  STD_LOGIC_VECTOR (15 downto 0);
           RegWrite : in  STD_LOGIC;
			  DebugInput : in STD_LOGIC_VECTOR (3 downto 0);
			  DebugOutput : out STD_LOGIC_VECTOR (15 downto 0);
			  clock : in STD_LOGIC
           );
end RegisterFile;

architecture RF_Behavioral of RegisterFile is
signal control : STD_LOGIC_VECTOR(15 downto 0);
signal opt0, opt1, opt2, opt3, opt4, opt5, opt6, opt7, opt8, opt9, opt10, opt11, opt12, opt13, opt14, opt15 : STD_LOGIC_VECTOR (15 downto 0);
component Reg16
	 Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
		  output : out  STD_LOGIC_VECTOR (15 downto 0);
		  clk : in  STD_LOGIC;
		  clock : in STD_LOGIC);
end component;
begin
r0	: Reg16 port map(input => InputData, output => opt0	, clk => control(0	), clock => clock);
r1	: Reg16 port map(input => InputData, output => opt1	, clk => control(1	), clock => clock);
r2	: Reg16 port map(input => InputData, output => opt2	, clk => control(2	), clock => clock);
r3	: Reg16 port map(input => InputData, output => opt3	, clk => control(3	), clock => clock);
r4	: Reg16 port map(input => InputData, output => opt4	, clk => control(4	), clock => clock);
r5	: Reg16 port map(input => InputData, output => opt5	, clk => control(5	), clock => clock);
r6	: Reg16 port map(input => InputData, output => opt6	, clk => control(6	), clock => clock);
r7	: Reg16 port map(input => InputData, output => opt7	, clk => control(7	), clock => clock);

r9	: Reg16 port map(input => InputData, output => opt9	, clk => control(9	), clock => clock);

r11	: Reg16 port map(input => InputData, output => opt11	, clk => control(11	), clock => clock);
r12	: Reg16 port map(input => InputData, output => opt12	, clk => control(12	), clock => clock);
r13	: Reg16 port map(input => InputData, output => opt13	, clk => control(13	), clock => clock);
r14	: Reg16 port map(input => InputData, output => opt14	, clk => control(14	), clock => clock);
r15	: Reg16 port map(input => InputData, output => opt15	, clk => control(15	), clock => clock);



opt8 <= "0000000000000000";	--ZERO
opt10 <= PCInput;					--PC

with SelectA select
	RegA<=  opt0     when "0000",
				opt1     when "0001",
				opt2     when "0010",
				opt3     when "0011",
				opt4     when "0100",
				opt5     when "0101",
				opt6     when "0110",
				opt7     when "0111",
				opt8     when "1000",
				opt9     when "1001",
				opt10    when "1010",
				opt11    when "1011",
				opt12    when "1100",
				opt13    when "1101",
				opt14    when "1110",
				opt15    when "1111",
				opt0		when others;
with SelectB select
	RegB<=  opt0     when "0000",
				opt1     when "0001",
				opt2     when "0010",
				opt3     when "0011",
				opt4     when "0100",
				opt5     when "0101",
				opt6     when "0110",
				opt7     when "0111",
				opt8     when "1000",
				opt9     when "1001",
				opt10    when "1010",
				opt11    when "1011",
				opt12    when "1100",
				opt13    when "1101",
				opt14    when "1110",
				opt15    when "1111",
				opt0		when others;

with DebugInput select
	DebugOutput<=  opt0     when "0000",
				opt1     when "0001",
				opt2     when "0010",
				opt3     when "0011",
				opt4     when "0100",
				opt5     when "0101",
				opt6     when "0110",
				opt7     when "0111",
				opt8     when "1000",
				opt9     when "1001",
				opt10    when "1010",
				opt11    when "1011",
				opt12    when "1100",
				opt13    when "1101",
				opt14    when "1110",
				opt15    when "1111",
				opt0		when others;
				
 with SelectC select control(0) <= (RegWrite ) when "0000", '0' when others;
 with SelectC select control(1) <= (RegWrite ) when "0001", '0' when others;
 with SelectC select control(2) <= (RegWrite ) when "0010", '0' when others;
 with SelectC select control(3) <= (RegWrite ) when "0011", '0' when others;
 with SelectC select control(4) <= (RegWrite ) when "0100", '0' when others;
 with SelectC select control(5) <= (RegWrite ) when "0101", '0' when others;
 with SelectC select control(6) <= (RegWrite ) when "0110", '0' when others;
 with SelectC select control(7) <= (RegWrite ) when "0111", '0' when others;
 with SelectC select control(8) <= (RegWrite ) when "1000", '0' when others;
 with SelectC select control(9) <= (RegWrite ) when "1001", '0' when others;
with SelectC select control(10) <= (RegWrite ) when "1010", '0' when others;
with SelectC select control(11) <= (RegWrite ) when "1011", '0' when others;
with SelectC select control(12) <= (RegWrite ) when "1100", '0' when others;
with SelectC select control(13) <= (RegWrite ) when "1101", '0' when others;
with SelectC select control(14) <= (RegWrite ) when "1110", '0' when others;
with SelectC select control(15) <= (RegWrite ) when "1111", '0' when others;


				
end RF_Behavioral;
