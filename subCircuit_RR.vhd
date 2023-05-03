library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_RR is
  port ( instr_inp: in std_logic_vector(15 downto 0);
       addr_Ra, addr_Rb : in std_logic_vector(2 downto 0);
       data_Ra, data_Rb : out std_logic_vector(15 downto 0)
    );
	 
end subCircuit_RR;
architecture a3 of subCircuit_RR is

 component register_file is    
  port(
		A1,A2,A3: in std_logic_vector(2 downto 0);
		D3,pc_in: in std_logic_vector(15 downto 0);
		clock,reset,wr_en,pc_wr: in std_logic;
		D1,D2,pc_out: out std_logic_vector(15 downto 0)
		);
 end register_file;

begin

 case instr_inp(15 downto 12) is
 
  when "0000" =>     -- ADD
   RF : register_file port map (A1=> addr_Ra ;A2=> addr_Rb ;
 
 
 

 