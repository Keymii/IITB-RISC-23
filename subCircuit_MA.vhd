library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_MA is
  port ( instr,addr, d_in : in std_logic_vector(15 downto 0);
			clk,reset,mem_wr : in std_logic;
			d_out : out std_logic_vector(15 downto 0) ;
		   rf_wr_in: IN STD_LOGIC;
		   rf_wr_add_in:IN STD_LOGIC_VECTOR(2 downto 0);
		   rf_wr_out:OUT STD_LOGIC;
		   rf_wr_add_out:OUT STD_LOGIC_VECTOR(2 downto 0)
			
    );
	 
end subCircuit_MA;
architecture behav of subCircuit_MA is
	component DataMemory is
		  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
				  din: IN STD_LOGIC_VECTOR(15 downto 0);
				  we: IN STD_LOGIC;
				  clk: IN STD_LOGIC;
				  dout: OUT STD_LOGIC_VECTOR(15 downto 0);
				  );
		end component DataMemory;
	signal data_wr,data_rd,m_addr:std_logic_vector(15 downto 0):=(others=>'0');
	signal multiple:std_logic:='0';
	signal rf_wr_add_sig: STD_LOGIC_VECTOR(2 downto 0);
	shared variable count:integer:=0;
	shared variable multi_reg_add : std_logic_vector(7 downto 0):=instr(7 downto 0);
	shared variable multi_addr:std_logic_vector(15 downto 0);
	
begin
	ma:process(clk,reset)
	begin
	dataMem : DataMemory port map(addr<=m_addr, din<=data_wr, we<=mem_wr, clk<=clk, dout<=data_rd);

	begin
		if instr(15 downto 14)="01" then
			if count = 0 then
				multi_add:=addr;
				multi_reg_add:=instr(7 downto 0);
				
			end if;
			rf_wr_add_sig<=rf_wr_add_in;
			case instr(13 downto 12) is	
				when "00"=>--lw
					m_addr<=addr;
					d_out<=data_rd;
					rf_wr_out<=rf_wr_in;
					rf_wr_add_out<=rf_wr_add_sig;
				when "01"=>--sw					
					m_addr<=addr;
					data_wr<=d_in;
					rf_wr_out<=rf_wr_in;
					rf_wr_add_out<=rf_wr_add_sig;
				when "10"=>--lm
					if rising_edge(clk) then	
						if instr(count)='1' then
							m_addr<=multi_addr;
							data_wr<=d_in;
							d_out<=data_rd;
							multi_addr := std_logic_vector(to_unsigned(to_integer(unsigned(multi_addr))+2,m_addr'length));
						end if;
						rf_wr_out<=rf_wr_in and instr(count);
						rf_wr_add_out<=rf_wr_add_sig;
						rf_wr_add_sig<=std_logic_vector(to_unsigned(to_integer(unsigned(rf_wr_add_sig))-1,rf_wr_add_out'length));
						count:=count+1;
						if count>=8 then
							count:=0;
						end if;
							
					end if;
					
				when "11"=>--sm
					if rising_edge(clk) then
						m_addr<=addr;
						data_wr<=d_in;
						rf_wr_out<=rf_wr_in;
						rf_wr_add_out<=rf_wr_add_sig;
					end if;
					
			end case;
		end if;
	end process;
		
end behav;