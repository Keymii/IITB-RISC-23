library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_MA is
  port ( instr,addr, d_in : in std_logic_vector(15 downto 0);
			clk,reset,mem_wr : in std_logic;
			d_out : out std_logic_vector(15 downto 0) 
			
    );
	 
end subCircuit_MA;
architecture behav of subCircuit_MA is
	component DataMemory is
		  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
				  din: IN STD_LOGIC_VECTOR(15 downto 0);
				  we: IN STD_LOGIC;
				  clk: IN STD_LOGIC;
				  dout: OUT STD_LOGIC_VECTOR(15 downto 0)
				  );
		end component DataMemory;
	signal data_wr,data_rd,m_addr:std_logic_vector(15 downto 0):=(others=>'0');
	signal multiple:std_logic:='0';
	shared variable count:integer:=0;
	shared variable multi_reg_add : std_logic_vector(7 downto 0):=instr(7 downto 0);
	shared variable multi_addr:std_logic_vector(15 downto 0):=addr;
begin
	ma:process(clk,reset)
	dataMem : DataMemory port map(addr=>m_addr, din=>data_wr, we=>mem_wr, clk=>clk, dout=>data_rd);

	begin
		if instr(15 downto 14)="01" 
			multi_add:=addr;
			multi_reg_add:=instr(7 downto 0)
			
			case instr(13 downto 12) is	
				when "00"=>--lw
					m_addr<=addr;
					d_out<=data_rd;
					
				when "01"=>--sw					
					m_addr<=addr;
					data_wr<=d_in;

				when "10"=>--lm
					if rising_edge(clk) then	
						if instr(count)='1' then
							m_addr<=multi_addr;
							data_wr<=d_in;
							d_out<=data_rd;
							multi_addr := std_logic_vector(to_unsigned(to_integer(unsigned(multi_addr))+2,m_addr'length));
						end if;
						
						count:=count+1;
							
					end if;
					
				when "11"=>--sm
					if rising_edge(clk) then
						if instr(count)='1' then
							m_addr<=multi_addr;
							data_wr<=d_in;
							multi_addr := std_logic_vector(to_unsigned(to_integer(unsigned(multi_addr))+2,m_addr'length));
						end if;
						
						count:=count+1;
							
					end if;
					
			end case;
			
		end if;
	end process;
		
end behav;