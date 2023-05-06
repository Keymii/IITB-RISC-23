library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity subCircuit_EX is
  port ( instr: in std_logic_vector(15 downto 0);
		   data_reg1, data_reg2,pc_in :in std_logic_vector(15 downto 0);
			imm_6:in std_logic_vector(5 down to 0);
			imm_9:in std_logic_vector(8 down to 0);
          clk :in std_logic;
			c,z:in std_logic_vector;
			c_out,z_out : out std_logic_vector;
		 ex_out,pc_out:out std_logic_vector(15 downto 0)
		 
    );
	 
end subCircuit_EX;
architecture behav of subCircuit_EX is
signal bit17,s1,s3,s4,s5,s8,s10,s11,s12 : std_logic_vector(16 downto 0);
signal s2,s6,s7,s9,mem_add : std_logic_vector(15 downto 0);
begin
process(instr,clk)

begin

     case instr(15 downto 12) is
	       when "0001" => --ADD
			   
			 		if instr_in(2 downto 0) = "000" then
						s1<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(data_reg2))),bit17'length));
						ex_out<=s1(15 down to 0);
						c_out<= s1(16);
						
						 if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						 else
						  z_out <='0';
						 end if;
						
			 		elsif instr_in(2 downto 0) = "001" then
						if z='1' then
							s1<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(data_reg2))),bit17'length));
							ex_out<=s1(15 down to 0);
						    c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 else
							ex_out<="0000000000000000";
						end if;

			 		elsif instr_in(2 downto 0) = "010" then
						if c='1' then
						
						s1<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(data_reg2))),bit17'length));
							ex_out<=s1(15 down to 0);
						    c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 else
							ex_out<="0000000000000000";
						end if;
							
			 		elsif instr_in(2 downto 0) = "011" then
							s2<="000000000000000"& c;
							s3<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(data_reg2)))+(to_integer(unsigned(s2)))),bit17'length);
							ex_out<=s3(15 down to 0);
							c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 
			 		elsif instr_in(2 downto 0) = "100" then
						s4<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+not((to_integer(unsigned(data_reg2)))),bit17'length));
						ex_out<=s4(15 down to 0);
					   c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
							
					
			 		elsif instr_in(2 downto 0) = "101" then
						if z='1' then
							s4<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+not((to_integer(unsigned(data_reg2)))),bit17'length));
							ex_out<=s4(15 down to 0);
							c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 else
							ex_out<="0000000000000000";
						end if;
						
			 		elsif instr_in(2 downto 0) = "110" then
						if c='1' then
							s4<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+not((to_integer(unsigned(data_reg2)))),bit17'length));
							ex_out<=s4(15 down to 0);
						  c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 else
							ex_out<="0000000000000000";
						end if;
						
			 		elsif instr_in(2 downto 0) = "111" then
							s2<="000000000000000"& c;
							s5<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+not((to_integer(unsigned(data_reg2))))+(to_integer(unsigned(s2)))),bit17'length);
							ex_out<=s5(15 down to 0);	
							
					   c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						 
						end if;
						
	       when "0000" => --ADI
							s6<="00000000000"& imm_6;
							s7<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(s6))),bit17'length));
							ex_out<=s7(15 down to 0);
					      c_out<= s1(16);
							
						  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;		
			 
	       when "0010" => --NAND
				 		if instr_in(2 downto 0) = "000" then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand (to_integer(unsigned(data_reg2))),s2'length));
				 		   if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						elsif instr_in(2 downto 0) = "001" then
						  if z='1' then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand (to_integer(unsigned(data_reg2))),s2'length));
							if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
							
							else
							ex_out<="0000000000000000";
							end if;
				 		elsif instr_in(2 downto 0) = "010" then
						  if c='1' then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand (to_integer(unsigned(data_reg2))),s2'length));
							if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
							
							else
							ex_out<="0000000000000000";
							end if;
				 		elsif instr_in(2 downto 0) = "100" then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand not((to_integer(unsigned(data_reg2)))),s2'length));
				 		  if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
						
						elsif instr_in(2 downto 0) = "101" then
						  if z='1' then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand not((to_integer(unsigned(data_reg2)))),s2'length));
							if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
							
							else
							ex_out<="0000000000000000";
							end if;
				 		elsif instr_in(2 downto 0) = "110" then
						  if c='1' then
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1)) nand not((to_integer(unsigned(data_reg2)))),s2'length));
							if (s1(15 downto 0)=(others =>0)) then
						  z_out <='1';
						  else
						  z_out <='0';
					     end if;
							
							else
							ex_out<="0000000000000000";
							end if;
						end if;
	       when "0011" => --LLI
							ex_out<="0000000"&imm_9;


	       when "0100" => --LW
							s6<="00000000000"& imm_6;
							s12<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg2))+(to_integer(unsigned(s6))),bit17'length));
							mem_add<=s12(15 down to 0);		
						   ex_out<=mem_add;
	       when "0101" => --SW
							s6<="00000000000"& imm_6;
							s12<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg2))+(to_integer(unsigned(s6))),bit17'length));
							mem_add<=s12(15 down to 0);		
							ex_out<=mem_add;
							
			 when "0110" => --lm
							ex_out<=(others=>'0');
			 when "0111" => --sm
							ex_out<=(others=>'0');
							
							
	       when "1000" => --BEQ
					if data_reg1=data_reg2 then
							s6<="00000000000"& imm_6;
							s8<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+(to_integer(unsigned(s6)))+(to_integer(unsigned(s6)))),bit17'length);
							pc_out<=s8(15 down to 0);
						   ex_out<=s8(15 down to 0);
					else
							ex_out<="0000000000000000";
							pc_out<="0000000000000000";
					end if;	
	       when "1001" => --BLT
					if (data_reg1<data_reg2) then
							s6<="00000000000"& imm_6;
							s8<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+(to_integer(unsigned(s6)))+(to_integer(unsigned(s6)))),bit17'length);
							ex_out <=s8(15 down to 0);
							pc_out<=s8(15 down to 0);
					else
							ex_out<="0000000000000000";
							pc_out<="0000000000000000";
					end if;					
			 
	       when "1011" => --BLE
					if (data_reg1=data_reg2) OR (data_reg1<data_reg2) then
					s6<="00000000000"& imm_6;
					s8<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+(to_integer(unsigned(s6)))+(to_integer(unsigned(s6)))),bit17'length);
							ex_out<=s8(15 down to 0);
							pc_out<=s8(15 down to 0);
					else
							ex_out<="0000000000000000";
							pc_out<="0000000000000000";
					end if;
	       when "1100" => --JAL
							s9<="000000"& imm_9;
							s10<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+(to_integer(unsigned(s9)))+(to_integer(unsigned(s9)))),bit17'length);
							pc_out<=s10(15 down to 0);
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+2,s2'length));
	       when "1101" => --JLR
							s6<="00000000000"& imm_6;
							s8<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+(to_integer(unsigned(data_reg2)))),bit17'length);
							pc_out<=s8(15 down to 0);
							ex_out<=std_logic_vector(to_unsigned(to_integer(unsigned(pc_in))+2,s2'length));			 
	       when "1111" => --JRI
							s9<="0000000"&imm_9;
							s11<=std_logic_vector(to_unsigned(to_integer(unsigned(data_reg1))+(to_integer(unsigned(s9)))+(to_integer(unsigned(s9)))),bit17'length);
							pc_out<=s11(15 down to 0);
			 when others =>
							Null;
						
	end case;					
					
end process;

end behav;