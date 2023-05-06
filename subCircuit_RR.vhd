library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_RR is
  port ( instr: in std_logic_vector(15 downto 0);
			clock,reset,mem_wr_in: in std_logic;
			mem_wr_out: out std_logic;
			reg_read_1: in STD_LOGIC;
			reg_read_2: in STD_LOGIC;
			rf_a1,rf_a2:out std_logic_vector(2 downto 0);
			rf_d1,rf_d2:in std_logic_vector(15 downto 0);
		   data_reg1, data_reg2 :out std_logic_vector(15 downto 0)
    );
	 
end subCircuit_RR;
architecture a3 of subCircuit_RR is
	shared variable count:integer:=0;
	shared variable smRegList:std_logic_vector(7 downto 0);

begin
	if (instr(15 downto 12) = "0111") then
		--- write code if sm ie, read RA as well as read the registers
		-- in ID send RA to A2 and get its data and hold it in RR_EX if count =0 or /=0 conditions
		-- send R7-0 in A1, read, send and loop. MA phase will store automatically
		sm:process(clock,reset)
			if reset = '1' then
				count :=0;
			end if;
			if rising_edge(clock) then
				if count = 0 then
					rf_a2<=instr(11 downto 9);
					smRegList<=instr(7 downto 0);
					data_reg2<=rf_d2; --location in memory where store multiple begins
					
				end if;
				if smRegList(count) = '1';
					rf_a1<=std_logic_vector(to_unsigned(8-count,rf_a1'length));
					data_reg1<=rf_d1;
				end if;
				
				mem_wr_out<=smRegList(count);

				count := count+1;
				if count >= 8 then
					count:=0;
				end if;
			end if;
		end process;
		
	else
		if (reg_read_1 = 1) then
			rf_a1 <= instr(11 downto 9);
			data_reg1 <= rf_d1;
		end if;
		
		if (reg_read_2 = 1) then
			rf_a2 <= instr(8 downto 6); 
			data_reg2 <= rf_d2;
		end if;
		
		mem_wr_out<=mem_wr_in;
		
	end if;
end a3;
 
 

 