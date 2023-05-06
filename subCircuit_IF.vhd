library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity subCircuit_IF is
	port(
		clk,reset: in std_logic;
		pc_read: in std_logic_vector(15 downto 0);
		pc_write: out std_logic_vector(15 downto 0);
		pc_wr:out std_logic;
		IR: out std_logic_vector(15 downto 0)
	);
end subCircuit_IF;
architecture a1 of subCircuit_IF is 

	component imem is 
		port (imem_a: in std_logic_vector(15 downto 0); 
			  clk: in std_logic;
			  imem_d: out std_logic_vector(15 downto 0));
	end component;
	
	signal instr:std_logic_vector(15 downto 0);
begin
	instructionMem:imem port map(imem_a=>pc_read, clk=>clk, imem_d=>instr);
	IR<=instr;
	P:process(clk, reset)
	begin
		if rising_edge(clk) then
			if (instr(15 downto 14) /= "10") and (instr(15 downto 14) /= "11") and (instr(15 downto 13)/="011")then
				pc_wr <='1';
				pc_write <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_read))+2,pc_write'length));
			else
				pc_wr<='1';
				pc_write<=pc_read;
			end if;		
			
		end if;
	end process;
end a1;