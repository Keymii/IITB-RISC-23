library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_WB is
 port (
      clk,reset : in std_logic;
		reg_write: in std_logic;
		
		D3_in : out std_logic_vector(15 downto 0);
	 reg_write_add: OUT STD_LOGIC_VECTOR(2 downto 0);
    A3 : out std_logic_vector(2 downto 0);
	 D3_out : out std_logic_vector(15 downto 0)
 
   );
	end entity;
	
architecture a5 of subCircuit_WB is
begin
 process(clk)
 begin
  if (reg_write=1) then
  A3 <= reg_write_add;
  D3_out<=D3_in;
  
 end if;
 
 end process;
 end a5;
 
  
 