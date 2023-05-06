library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity subCircuit_ID is
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
end subCircuit_ID;
architecture a2 of subCircuit_ID is 
begin
      process(clk,instr_in)
      begin
          case instr_in(15 downto 12) is
              when "0001" => --ADD
                reg_write <= '1';
                reg_write_add <= instr_in(5 downto 3);
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								if instr_in(1 downto 0) = "00" then
									read_c <= '0';
									read_z <= '0';
								elsif instr_in(1 downto 0) = "01" then
									read_c <= '0';
									read_z <= '1';
								elsif instr_in(1 downto 0) = "10" then
									read_c <= '1';
									read_z <= '0';
								else
									read_c <= '0';
									read_z <= '0';
								end if;
								z_write <='1';
                        c_write <='1';
                
                
								ID_Mem_Write <= '0';
								
								
				  when "0000" => --ADI
                reg_write <= '1';
                reg_write_add <= instruction_in(8 downto 6);
								reg_read_1 <= '1';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='1';
                c_write <='1';
                
								ID_Mem_Write <= '0';		
						
				
		       when "0010" =>  --NAND
			        reg_write <= '1';
                 reg_write_add <= instruction_in(5 downto 3);
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								if instruction_in(1 downto 0) = "00" then
									read_c <= '0';
									read_z <= '0';
								elsif instruction_in(1 downto 0) = "01" then
									read_c <= '0';
									read_z <= '1';
								elsif instruction_in(1 downto 0) = "10" then
									read_c <= '1';
									read_z <= '0';
								else
									read_c <= '0';
									read_z <= '0';
								end if;
								
						z_write <='1';
                  c_write <='0';
             
						ID_Mem_Write <= '0';	
					
				
			   when "0011" => --LLI
			      reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                c_write <='0';
                
					 ID_Mem_Write <='0'	;
					 
					 
				when "0100" => --LW
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='1';
                c_write <='0';
               
                
								ID_Mem_Write <= '0';

              when "0101" => --SW
                reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
					 c_write <='0';
                
					 ID_Mem_Write <= '1';
					 
				  when "0110" =>--lm
					reg_write <= '1';
					reg_write_add <= "111";
							reg_read_1 <= '1';
							reg_read_2 <= '0';
							read_c <= '0';
							read_z <= '0';
					 z_write <='0';
					 c_write <='0';
				  when "0111" =>--sm
					 reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '0';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
					 c_write <='0';
				  when "1000" => --BEQ
                reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0'; 
                z_write <= '0';
                c_write <='0';
                
					 ID_Mem_Write <= '0';

             
					
					 
					 
				  
				  when "1001" => --BLT
				    reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0'; 
                z_write <= '0';
                c_write <='0';
                
					 ID_Mem_Write <= '0';
					
				  when "1011" => --BLE
				   reg_write <= '0';
                reg_write_add <= "000";
								reg_read_1 <= '1';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0'; 
                z_write <= '0';
                c_write <='0';
                
					 ID_Mem_Write <= '0';
					 
					 
				  when "1100" => --JAL
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                c_write <='0';
                
					 ID_Mem_Write <= '0'; 
					 
					
					
				  when "1101" => --JLR
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                c_write <='0';
                
					 ID_Mem_Write <= '0'; 

              when "1111" => --JRI
                reg_write <= '1';
                reg_write_add <= instruction_in(11 downto 9);
								reg_read_1 <= '0';
								reg_read_2 <= '1';
								read_c <= '0';
								read_z <= '0';
                z_write <='0';
                c_write <='0';
                
					 ID_Mem_Write <= '0'; 
					
				
			
		 end case;
		end process;
end a2;	