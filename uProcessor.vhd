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
	component subCircuit_ID is
		port(
			
			clk,reset : in std_logic;
			instr_in ; in std_logic_vector(15 downto 0);
			reg_write: OUT STD_LOGIC;
				 reg_write_add: OUT STD_LOGIC_VECTOR(2 downto 0);
					  reg_read_1: OUT STD_LOGIC;
					  reg_read_2: OUT STD_LOGIC;
					  read_c: OUT STD_LOGIC;
					  read_z: OUT STD_LOGIC;
				 z_write: OUT STD_LOGIC;
				 
				 c_write: OUT STD_LOGIC;
						ID_Mem_Write: OUT STD_LOGIC
		);
	end component subCircuit_ID;
	component master_reg is 
		generic (regsize : integer := 16;);
		port(
			clock,reset,wr: in std_logic;
			inp: in std_logic (regsize-1 downto 0);
			outp: out std_logic (regsize-1 downto 0)
		);
	end component master_reg;
	
	signal pc_wr,reg_write_id,reg_read_1_id,reg_read_2_id,read_c_id,read_z_id,z_write_id,c_write_id,mem_Write_id,reg_write_rr,reg_read_1_rr,reg_read_2_rr,read_c_rr,read_z_rr,z_write_rr,c_write_rr,mem_Write_rr : std_logic :='0';
	signal pc_old_if,pc_inc_if,instr_IF, pc_old_id,pc_inc_id,instr_ID, pc_old_rr,pc_inc_rr,instr_rr: std_logic_vector(15 downto 0):= (others=>'0') --pc_old_if is the curr instr pc, pc_inc_if is (prolly) incremented PC
	signal reg_write_add_id : std_logic_vector(2 downto 0) := "001";
begin
	
	rf : register_file port map(
		A1=>,
		A2=>,
		A3=>,
		D1=>,
		D2=>,
		D3=>,
		wr_en=> ,
		pc_wr=>pc_wr,
		pc_in=>pc_inc_if,
		pc_out=>pc_old_if,
		clock=>clk,
		reset=>reset
		);
	
	subCircuit_IF : subCircuit_IF port map(clk=>clk,reset=>reset,
		pc_read=>pc_old_if,
		pc_write=>pc_inc_if,
		pc_wr=>pc_wr,
		IR=>instr_IF
		);
	
	reg_ifid : master_reg generic map(regsize=>48) port map(clock=>clk, reset=>reset, wr=>'1',
		inp(15 downto 0)=>instr_IF,
		inp(31 downto 16)=>pc_inc_if,
		inp(47 downto 32)=>pc_old_if,
		
		outp(15 downto 0)=>instr_ID,
		outp(31 downto 16)=>pc_inc_id,
		outp(47 downto 32)=>pc_old_id, );
	
	subCircuit_ID : subCircuit_ID port map(clk=>clk,reset=>reset,
		instr_in=>instr_ID,
		reg_write=>reg_write_id,
		reg_write_add=>reg_write_add_id,
		reg_read_1=>reg_read_1_id,
		reg_read_2=>reg_read_2_id,
		read_c=>read_c_id,
		read_z=>read_z_id,
		z_write=>z_write_id,
		c_write=>c_write_id,
		ID_Mem_Write=>mem_Write_id
		);
	
	reg_idrr : master_reg generic map(regsize=>59) port map(clock=>clk, reset=>reset, wr=>'1',
		inp(15 downto 0)=>instr_ID,
		inp(31 downto 16)=>pc_inc_id,
		inp(47 downto 32)=>pc_old_id,
		inp(48)=>reg_write_id,
		inp(51 downto 49)=>reg_write_add_id,
		inp(52)=>reg_read_1_id,
		inp(53)=>reg_read_2_id,
		inp(54)=>read_c_id,
		inp(55)=>read_z_id,
		inp(56)=>z_write_id,
		inp(57)=>c_write_id,
		inp(58)=>mem_Write_id,
		
		outp(15 downto 0)=>instr_RR,
		outp(31 downto 16)=>pc_inc_rr,
		outp(47 downto 32)=>pc_old_rr,
		inp(48)=>reg_write_rr,
		inp(51 downto 49)=>reg_write_add_rr,
		inp(52)=>reg_read_1_rr,
		inp(53)=>reg_read_2_rr,
		inp(54)=>read_c_rr,
		inp(55)=>read_z_rr,
		inp(56)=>z_write_rr,
		inp(57)=>c_write_rr,
		inp(58)=>mem_Write_rr,
		);

		
end struct;