--                                                   
-- Description :  hoMade core for slaves with their own IPs
-- 
-- ----------------------------------------------------------------------------------
-- Copyright : UNIVERSITE DE LILLE 1 - INRIA Lille Nord de France
--  Villeneuve d'Accsq France
-- 
-- Module Name  : Nexys3v6
-- Project Name : Homade V6
-- Revision :     IPcore timer
--                                         
-- Target Device :     spartan 6 spartan 3 virtex 7
-- Tool Version : tested on ISE 12.4,/14.7

-- Contributor(s) :
-- Dekeyser Jean-Luc ( Creation  juin 2012) jean-luc.dekeyser@univ_lille1.fr
-- 
-- 
-- Cecil Licence:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use work.IPcodes.all;

entity HSlave is
    Port 	(	clock: in std_logic;
					reset : in std_logic;
					xnum : std_logic_vector (4 downto 0);
					ynum : std_logic_vector (4 downto 0);
					put :out std_logic_vector(31 downto 0);
					get :in std_logic_vector(31 downto 0);
					put_en : out std_logic;
					starthcu: in std_logic;										
					startadr:in std_logic_vector(12 downto 0);
					ortree : out std_logic;
					xbit_broadcast, ybit_broadcast : in std_logic;
					we_broadcast : in std_logic;
					data_bit : in std_logic;
		         w_bit : in std_logic			
					);
	attribute clock_signal : string;
	attribute clock_signal of clock : signal is "yes";

end HSlave;

architecture Behavioral of HSlave is
--==================================================================
type state is (Idle,Wrapp_w,Hmemory_w) ;
signal next_state : state ;
--==================================================================
signal  Instbus : std_logic_vector(63 downto 0);
signal Adrbus, Tbusld,Tbusst,Nbusld,Nbusst,N2busld,N2busst,oversized, adjbus: std_logic_vector(31 downto 0);
signal Instructionbus: std_logic_vector(15 downto 0);
signal Icode: std_logic_vector(10 downto 0);
signal Bswbus: std_logic_vector(7 downto 0);
signal   IPd,Ird,  Nxi, ofs, nclock,clk_prod:  std_logic;
signal  BufOld, BusLdld : std_logic ;
signal   IPdwt, IPdft : std_logic :='0' ;
signal flag_activity,start_signal,ortreebus ,w48b: std_logic;
signal activity_set, activity_reset : std_logic;
signal flag_reset, actif : std_logic_vector (0 downto 0);
signal  bus_e: std_logic;
signal wr_dh, bus_d: std_logic_vector(47 downto 0);
signal wr_ah, bus_a, start: std_logic_vector(31 downto 0);
signal xb,yb : std_logic_vector (1 downto 0);


	attribute KEEP : string;
	attribute KEEP of Ird : signal is "yes";

COMPONENT HCU
	PORT(
		StartHomade : IN std_logic;
		Startadres : IN std_logic_vector(31 downto 0);
		clr : IN std_logic;
		clk : IN std_logic;
		offset : IN std_logic;
		ortree : out std_logic;
		orwait : in std_logic;
		it8 : in STD_LOGIC_VECTOR (2 downto 0);
		kernel : out std_logic;
		IPdone: in std_logic ;
		write_adr : out STD_LOGIC_VECTOR (31 downto 0);
		write_data : out STD_LOGIC_VECTOR (47 downto 0);
		w48e: out STD_LOGIC;
		Prog_instr : IN std_logic_vector(63 downto 0);          
		prog_adr : OUT std_logic_vector(31 downto 0);
		Tlit : out  STD_LOGIC_VECTOR (11 downto 0);
      Ipcode : out  STD_LOGIC_VECTOR (10 downto 0);
      LITload : out  STD_LOGIC;
		shortIP : out std_logic;
		X, Y : out std_logic_vector (1 downto 0) ;
		spmdcode: out std_logic_vector ( 12 downto 0);
		spmdtrig : out std_logic
		);
	END COMPONENT;
COMPONENT Hstack
   PORT( Nin	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          N2in	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          clk	:	IN	STD_LOGIC; 
          reset	:	IN	STD_LOGIC; 
          Tout	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          Nout	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
			 oversized	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0);
          N2out	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
			 offset : OUT std_logic;
          Litload	:	IN	STD_LOGIC; 
          Tin	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          Lit	:	IN	STD_LOGIC_VECTOR (11 DOWNTO 0); 
          ipdone	:	IN	STD_LOGIC; 
          shortIP	:	IN	STD_LOGIC; 
          X	:	IN	STD_LOGIC_VECTOR (1 DOWNTO 0); 
          Y	:	IN	STD_LOGIC_VECTOR (1 DOWNTO 0));
   END COMPONENT;

COMPONENT inst_mem 
    Port ( clk    : in  STD_LOGIC;
           addr_a : in  STD_LOGIC_VECTOR (11 downto 0);
           data_a : in  STD_LOGIC;
			  wphase : in std_logic;		  
			  w48    : in std_logic;
           addr_b : in  STD_LOGIC_VECTOR (5 downto 0);
			  addr_w : in  STD_LOGIC_VECTOR (5 downto 0);
			  data_w : in STD_LOGIC_VECTOR (47 downto 0);
           data_b : out  STD_LOGIC_VECTOR (63 downto 0)
			  );
end COMPONENT;
	COMPONENT add_gen
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		next_addr : IN std_logic;          
		addr1bit : OUT std_logic_vector(11 downto 0)
		);
	END COMPONENT;

  COMPONENT reset_mem
   PORT( clk	:	IN	STD_LOGIC; 
          reset_homade	:	IN	STD_LOGIC; 
          reset_mem	:	OUT	STD_LOGIC);
   END COMPONENT;
--
	COMPONENT QD
	generic (N : integer := 32);
	PORT(
		d : IN std_logic_vector(N-1 downto 0);
		clk: IN std_logic;          
		q : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;
	--
	---------------------------
	-- all the IPs here
	----------------------------
	--
COMPONENT IP_bufO
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		IPcode : IN std_logic_vector(10 downto 0);          
		BOld : OUT std_logic
		);
	END COMPONENT;
				

	
COMPONENT IP_wait
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		clk : in STD_LOGIC;
		reset : in std_logic;
		IPcode : IN std_logic_vector(10 downto 0);
		Tin : IN std_logic_vector (31 downto 0);          
		IPdone : OUT std_logic
		);
	END COMPONENT;

	
--	COMPONENT IP_fibo
--	GENERIC (Mycode : std_logic_vector (10 downto 0));
--	PORT(
--		Tin : IN std_logic_vector(31 downto 0);
--		clk : IN std_logic;
--		reset : in std_logic;
--		IPcode : IN std_logic_vector(10 downto 0);
--		Tout : OUT std_logic_vector(31 downto 0);		
--		IPdone : OUT std_logic
--		);
--	END COMPONENT;	

COMPONENT IP_Funit
	GENERIC (Mycode : std_logic_vector (5 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT IP_Stack
	GENERIC (Mycode : std_logic_vector (7 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		N2in : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);  
		clearstack : OUT std_logic;
		Tout : OUT std_logic_vector(31 downto 0);
		Nout : OUT std_logic_vector(31 downto 0);
		N2out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT IP_identity
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		N2in : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0);
		Nout : OUT std_logic_vector(31 downto 0);
		N2out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT IP_DataStack
	GENERIC (Mycode : std_logic_vector (9 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0);
		clk, clr : std_logic		);
	END COMPONENT;
	
COMPONENT IP_pushpop
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(

		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0);
		Nout : OUT std_logic_vector(31 downto 0);
		N2out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT IP_Tic
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		ipcode : IN std_logic_vector(10 downto 0);
		clk : IN std_logic;
		reset : IN std_logic;          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT IP_ram
	GENERIC (Mycode : std_logic_vector(9 downto 0);
				Pmem_length : integer
	);
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
COMPONENT IP_regfile
	GENERIC (Mycode : std_logic_vector (6 downto 0));
	PORT(
		clk : IN std_logic;
		Tin : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT IP_get
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		fromcom : in std_logic_vector(31 downto 0);
		ipcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT IP_Put
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(

		ipcode : IN std_logic_vector(10 downto 0);          
		put_ld : OUT std_logic
		);
	END COMPONENT;		
	
	COMPONENT IP_sleep
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(

		ipcode : IN std_logic_vector(10 downto 0);          
		activity_reset : OUT std_logic
		);
	END COMPONENT;
	
		COMPONENT IP_Snum
	GENERIC (Mycode : std_logic_vector (9 downto 0));
	PORT(

		ipcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0);
		xnum : IN std_logic_vector ( 4 downto 0) ;
		ynum : IN std_logic_vector ( 4 downto 0) 
		);
	END COMPONENT;
	COMPONENT IP_muladd
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		N2in : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;	

	COMPONENT IP_mul16
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;	
	
	COMPONENT IP_Rdm
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


	
signal add_wslave :   STD_LOGIC_VECTOR (11 downto 0):= "000000111111" ;
signal addr1bit  : STD_LOGIC_VECTOR (11 downto 0):= "000000000000";
signal litteral : std_logic_vector (11 downto 0);
signal litld, sip : std_logic;
signal resetmem : std_logic;
signal clearstack : std_logic;


	

type state_type is (idle,run);
    signal load_prom: state_type:=idle;	
	
begin

--   activity for each slave
	Activity_reg: QD
		generic map (N=>1)
		PORT MAP(
		d=> flag_reset,
		clk => clock,
		q => actif	);
-- init addresse reset
start <= "00000000000000000" & startadr & "00" ;
start_signal <= starthcu and actif(0);
-- activity global set local reset
flag_reset(0) <= (xbit_broadcast and ybit_broadcast and we_broadcast )or reset or ( not (activity_reset)  and (not we_broadcast) and   actif(0)) ;

--ortree <= ortreebus when actif(0) ='1' else '1';

ortree <= ortreebus and actif(0);

--	);			
--=============================================================
Inst_mem_Slave: inst_mem PORT MAP(
           clk => clock ,
			  addr_a => addr1bit(11 downto 0),
           data_a => data_bit,
			  wphase => w_bit ,
			  w48    => W48b,
			  
           addr_b => Adrbus(5 downto 0),
			  addr_w => wr_ah (5 downto 0),
			  data_w => wr_dh,
           data_b =>Instbus

);
Slave_add_gen: add_gen PORT MAP(
		clk => clock,
		reset => resetmem,
		next_addr => w_bit,
		addr1bit => addr1bit
	);


   rst_mem: reset_mem PORT MAP(
		clk => clock, 
		reset_homade => reset , 
		reset_mem => resetmem
   );


	HCU_Slave: HCU PORT MAP(
		StartHomade => start_signal,
		Startadres => start,
		clr => reset,
		clk => clock,
		offset =>ofs ,
		w48e=> w48b,
		it8=> "000",
		kernel => open,
		ortree=> ortreebus,
		orwait=>'0',
		write_adr => wr_ah,
		write_data => wr_dh,
		IPdone => Ipd,
		prog_adr => Adrbus,
		Prog_instr => Instbus,
		Tlit => Litteral,
           Ipcode => icode,
           LITload =>Litld,
			  shortIP =>Sip,
			  X => Xb,
			  Y => Yb 
			  );	
	--

	--
Stack_slave: Hstack PORT MAP(
		Tout => Tbusld,
		Nout => Nbusld,
		N2out => N2busld,
		Tin => Tbusst,
		Nin => NbusST,
		N2in => N2busST,		
		clk => clock, 
		reset => reset, 
		oversized => oversized,
		Litload => Litld  , 
		offset => ofs,
		Lit => Litteral, 
		ipdone => IPd, 
		shortIP => Sip, 
		X => Xb, 
		Y => Yb
   );	


	
--	Inst_IPfibo: IP_fibo
--		generic map (Mycode =>IPfibo)
--		PORT MAP(
--		Tin => Tbusld( 31 downto 0),
--		clk => clock,
--		reset => reset,
--		IPcode => Icode,
--		Tout => Tbusst,
--		IPdone => IPdft
--	);	
--

	IPd <= IPdwt  or IPdft;

Sfunit : if genS_funit = '1' generate
Inst_IPFunit: IP_Funit
		generic map (Mycode =>IPFunit)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		IPcode => Icode,
		Tout => Tbusst
	);
end generate Sfunit;	
	
SStack : if genS_Stack = '1' generate
Inst_IPStack: IP_Stack
		generic map (Mycode =>IPStack)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		N2in => N2busld,
		IPcode => Icode,
		clearstack => clearstack,
		Tout => Tbusst,
		Nout => NbusST,
		N2out => N2busST
	);
end generate SStack;	

Sidentity : if genS_identity = '1' generate
Inst_IPidentity: IP_identity
		generic map (Mycode =>IPidentity)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		N2in => N2busld,
		IPcode => Icode,
		Tout => Tbusst,
		Nout => NbusST,
		N2out => N2busST
	);
end generate Sidentity;	
	
SDataStack : if genS_DataStack = '1' generate
Inst_IPdataStack: IP_dataStack
		generic map (Mycode =>IPDataStack)
		PORT MAP(
		Tin => Tbusld,
		clk=> clock,
		clr=>reset, 
		IPcode => Icode,
		Tout => Tbusst
	);
end generate SDataStack;	

STic : if genS_Tic = '1' generate
Inst_IP_Tic: IP_Tic
		generic map (Mycode =>IPTic)
		PORT MAP(
		Tout => Tbusst,
		ipcode => Icode,
		clk =>clock ,
		reset => reset 
	);
end generate STic;

SRAM : if genS_RAM = '1' generate
	Inst_IPRAM : IP_RAM
		generic map (Mycode => IPRAM,
						 Pmem_length => 11)
		PORT MAP(
		Tin => Tbusld( 31 downto 0),
		Nin => Nbusld( 31 downto 0),
		clk => clock,
		IPcode => Icode,
		Tout => Tbusst
	);	
end generate SRAM;

Sregister : if genS_register = '1' generate
Inst_IP_regfile: IP_regfile 
		generic map (Mycode =>IPregister)
		PORT MAP(
		clk => clock,
		Tin => Tbusld,
		Tout => Tbusst,
		IPcode => Icode
	);
end generate Sregister;

SGet : if genS_Get = '1' generate
Inst_IP_get: IP_get
		generic map (Mycode =>IPGet)
		PORT MAP(
		fromcom => Get,
		Tout => Tbusst,
		ipcode => Icode
	);
end generate SGet;	

	Put <= Tbusld;
	
SPut : if genS_Put = '1' generate
	Inst_IP_Put: IP_Put
		generic map (Mycode =>IPPut)
		PORT MAP(

		put_ld => put_en,
		ipcode => Icode
	);
end generate SPut;	
	
SSnum : if genS_Snum = '1' generate
	Inst_IP_Snum: IP_Snum
		generic map (Mycode =>IPSnum)
		PORT MAP(
		Tout => Tbusst,
		xnum=> xnum,
		ynum => ynum,
		ipcode => Icode
	);
end generate SSnum;	

Ssleep : if genS_sleep = '1' generate
	Inst_IP_sleep: IP_sleep
		generic map (Mycode =>IPsleep)
		PORT MAP(

		activity_reset=> activity_reset,
		ipcode => Icode
	);	
end generate Ssleep;	

Srdm : if genS_rdm = '1' generate
Inst_IP_Rdm: IP_Rdm 
		generic map (Mycode =>IPRdm)
		PORT MAP(
		clk => clock,
		reset => reset,
		IPcode => Icode,
		Tout => Tbusst
	);
end generate Srdm;

--Smuladd : if genS_muladd = '1' generate
--Inst_IP_muladd: IP_muladd 
--		generic map (Mycode =>IPmuladd)
--		PORT MAP(
--		Tin => Tbusld,
--		Nin => Nbusld,
--		N2in => N2busld,
--		IPcode => Icode,
--		Tout => Tbusst
--	);	
--end generate Smuladd;	

Smul16 : if genS_mul16 = '1' generate
Inst_IP_mul16: IP_mul16
		generic map (Mycode =>IPmul16)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		IPcode => Icode,
		Tout => Tbusst
	);	
end generate Smul16;	

end Behavioral;

