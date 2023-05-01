library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity register_file is    
  port(
		A1,A2,A3: in std_logic_vector(2 downto 0);
		D3,pc_in: in std_logic_vector(15 downto 0);
		clock,reset,wr_en,pc_wr: in std_logic;
		D1,D2,pc_out: out std_logic_vector(15 downto 0)
		);
end register_file;

architecture struct of register_file is
	type rf is array(7 downto 0) of std_logic_vector(15 downto 0);
	signal rf_signal: rf := (others=>"0000000000000000");
	
begin
	P:process(A1,A2,A3,D3,wr_en,pc_wr,clock)
	begin
		if rising_edge(clock) then
			if wr_en='1' then
				rf_signal(to_integer(unsigned(A3)))<=D3;
			end if;
			if pc_wr='1' then
				rf_signal(0)<=pc_in;
			end if;
			if reset='1' then
				rf_signal<=(others=>"0000000000000000");
			end if;
		end if;
	end process;

D1<=rf_signal(to_integer(unsigned(A1)));
D2<=rf_signal(to_integer(unsigned(A2)));
pc_out<=rf_signal(0);

end struct;