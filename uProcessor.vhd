library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity uProcessor is
	port(
		clk: in std_logic;
		reset: in std_logic
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
	
	component DataMemory is
	  port (addr: IN STD_LOGIC_VECTOR(15 downto 0);
			  din: IN STD_LOGIC_VECTOR(15 downto 0);
				 we: IN STD_LOGIC;
			  clk: IN STD_LOGIC;

			  dout: OUT STD_LOGIC_VECTOR(15 downto 0)
			  );
	end component DataMemory;
	
	component subCircuit_IF is
		port(
			clk,reset: in std_logic;
			pc_read: in std_logic_vector(15 downto 0);
			pc_write: out std_logic_vector(15 downto 0);
			pc_wr:out std_logic;
			IR: out std_logic_vector(15 downto 0);
		);
	end component subCircuit_IF;
	component master_reg is 
		generic (regsize : integer := 16;);
		port(
			clock,reset,wr: in std_logic;
			inp: in std_logic (regsize-1 downto 0);
			outp: out std_logic (regsize-1 downto 0)
		);
	end component master_reg;
	
	signal pc_wr : std_logic :='0';
	signal pc_old,pc_inc,instr_IF : std_logic_vector(15 downto 0):= (others=>'0') --pc_old is the curr instr pc, pc_inc is (prolly) incremented PC
begin
	
	rf : register_file port map(A1=>,A2=>,A3=>,D1=>,D2=>,D3=>,wr_en=> ,pc_wr=>pc_wr,pc_in=>pc_inc,pc_out=>pc_old,clock=>clk,reset=>reset);
	subCircuit_IF : subCircuit_IF port map(clk=>clk,reset=>reset,pc_read=>pc_old,pc_write=>pc_inc,pc_wr=>pc_wr,IR=>instr_IF);
	reg_ifid : master_reg generic map(regsize=>) port map(clock=>clk, reset=>reset, wr=>,inp=>,outp=>)
end struct;