[1mdiff --git a/subCircuit_IF.vhd b/subCircuit_IF.vhd[m
[1mindex e15511c..a3a13c8 100644[m
[1m--- a/subCircuit_IF.vhd[m
[1m+++ b/subCircuit_IF.vhd[m
[36m@@ -29,7 +29,7 @@[m [mbegin[m
 	P:process(clk, reset)[m
 	begin[m
 		if rising_edge(clk) then[m
[31m-			if (instr(15 downto 14) /= "10") and (instr(15 downto 12) /= "11") then[m
[32m+[m			[32mif (instr(15 downto 14) /= "10") and (instr(15 downto 14) /= "11") then[m
 				pc_wr <='1';[m
 				pc_write <= std_logic_vector(to_unsigned(to_integer(unsigned(pc_read))+2,pc_write'length));[m
 			else[m
[1mdiff --git a/uProcessor.vhd b/uProcessor.vhd[m
[1mindex d4fb50d..851a8ec 100644[m
[1m--- a/uProcessor.vhd[m
[1m+++ b/uProcessor.vhd[m
[36m@@ -141,6 +141,35 @@[m [mbegin[m
 		inp(57)=>c_write_rr,[m
 		inp(58)=>mem_Write_rr,[m
 		);[m
[32m+[m[41m	[m
[32m+[m	[32m--more ports to come[m
[32m+[m	[32mreg_rrex:master_reg generic map(regsize=>59) port map(clock=>clk, reset=>reset, wr=>'1',[m
[32m+[m		[32minp(15 downto 0)=>instr_RR,[m
[32m+[m		[32minp(31 downto 16)=>pc_inc_rr,[m
[32m+[m		[32minp(47 downto 32)=>pc_old_rr,[m
[32m+[m		[32minp(48)=>reg_write_rr,[m
[32m+[m		[32minp(51 downto 49)=>reg_write_add_rr,[m
[32m+[m		[32minp(52)=>reg_read_1_rr,[m
[32m+[m		[32minp(53)=>reg_read_2_rr,[m
[32m+[m		[32minp(54)=>read_c_rr,[m
[32m+[m		[32minp(55)=>read_z_rr,[m
[32m+[m		[32minp(56)=>z_write_rr,[m
[32m+[m		[32minp(57)=>c_write_rr,[m
[32m+[m		[32minp(58)=>mem_Write_rr,[m
[32m+[m[41m		[m
[32m+[m		[32moutp(15 downto 0)=>instr_EX,[m
[32m+[m		[32moutp(31 downto 16)=>pc_inc_ex,[m
[32m+[m		[32moutp(47 downto 32)=>pc_old_ex,[m
[32m+[m		[32minp(48)=>reg_write_ex,[m
[32m+[m		[32minp(51 downto 49)=>reg_write_add_ex,[m
[32m+[m		[32minp(52)=>reg_read_1_ex,[m
[32m+[m		[32minp(53)=>reg_read_2_ex,[m
[32m+[m		[32minp(54)=>read_c_ex,[m
[32m+[m		[32minp(55)=>read_z_ex,[m
[32m+[m		[32minp(56)=>z_write_ex,[m
[32m+[m		[32minp(57)=>c_write_ex,[m
[32m+[m		[32minp(58)=>mem_Write_ex,[m
[32m+[m		[32m);[m
 [m
 		[m
 end struct;[m
\ No newline at end of file[m
