--mux 2 to 1
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_2to1 is
 port(
 
     A,B,C,D : in STD_LOGIC(15 downto 0);
     S0,S1: in STD_LOGIC(15 downto 0);
     Z: out STD_LOGIC(15 downto 0)
  );
end mux_2to1;
 
architecture bhv of mux_2to1 is
begin
process (A,B,S0) is
begin
  if (S0 ='0' ) then
      Z <= A;
  
  else
      Z <= B;
  end if;
 
end process;
end bhv;



--mux 2to 1 (3bit)

library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_2to1_3bit is
 port(
 
     A,B,C,D : in STD_LOGIC(2 downto 0);
     S0,S1: in STD_LOGIC(2 downto 0);
     Z: out STD_LOGIC(2 downto 0)
  );
end mux_2to1_3bit;
 
architecture bhv1 of mux_2to1_3bit is
begin
process (A,B,S0) is
begin
  if (S0 ='0' ) then
      Z <= A;
  
  else
      Z <= B;
  end if;
 
end process;
end bhv1;







--mux 4 to 1--
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_4to1 is
 port(
 
     A,B,C,D : in STD_LOGIC(15 downto 0);
     S0,S1: in STD_LOGIC(15 downto 0);
     Z: out STD_LOGIC
  );
end mux_4to1;
 
architecture bhv2 of mux_4to1 is
begin
process (A,B,C,D,S0,S1) is
begin
  if (S0 ='0' and S1 = '0') then
      Z <= A;
  elsif (S0 ='0' and S1 = '1') then
      Z <= B;
  elsif (S0 ='1' and S1 = '0') then
      Z <= C;
  else
      Z <= D;
  end if;
 
end process;
end bhv2;









--mux 4 to 1 (1-bit)
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_4to1_1bit is
 port(
 
     A,B,C,D : in STD_LOGIC;
     S0,S1: in STD_LOGIC;
     Z: out STD_LOGIC
  );
end mux_4to1_1bit;
 
architecture bhv3 of mux_4to1_1bit is
begin
process (A,B,C,D,S0,S1) is
begin
  if (S0 ='0' and S1 = '0') then
      Z <= A;
  elsif (S0 ='1' and S1 = '0') then
      Z <= B;
  elsif (S0 ='0' and S1 = '1') then
      Z <= C;
  else
      Z <= D;
  end if;
 
end process;
end bhv3;



--mux 8 to 1
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux8to1 is
port ( s : in std_logic (2 downto 0); 
A : in std_logic;
B : in std_logic;
C : in std_logic;
D : in std_logic;
E : in std_logic;
F : in std_logic;
G : in std_logic;
H : in std_logic;
Z : out std_logic);
end mux8to1;

architecture equation of mux8to1 is
begin
alu : process( A,B, C, D, E, F, G, H, S)
begin
  if S="000" then
    Z <= A;
  elsif S="001" then
    Z <= B;
  elsif S="010" then
    Z <= C;
  elsif S="011" then
    Z <= D;
  elsif S="100" then
    Z <= E;
  elsif S="101" then
    Z <= F;
  elsif S="110" then
    Z <= G;
  else
    Z <= H;
end if;

end process;
end equation;


--mux 8 to 1 (3 bit)
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux8to1_3bit is
port ( s : in std_logic (2 downto 0); 
A : in std_logic (2 downto 0);
B : in std_logic (2 downto 0);
C : in std_logic (2 downto 0);
D : in std_logic (2 downto 0);
E : in std_logic (2 downto 0);
F : in std_logic (2 downto 0);
G : in std_logic (2 downto 0);
H : in std_logic (2 downto 0);
Z : out std_logic (2 downto 0));
end mux8to1_3bit;

architecture equation of mux8to1_3bit is
begin
alu : process( A,B, C, D, E, F, G, H, S)
begin
  if S="000" then
    Z <= A;
  elsif S="001" then
    Z <= B;
  elsif S="010" then
    Z <= C;
  elsif S="011" then
    Z <= D;
  elsif S="100" then
    Z <= E;
  elsif S="101" then
    Z <= F;
  elsif S="110" then
    Z <= G;
  else
    Z <= H;
end if;
end process;
end equation;





