library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity if_id is
	port(
			clock,wrifid,resetifid : in std_logic;
			ifidinc, ifidpc, ifidimem : in std_logic_vector(15 downto 0);
			ifidincout, ifidpcout, ifidimemout : out std_logic_vector(15 downto 0);
			);
end if_id;

architecture a1 of if_id is

component r_1bit is
    port(
		clock,reset,wr,D: in std_logic;
		output: out std_logic
		);
end component;

component r_3bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(2 downto 0)
		);
end component;

component r_4bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(3 downto 0)
		);
end component;

component r_6bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(5 downto 0);
		output: out std_logic_vector(5 downto 0)
		);
end component;

component r_9bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(8 downto 0);
		output: out std_logic_vector(8 downto 0)
		);
end component;

component reg is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0)
		);
end component;

begin

pc: reg port map (clock,resetifid,wrifid,ifidpc,ifidpcout);
inc: reg port map (clock,resetifid,wrifid,ifidinc,ifidincout);
imem: reg port map (clock,resetifid,wrifid,ifidimem,ifidimemout);

end a1;


-----------------------------------------------------------
library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity id_rr is 
    port(
		clock,resetidrr,wridrr : in std_logic;
		idrropcode : in std_logic_vector(3 downto 0);
      idrrpc, idrrinc : in std_logic_vector(15 downto 0);
		idrr11_9, idrr8_6, idrr5_3 : in std_logic_vector(2 downto 0);
		idrr8_0 : in std_logic_vector(8 downto 0);
		idrr5_0 : in std_logic_vector(5 downto 0);
		idrropcodeout : out std_logic_vector(3 downto 0);
		idrrpcout, idrrincout : out std_logic_vector(15 downto 0);
		idrr11_9out, idrr8_6out, idrr5_3out : out std_logic_vector(2 downto 0);
		idrr8_0out : out std_logic_vector(8 downto 0);
		idrr5_0out : out std_logic_vector(5 downto 0);
		);
end id_rr;

architecture a2 of if_id is

component r_1bit is
    port(
		clock,reset,wr,D: in std_logic;
		output: out std_logic
		);
end component;

component r_3bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(2 downto 0)
		);
end component;

component r_4bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(3 downto 0);
		output: out std_logic_vector(3 downto 0)
		);
end component;

component r_6bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(5 downto 0);
		output: out std_logic_vector(5 downto 0)
		);
end component;

component r_9bit is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(8 downto 0);
		output: out std_logic_vector(8 downto 0)
		);
end component;

component reg is
port(
		clock,reset,wr: in std_logic;
		D: in std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0)
		);
end component;

begin

pc: reg port map (clock,resetidrr,wridrr,idrrpc,idrrpcout);
inc: reg port map (clock,resetidrr,wridrr,idrrinc,idrrincout);
opcode: r_4bit port map (clock,resetidrr,wridrr,idrrinc,idrrincoutwridrr, clock=>clock, data=>IDRR_opcode, Op=>IDRR_opcode_Op, clr=>clr_IDRR);
eleven_nine: reg3 port map (wr=>wridrr, clock=>clock, data=>IDRR_11_9, Op=>IDRR_11_9_Op, clr=>clr_IDRR);
eight_six: reg3 port map (wr=>wridrr, clock=>clock, data=>IDRR_8_6, Op=>IDRR_8_6_Op, clr=>clr_IDRR);
five_three: reg3 port map (wr=>wridrr, clock=>clock, data=>IDRR_5_3, Op=>IDRR_5_3_Op, clr=>clr_IDRR);
eight_zero: reg9 port map (wr=>wridrr, clock=>clock, data=>IDRR_8_0, Op=>IDRR_8_0_Op, clr=>clr_IDRR);
five_zero: reg6 port map (wr=>wridrr, clock=>clock, data=>IDRR_5_0, Op=>IDRR_5_0_Op, clr=>clr_ID

