library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tLight4 is
port( clk : in std_logic;
      g1,g2,g3,g4,r1,r2,r3,r4,y1,y2,y3,y4 : out std_logic
);
end tLight4;

architecture Behavioral of tLight4 is

type s is (rgrg,ryry,grgr,yryr);
signal cur_st , next_st : s;


constant time_rgrg : integer:= 50;
constant time_ryry : integer:= 10;
constant time_grgr : integer:= 50;
constant time_yryr : integer:= 10;

signal time_max : integer range 0 to 60;
signal timer : integer range 0 to 49999999;
signal counter : integer range 0 to 60;

begin

process(clk)
begin
if rising_edge(clk) then 
   if (timer < 49999999) then
	    timer <= timer + 1;
   else
	   timer <= 0;
		counter <= counter + 1;
		if counter > time_max then 
		   cur_st <= next_st;
			counter <= 0;
		end if;
	end if;
end if;
end process;

process(cur_st)
begin

next_st <= rgrg;

case cur_st is
     when rgrg => 
	     next_st <= ryry;
		  r1 <='1' ; r2 <= '0'; r3 <='1' ; r4 <='0' ;
		  g1 <= '0'; g2 <= '1'; g3 <='0' ; g4 <='1' ;
		  y1 <= '0'; y2 <= '0'; y3 <= '0'; y4 <='0' ;
		  time_max <= time_rgrg;
	  when ryry => 
	     next_st <= grgr;
		  r1 <='1' ; r2 <= '0'; r3 <='1' ; r4 <='0' ;
		  g1 <= '0'; g2 <= '0'; g3 <='0' ; g4 <='0' ;
		  y1 <= '0'; y2 <= '1'; y3 <= '0'; y4 <='1' ;
		  time_max <= time_ryry;
	  when grgr => 
	     next_st <= yryr;
		  r1 <='0' ; r2 <= '1'; r3 <='0' ; r4 <='1' ;
		  g1 <= '1'; g2 <= '0'; g3 <='1' ; g4 <='0' ;
		  y1 <= '0'; y2 <= '0'; y3 <= '0'; y4 <='0' ;
		  time_max <= time_grgr;
	  when yryr => 
	     next_st <= rgrg;
		  r1 <='0' ; r2 <= '1'; r3 <='0' ; r4 <='1' ;
		  g1 <= '0'; g2 <= '0'; g3 <='0' ; g4 <='0' ;
		  y1 <= '1'; y2 <= '0'; y3 <= '1'; y4 <='0' ;
		  time_max <= time_yryr;
end case;
end process;
		  



end Behavioral;

