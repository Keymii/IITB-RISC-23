library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity r_1bit is 
    port(
		clock,reset,wr,D: in std_logic;
		output: out std_logic
		);
end r_1bit;

architecture bhv of r_4bit is
begin
	P:process(wr, clock, D)
	begin
		if rising_edge(clock) then
		  if wr='1' then
			 output <= D;
		  else
			 null;
		  end if;
		  if reset='1' then
			 output<='0';
		  end if;
		else
		  null;
		end if;
	end process;
end bhv;