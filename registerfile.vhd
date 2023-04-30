library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity registerfile is    
  port(
		A1: in std_logic_vector(2 downto 0);
		A2: in std_logic_vector(2 downto 0);
		A3: in std_logic_vector(2 downto 0);
		D1: out std_logic_vector(15 downto 0);
		D2: out std_logic_vector(15 downto 0);
		D3: in std_logic_vector(15 downto 0);
		clock: in std_logic;
		wr_en: in std_logic;
 );
end registerfile;

architecture struct of RAM is

begin

end architecture struct;