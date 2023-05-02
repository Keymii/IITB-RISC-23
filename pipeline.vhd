library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity if_id is
	port(
			clock,wrifid,resetifid : in std_logic;
			ifidinc, ifidpc, ifidimem : in std_logic_vector(15 downto 0);
			ifidincout, ifidpcout, ifidimemout : out std_logic_vector(15 downto 0)
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
		
		idrr8_0 : in std_logic_vector(8 downto 0);
		idrr11_9, idrr8_6, idrr5_3 : in std_logic_vector(2 downto 0);
		idrr5_0 : in std_logic_vector(5 downto 0);
		idrr11_9out, idrr8_6out, idrr5_3out : out std_logic_vector(2 downto 0);
		idrropcodeout : out std_logic_vector(3 downto 0);
		idrr8_0out : out std_logic_vector(8 downto 0);
		idrrpcout, idrrincout : out std_logic_vector(15 downto 0);
	   idrr5_0out : out std_logic_vector(5 downto 0)
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
opcode: r_4bit port map (clock,resetidrr,wridrr,idrrinc,idrrincout);
eleven_nine: r_3bit port map (clock,resetidrr,wridrr ,idrr11_9, idrr11_9out);
eight_six: r_3bit port map (clock, resetidrr,idrr8_6, idrr8_6out);
five_three: r_3bit port map (clock, resetidrr, idrr5_3, idrr5_3out);
eight_zero: r_9bit port map (clock, resetidrr, idrr8_0, idrr8_0out);
five_zero: r_6bit port map (clock, resetidrr, idrr5_0, idrr5_0out);

end a2;
---------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity rr_ex is 
    port(
		clock : in std_logic;
		resetrrex: in std_logic;
		wrrrex, rrex_match : in std_logic;
		rrexindexout : in integer;
		rrexopcode : in std_logic_vector(3 downto 0);
      rrexinc, rrexpc, rrexrfd1, rrexlmsm, rrexrfd2 : in std_logic_vector(15 downto 0);
		rrex11_9, rrex8_6, rrex5_3, rrexdec : in std_logic_vector(2 downto 0);
		rrex8_0 : in std_logic_vector(8 downto 0);
		rrex5_0 : in std_logic_vector(5 downto 0);
		rrexopcode_Op : out std_logic_vector(3 downto 0);
		rrexinc_Op, rrexpc_Op, rrexrfd1_Op, rrexlmsm_Op, rrexrfd2_Op : out std_logic_vector(15 downto 0);
		rrex11_9_Op, rrex8_6_Op, rrex5_3_Op, rrexdec_Op : out std_logic_vector(2 downto 0);
		rrex8_0_Op : out std_logic_vector(8 downto 0);
		rrex5_0_Op : out std_logic_vector(5 downto 0)
		
		);
end rr_ex;

architecture a3 of rr_ex is

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

opcode: r_4bit port map (clock, resetrrex, wrrrex, rrexopcode, rrexopcode_Op);
inc: reg port map (clock, resetrrex, wrrrex, rrexinc, rrexinc_Op);
PC: reg port map (clock, resetrrex, wrrrex,rrexpc, rrexpc_Op);
RF_D1: reg port map (clock, resetrrex, wrrrex, rrexrfd1, rrexrfd1_Op);
LMSM: reg port map (clock, resetrrex, wrrrex, rrexlmsm, rrexoplmsm_Op);
RF_D2: reg port map (clock, resetrrex, wrrrex, rrexrfd2, rrexrfd2_Op);
dec: r_3bit port map (clock, resetrrex, wrrrex, rrexdec, rrexdec_Op);
eleven_nine: r_3bit port map (clock, resetrrex, wrrrex, rrex11_9, rrex11_9_Op);
eight_six: r_3bit port map (clock, resetrrex, wrrrex, rrex8_6, rrex8_6_Op);
five_three: r_3bit port map (clock, resetrrex, wrrrex, rrex5_3, rrex5_3_Op);
eight_zero: r_9bit port map (clock, resetrrex, wrrrex, rrex8_0, rrex8_0_Op);
five_zero: r_6bit port map (clock, resetrrex, wrrrex, rrex5_0, rrex5_0_Op);


end a3;

---------------------------------------------------------------
 library std;
library ieee;
use std.standard.all;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_ma is 
    port(
		clock,resetexma, wriexma : in std_logic;
		
		
		exmaopcode : in std_logic_vector(3 downto 0);
      exmainc, exmapc, exma_RFD1, exma_LMSM, exma_RFD2, exma_ALU_C, exma_SE6, exma_SE9 : in std_logic_vector(15 downto 0);
		exma11_9, exma8_6, exma5_3, exma_dec : in std_logic_vector(2 downto 0);
		exma8_0 : in std_logic_vector(8 downto 0);
		exma5_0 : in std_logic_vector(5 downto 0);
		exma_c, exma_z : in std_logic;
		exma_opcode_Op : out std_logic_vector(3 downto 0);
		exmainc_Op, exmapcout, exma_RFD1out, exma_RFD2out, exma_ALU_C_Op, exma_SE6_Op, exma_SE9_Op : out std_logic_vector(15 downto 0);
		exma11_9out, exma8_6out, exma5_3out, exma_dec_Op : out std_logic_vector(2 downto 0);
		exma8_0_Op : out std_logic_vector(8 downto 0);
		exma5_0_Op : out std_logic_vector(5 downto 0);
		exma_cout, exma_zout : out std_logic
		
		);
end ex_ma;

architecture a4 of ex_ma is

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





