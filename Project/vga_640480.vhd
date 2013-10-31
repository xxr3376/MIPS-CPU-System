library	ieee;
use		ieee.std_logic_1164.all;
use		ieee.std_logic_unsigned.all;
use		ieee.std_logic_arith.all;

entity vga640480 is
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
			--15r 20col
	  );
end vga640480; 

architecture behavior of vga640480 is
	signal input		: std_logic_vector(79 downto 0);		
	signal r1,g1,b1   : std_logic_vector(2 downto 0);					
	signal hs1,vs1    : std_logic;				
	signal vector_x : std_logic_vector(9 downto 0);		--X坐标
	signal vector_y : std_logic_vector(8 downto 0);		--Y坐标
	signal clk	:	 std_logic;
	signal qout:  STD_LOGIC_VECTOR(0 DOWNTO 0);

begin
input(3 downto 0)  <= input0(15 downto 12);
input(7 downto 4)  <= input0(11 downto 8);
input(11 downto 8) <= input0(7 downto 4);
input(15 downto 12)<= input0(3 downto 0);
input(19 downto 16)<= input1(15 downto 12);
input(23 downto 20)<= input1(11 downto 8);
input(27 downto 24)<= input1(7 downto 4);
input(31 downto 28)<= input1(3 downto 0);
input(35 downto 32)<= input2(15 downto 12);
input(39 downto 36)<= input2(11 downto 8);
input(43 downto 40)<= input2(7 downto 4);
input(47 downto 44)<= input2(3 downto 0);
input(51 downto 48)<= input3(15 downto 12);
input(55 downto 52)<= input3(11 downto 8);
input(59 downto 56)<= input3(7 downto 4);
input(63 downto 60)<= input3(3 downto 0);
input(67 downto 64)<= input4(15 downto 12);
input(71 downto 68)<= input4(11 downto 8);
input(75 downto 72)<= input4(7 downto 4);
input(79 downto 76)<= input4(3 downto 0);


clk25 <= clk;
 -----------------------------------------------------------------------
  process(clk_0)	--对50M输入信号二分频
    begin
        if(clk_0'event and clk_0='1') then 
             clk <= not clk;
        end if;
 	end process;

 -----------------------------------------------------------------------
	 process(clk,reset)	--行区间像素数（含消隐区）
	 begin
	  	if reset='0' then
	   		vector_x <= (others=>'0');
	  	elsif clk'event and clk='1' then
	   		if vector_x=799 then
	    		vector_x <= (others=>'0');
	   		else
	    		vector_x <= vector_x + 1;
	   		end if;
	  	end if;
	 end process;

  -----------------------------------------------------------------------
	 process(clk,reset)	--场区间行数（含消隐区）
	 begin
	  	if reset='0' then
	   		vector_y <= (others=>'0');
	  	elsif clk'event and clk='1' then
	   		if vector_x=799 then
	    		if vector_y=524 then
	     			vector_y <= (others=>'0');
	    		else
	     			vector_y <= vector_y + 1;
	    		end if;
	   		end if;
	  	end if;
	 end process;
 
  -----------------------------------------------------------------------
	 process(clk,reset) --行同步信号产生（同步宽度96，前沿16）
	 begin
		  if reset='0' then
		   hs1 <= '1';
		  elsif clk'event and clk='1' then
		   	if vector_x>=656 and vector_x<752 then
		    	hs1 <= '0';
		   	else
		    	hs1 <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process(clk,reset) --场同步信号产生（同步宽度2，前沿10）
	 begin
	  	if reset='0' then
	   		vs1 <= '1';
	  	elsif clk'event and clk='1' then
	   		if vector_y>=490 and vector_y<492 then
	    		vs1 <= '0';
	   		else
	    		vs1 <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process(clk,reset) --行同步信号输出
	 begin
	  	if reset='0' then
	   		hs <= '0';
	  	elsif clk'event and clk='1' then
	   		hs <=  hs1;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process(clk,reset) --场同步信号输出
	 begin
	  	if reset='0' then
	   		vs <= '0';
	  	elsif clk'event and clk='1' then
	   		vs <=  vs1;
	  	end if;
	 end process;
	
 -----------------------------------------------------------------------	
	process(reset,clk,vector_x,vector_y) -- XY坐标定位控制
	begin  
--		address <= "00"
--						&input((CONV_INTEGER(vector_y(7 downto 5)&vector_x(6 downto 5)&"00")+3) downto CONV_INTEGER(vector_y(7 downto 5)&vector_x(6 downto 5)&"00"))
--						&vector_y(4 downto 0)&vector_x(4 downto 0);
--		
		--测试行号
--		address <= "00"&vector_y(8 downto 5)&vector_y(4 downto 0)&vector_x(4 downto 0); 
		--测试列号
		--address <= "0"&vector_x(9 downto 5)&vector_y(4 downto 0)&vector_x(4 downto 0); 
		addr10 <= "00"&vector_y(8 downto 5)&vector_x(8 downto 5);
		addr16 <= char(5 downto 0)&vector_y(4 downto 0)&vector_x(4 downto 0);
		if reset='0' then
			      r1 <= "000";
					g1	<= "000"; 
					b1	<= "000";
		elsif(clk'event and clk='1')then
		 			
			if vector_x > 639 or vector_y > 479 then 
					r1  <= "000";
					g1	<= "000";
					b1	<= "000";
			else 
				if vector_x > 512 then 
					r1  <= "111";
					g1	<= "111";
					b1	<= "111";
			else
					if q = "1" then 
						r1  <= "000";
						g1	<= "000";
						b1	<= "111";
					else
						r1  <= "111";
						g1	<= "111";
						b1	<= "111";
					end if;
				end if;
			end if;
		end if;		 
	end process;	

	-----------------------------------------------------------------------
	process (hs1, vs1, r1, g1, b1)	--色彩输出
	begin
		if hs1 = '1' and vs1 = '1' then
			r	<= r1;
			g	<= g1;
			b	<= b1;
		else
			r	<= (others => '0');
			g	<= (others => '0');
			b	<= (others => '0');
		end if;
	end process;

end behavior;

