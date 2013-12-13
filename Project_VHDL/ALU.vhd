
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

entity ALU is
    Port ( dataA : in  STD_LOGIC_VECTOR (15 downto 0);
           dataB : in  STD_LOGIC_VECTOR (15 downto 0);
           operation : in  STD_LOGIC_VECTOR (2 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0):= "0000000000000000");
end ALU;

architecture Behavioral of ALU is
signal result_tmp : STD_LOGIC_VECTOR (15 downto 0);
begin
result<=result_tmp;
process(dataA,dataB,operation)
begin
	case operation is
		when "000" =>
			--result <= dataA + dataB;
			result_tmp <= dataA + dataB;
		when "001" =>
			--result <= dataA - dataB;
			result_tmp <= dataA - dataB;
		when "010" =>
			--result <= dataA and dataB;
			result_tmp <= dataA and dataB;
		when "011" =>
			--result <= dataA or dataB;
			result_tmp <= dataA or dataB;
		when "100"=>
			--result <= TO_STDLOGICVECTOR(TO_BITVECTOR(dataA) sll CONV_INTEGER(dataB));
			result_tmp <= TO_STDLOGICVECTOR(TO_BITVECTOR(dataA) sll CONV_INTEGER(dataB(3 downto 0)));
		when "101"=>
			--need test here:sra from 1-8!
			--result <= TO_STDLOGICVECTOR(TO_BITVECTOR(dataA) sra CONV_INTEGER(dataB(3 downto 0)));
			result_tmp <= TO_STDLOGICVECTOR(TO_BITVECTOR(dataA) sra CONV_INTEGER(dataB(3 downto 0)));
		when "110"=>
			result_tmp <= dataA xor dataB;
		when others=>
			--result <= (others=>'0');
			result_tmp <= (others=>'0');
	end case;
end process;

end Behavioral;

