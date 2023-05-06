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
	
	
	component subCircuit_IF is
		port(
			clk,reset: in std_logic;
			pc_read: in std_logic_vector(15 downto 0);
			pc_write: out std_logic_vector(15 downto 0);
			pc_wr:out std_logic;
			IR: out std_logic_vector(15 downto 0)
		);
	end component subCircuit_IF;
	component subCircuit_ID is
		port(
			
			clk,reset : in std_logic;
			instr_in : in std_logic_vector(15 downto 0);
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
		generic (regsize : integer := 16);
		port(
			clock,reset,wr: in std_logic;
			inp: in std_logic (regsize-1 downto 0);
			outp: out std_logic (regsize-1 downto 0)
		);
	end component master_reg;
	component subCircuit_RR is
	  port ( instr: in std_logic_vector(15 downto 0);
				clock,mem_wr_in: in std_logic;
				mem_wr_out: out std_logic;
				reg_read_1: in STD_LOGIC;
				reg_read_2: in STD_LOGIC;
				
				rf_a1,rf_a2:out std_logic_vector(2 downto 0);
				rf_d1,rf_d2:in std_logic_vector(15 downto 0);
				data_reg1, data_reg2 :out std_logic_vector(15 downto 0)
		 );
	end component subCircuit_RR;
	component subCircuit_EX is
	  port ( instr: in std_logic_vector(15 downto 0);
				data_reg1, data_reg2,pc_in :in std_logic_vector(15 downto 0);
				imm_6:in std_logic_vector(5 down to 0);
				imm_9:in std_logic_vector(8 down to 0);
				 clk :in std_logic;
				c,z:in std_logic_vector;
				c_out,z_out : out std_logic_vector;
			 ex_out,pc_out:out std_logic_vector(15 downto 0)
			 
		 );
		 
	end component subCircuit_EX;
	component r_1bit is 
		 port(
			clock,reset,wr,D: in std_logic;
			output: out std_logic
			);
	end component r_1bit;
	signal 
		pc_wr,
		reg_write_id,
		reg_read_1_id,
		reg_read_2_id,
		read_c_id,
		read_z_id,
		z_write_id,
		c_write_id,
		mem_Write_id,
		
		reg_write_rr,
		reg_read_1_rr,
		reg_read_2_rr,
		read_c_rr,
		read_z_rr,
		z_write_rr,
		c_write_rr,
		mem_Write_rr,
		mem_Write_rr_in,
		reg1_rr,
		reg2_rr,
		
		reg_write_ex,
		reg_read_1_ex,
		reg_read_2_ex,
		read_c_ex,
		read_z_ex,
		z_write_ex,
		c_write_ex,
		mem_Write_ex,
		reg1_ex,
		reg2_ex,c_data_in_ex,c_data_out_ex: std_logic :='0';
		
	signal 
		rf_d1,rf_d2,rf_d3, 
		pc_old_if,pc_inc_if,instr_IF, --pc_old_if is the curr instr pc, pc_inc_if is (prolly) incremented PC
		pc_old_id,pc_inc_id,instr_ID, 
		pc_old_rr,pc_inc_rr,instr_RR,
		pc_old_ex,pc_inc_ex,instr_EX: std_logic_vector(15 downto 0):= (others=>'0') 

	signal reg_write_add_id : std_logic_vector(2 downto 0) := "001";
	signal rf_a1,rf_a2,rf_a3:std_logic_vector(2 downto 0):="000";
begin
	
	rf : register_file port map(
		A1=>rf_a1,
		A2=>rf_a2,
		A3=>rf_a3,
		D1=>rf_d1,
		D2=>rf_d2,
		D3=>rf_d3,
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
		outp(47 downto 32)=>pc_old_id
	);
	
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
		outp(48)=>reg_write_rr,
		outp(51 downto 49)=>reg_write_add_rr,
		outp(52)=>reg_read_1_rr,
		outp(53)=>reg_read_2_rr,
		outp(54)=>read_c_rr,
		outp(55)=>read_z_rr,
		outp(56)=>z_write_rr,
		outp(57)=>c_write_rr,
		outp(58)=>mem_Write_rr_in
	);
	
	subCircuit_RR : subCircuit_RR port map(
		instr=>instr_RR,
		clock=>clk,
		reset=>reset,
		reg_read_1=>reg_read_1_rr,
		reg_read_2=>reg_read_2_rr,
		mem_wr_in=>mem_Write_rr_in,
		mem_wr_out=>mem_Write_rr,
		rf_a1=>rf_a1,
		rf_a2=>rf_a2,
		rf_d1=>rf_d1,
		rf_d2=>rf_d2,
		data_reg1=>reg1_rr, 
		data_reg2=>reg2_rr
	); 	
	reg_rrex:master_reg generic map(regsize=>91) port map(clock=>clk, reset=>reset, wr=>'1',
		inp(15 downto 0)=>instr_RR,
		inp(31 downto 16)=>pc_inc_rr,
		inp(47 downto 32)=>pc_old_rr,
		inp(48)=>reg_write_rr,
		inp(51 downto 49)=>reg_write_add_rr,
		inp(52)=>reg_read_1_rr,
		inp(53)=>reg_read_2_rr,
		inp(54)=>read_c_rr,
		inp(55)=>read_z_rr,
		inp(56)=>z_write_rr,
		inp(57)=>c_write_rr,
		inp(58)=>mem_Write_rr,
		inp(74 downto 59)=>reg1_rr,
		inp(90 downto 75)=>reg2_rr,
		
		outp(15 downto 0)=>instr_EX,
		outp(31 downto 16)=>pc_inc_ex,
		outp(47 downto 32)=>pc_old_ex,
		outp(48)=>reg_write_ex,
		outp(51 downto 49)=>reg_write_add_ex,
		outp(52)=>reg_read_1_ex,
		outp(53)=>reg_read_2_ex,
		outp(54)=>read_c_ex,
		outp(55)=>read_z_ex,
		outp(56)=>z_write_ex,
		outp(57)=>c_write_ex,
		outp(58)=>mem_Write_ex,
		outp(74 downto 59)=>reg1_ex,
		outp(90 downto 75)=>reg2_ex
	);
		
	c_flag:r_1bit port map(
		clock=>clk,
		reset=>reset,
		wr=>c_write_ex,
		D=>c_data_out_ex,
		output=>c_data_in_ex
	);
	z_flag:r_1bit port map(
		clock=>clk,
		reset=>reset,
		wr=>z_write_ex,
		D=>z_data_out_ex,
		output=>z_data_in_ex
	);
	subCircuit_EX:subCIrcuit_EX port map(
		instr=>instr_EX,
		data_reg1,
		data_reg2,
		pc_in=>pc_old_ex,
		imm_6,
		imm_9,
		clk=>clk,
		c=>c_data_in_ex,
		z=>z_data_in_ex,
		c_out=>c_data_out_ex,
		z_out=>z_data_out_ex,
		ex_out,
		pc_out
	);

		
end struct;