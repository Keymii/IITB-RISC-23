--if_id

library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity master_reg is 

generic (

        regsize : integer := 16;
    );

    port(
		clock,reset,wr,inp: in std_logic (regsize-1 downto 0);
		outp: out std_logic (regsize-1 downto 0)
		);
end if_id;

architecture bhv of master_reg is
begin
P:process(wr, clock, inp)
begin
if rising_edge(clock) then
  if wr='1' then
    outp <= inp;
  else
    null;
  end if;
  if reset='1' then
	 outp<='0';
  end if;
else
  null;
end if;
end process;
end bhv;
