library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity subCircuit_ID is
	port(
		
		pc_read: in std_logic_vector(15 downto 0);
		pc_write: out std_logic_vector(15 downto 0);
		pc
		
	);
end subCircuit_ID;
architecture a2 of subCircuit_ID is 
