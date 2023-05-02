library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity imem is 
	port (imem_a: in std_logic_vector(15 downto 0); 
		  clk: in std_logic;
		  imem_d: out std_logic_vector(15 downto 0));
end entity;

 architecture struct of imem is 
type arr is array(50 downto 0) of std_logic_vector(15 downto 0);
signal Memory: arr:=(others=>"0000000000000000");

begin
process (clk,imem_a)
  
 begin
		if rising_edge(clk) then
				imem_d<=Memory(to_integer(unsigned(imem_a)));
		end if;
		
end process;
end struct;