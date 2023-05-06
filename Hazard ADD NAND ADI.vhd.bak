library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity hazard1 is
    port (
        instr_in:in std_logic_vector(15 downto 0);
		  c,z:in std_logic;
        haz1: out std_logic
    ) ;
end hazard1;
architecture bhv of hazard1 is

begin
	process(instr_in,c,z)
	begin
		if (instr_in(15 down to 11)="0001" 
			and (instr_in(5 down to 0)="000000" --5 down to 3 is R0(000),hence hazard
				or (instr_in(5 down to 0)="000001" and z='1') 
				or (instr_in(5 down to 0)="000010" and c='1') 
				or (instr_in(5 down to 0)="000011" and (c and z)='1')
				or instr_in(5 down to 0)="000100"
				or (instr_in(5 down to 0)="000101" and z='1') 
				or (instr_in(5 down to 0)="000110" and c='1') 
				or (instr_in(5 down to 0)="000111" and (c and z)='1')) 				
				) then -- ADD _,_,R0
			haz1<='1';
		elsif (instr_in(15 down to 11)="0010" 
			and (instr_in(5 down to 0)="000000" --5 down to 3 is R0(000),hence hazard
				or (instr_in(5 down to 0)="000001" and z='1') 
				or (instr_in(5 down to 0)="000010" and c='1') 
				or (instr_in(5 down to 0)="000011" and (c and z)='1')
				or instr_in(5 down to 0)="000100" 
				or (instr_in(5 down to 0)="000101" and z='1') 
				or (instr_in(5 down to 0)="000110" and c='1') 
				or (instr_in(5 down to 0)="000111" and (c and z)='1')) 				
				) then -- NAND _,_,R0
			haz1<='1';
		elsif(instr_in(15 down to 11)="0000" and instr_in(8 down to 6)="000") --8 down to 6 is R0(000),hence hazard
			then -- ADI _,R0,Imm
			haz1<='1';

		else
			haz1<='0';
		end if;
	end process;
end bhv;