library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
--WriteBack Stage

entity hazard2 is
    port (
        instr_in: in std_logic_vector(15 downto 0);		  
        haz2: out std_logic
    );
end hazard2;
architecture bhv of hazard2 is

begin
	process(instr_in)
	begin
		if(instr_in(15 down to 12)="0011" 
			and instr_in(11 down to 9) ="000") then --LLI R0,Imm
			haz2<='1';
		else
			haz2<='0';
		end if;
	end process;
end bhv;