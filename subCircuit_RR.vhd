library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_RR is
  port ( instr: in std_logic_vector(15 downto 0);

			reg_read_1: in STD_LOGIC;
			reg_read_2: in STD_LOGIC;
			
			rf_a1,rf_a2:out std_logic_vector(2 downto 0);
			rf_d1,rf_d2:in std_logic_vector(15 downto 0);
		   data_reg1, dat_reg2 :out std_logic_vector(15 downto 0)
    );
	 
end subCircuit_RR;
architecture a3 of subCircuit_RR is

begin
 if (reg_read_1 = 1) then
   rf_a1 <= instr(11 downto 9);
	data_reg1 <= rf_d1;
	
 elsif (reg_read_2 = 1) then
   rf_a2 <= instr(8 downto 6); 
	data_reg2 <= rf_d2;

end a3;
 
 

 