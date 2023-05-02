library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity uProcessor is
	port(
		clk: in std_logic;
		reset: in std_logic;
	);
end entity;
architecture struct of uProcessor is
	component register_file is    
	  port(
			A1,A2,A3: in std_logic_vector(2 downto 0);
			D3,pc_in: in std_logic_vector(15 downto 0);
			clock,reset,wr_en,pc_wr: in std_logic;
			D1,D2,pc_out: out std_logic_vector(15 downto 0)
			);
	end component register_file;
begin
	
	subTaskIF: Process(clk)
	begin
	
	end Process;
	
end struct;