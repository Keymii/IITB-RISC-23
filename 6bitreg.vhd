library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity r_6bit is 
    port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(5 downto 0);
		output: out std_logic_vector(5 downto 0)
		);
end r_5bit;

architecture bhv of r_5bit is
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
	 output<="000000";
  end if;
else
  null;
end if;
end process;
end bhv;