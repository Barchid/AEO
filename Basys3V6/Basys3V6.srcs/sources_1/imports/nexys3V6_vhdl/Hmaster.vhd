--                                                   
-- Description :  HoMade core  for master  : some IPs are in comment
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


library unisim;
use unisim.vcomponents.all;

entity HMaster is
    Port 	(	clock: in std_logic;
					reset : in std_logic;
					Out32 :out std_logic_vector(31 downto 0);
					Out16:out std_logic_vector(15 downto 0);
					In16:in std_logic_vector(15 downto 0);
					InBtn : in std_logic_vector (4 downto 0);
					ortree : out std_logic;
					IT8 : in std_logic_vector (2 downto 0);
					kernel : out std_logic;
  --   clock Wrapper ============
			--   Master ============
              
              enb      : in STD_LOGIC;
				  data_WR : in STD_LOGIC ;
			--   Slaves ============
              data_S             : in     STD_LOGIC;
              wphase_S           : in     STD_LOGIC
					);
	attribute clock_signal : string;
	attribute clock_signal of clock : signal is "yes";

end HMaster;

architecture Behavioral of HMaster is

----- salve
constant NX_SLAVE : integer := 0;
constant NY_SLAVE : integer := 0;

constant NBSLAVE : integer := NX_SLAVE * NY_SLAVE;
--==================================================================
type state is (Idle,Wrapp_w,Hmemory_w) ;
signal next_state : state ;
--==================================================================
signal  Instbus : std_logic_vector(63 downto 0);
signal Adrbus, Tbusld,Tbusst,Nbusld,Nbusst,N2busld,N2busst, OSbusld, oversized: std_logic_vector(31 downto 0) := (others => '0');
signal bbx :std_logic_vector(31 downto 0) ;
signal bby :std_logic_vector(31 downto 0) ;
signal Icode: std_logic_vector(10 downto 0);
signal Bswbus: std_logic_vector(15 downto 0);
signal   IPd,Ird,  Nxi, ofs, nclock,clk_prod, ort, we_bcast,we_bit, Sip:  std_logic;
signal  BufOld, BusLdld ,shift_cmd_1,shift_cmd_32,ld_reg0: std_logic ;
signal  IPdbt, IPdwt, IPdft, IPdC32 : std_logic := '0' ;
signal bus_d , bus_e, write_net_en, ld_actif, W48b: std_logic;
signal wr_dh: std_logic_vector(47 downto 0);
signal wr_ah, bus_a, dbuslink0,dbus0: std_logic_vector(31 downto 0);
signal addr_WR : std_logic_vector(11 downto 0);
signal spmdt, shift_xy , shift_pm, tore: std_logic;
signal spmdc : std_logic_vector (12 downto 0) ;







signal shift_cmd : std_logic ;
type std_link is  array (0 to NX_SLAVE -1, 0 to NY_SLAVE - 1) of STD_Logic;
signal Dlink , Qlink, Ld_reg_link, ort_link, ortbus2D: std_link;
type std_vector_link is array (0 to NX_SLAVE -1, 0 to NY_SLAVE - 1) of STD_Logic_vector (31 downto 0) ;
signal D_bus_link , Q_bus_link : std_vector_link;
-- parallel communication
type sel_vector_link is array (0 to NX_SLAVE -1, 0 to NY_SLAVE - 1) of STD_Logic_vector (1 downto 0) ;
signal sel_ring : sel_vector_link;

component HSlave
	Port 	(		clock: in std_logic;
					xnum : std_logic_vector (4 downto 0);
					ynum : std_logic_vector (4 downto 0);
					reset : in std_logic;
					put:out std_logic_vector(31 downto 0);
					put_en : out std_logic;
					get:in std_logic_vector(31 downto 0);
					starthcu: in std_logic;										
					startadr:in std_logic_vector(12 downto 0);
					ortree : out std_logic;
					xbit_broadcast, ybit_broadcast : in std_logic;
					we_broadcast : in std_logic;
					data_bit : in std_logic;
		         w_bit : in std_logic
					--============
					);
end component;


	COMPONENT netring
   PORT( I_X	, I_Xmoins:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          I_Y, I_Ymoins	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          clk	:	IN	STD_LOGIC; 
          I_put	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          O	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          E_shift	:	IN	STD_LOGIC; 
          E_put	:	IN	STD_LOGIC; 
          X_Y, P_M	:	IN	STD_LOGIC);
   END COMPONENT;
	
   COMPONENT netring_master
   PORT( I_X	, I_Xmoins:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          I_Y	, I_Ymoins:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          clk	:	IN	STD_LOGIC; 
          I_put	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          E_shift	:	IN	STD_LOGIC; 
          E_put	:	IN	STD_LOGIC; 
          X_Y	, P_M:	IN	STD_LOGIC; 
          E_master	:	IN	STD_LOGIC; 
          O	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          I_master	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0));
   END COMPONENT;
------------------------------------------------------------------------
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
--           IPtrig : out  STD_LOGIC;
      Ipcode : out  STD_LOGIC_VECTOR (10 downto 0);
      LITload : out  STD_LOGIC;
		shortIP : out std_logic;
		X, Y : out std_logic_vector (1 downto 0);
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

--================================================================
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
--================================================================

	
COMPONENT reg0
	generic (N : integer := 16);
	PORT(
		load : IN std_logic;
		d : IN std_logic_vector(N-1 downto 0);
		clr ,clk: IN std_logic;          
		q : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;
COMPONENT reg0c
	generic (N : integer := 16);
	PORT(
		d : IN std_logic_vector(N-1 downto 0);
		clr ,clk: IN std_logic;          
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
	
COMPONENT IP_actif
	GENERIC (Mycode : std_logic_vector (8 downto 0));
	PORT(
		IPcode : IN std_logic_vector(10 downto 0);
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);          
		bit_broadcast_X : OUT std_logic_vector(31 downto 0);
		bit_broadcast_Y : OUT std_logic_vector(31 downto 0);		
		load_actif: OUT std_logic
		);
	END COMPONENT;
	
COMPONENT IP_Led
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		IPcode : IN std_logic_vector(10 downto 0);          
		BusLedld : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT	IP_switch 
	GENERIC (Mycode : std_logic_vector (10 downto 0));
   Port ( 
		Bsw : in  STD_LOGIC_VECTOR (15 downto 0);
      IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
		Tout : out  STD_LOGIC_VECTOR (31 downto 0));
	END COMPONENT;

COMPONENT IP_delay
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		clk : in STD_LOGIC;
		IPcode : IN std_logic_vector(10 downto 0);
		Tin : IN std_logic_vector (31 downto 0);          
		IPdone : OUT std_logic
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
	
COMPONENT IP_waitBt
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(4 downto 0);
		clk : IN std_logic;
		reset : in std_logic;
		IPcode : IN std_logic_vector(10 downto 0);
		Btn : IN std_logic_vector(4 downto 0); 
		Tout : OUT std_logic_vector(31 downto 0);		
		IPdone : OUT std_logic
		);
	END COMPONENT;	
--	
COMPONENT IP_fibo
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		reset : in std_logic;
		IPcode : IN std_logic_vector(10 downto 0);
		Tout : OUT std_logic_vector(31 downto 0);		
		IPdone : out std_logic
		);
	END COMPONENT;	

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
	

COMPONENT IP_Tic
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		ipcode : IN std_logic_vector(10 downto 0);
		clk : IN std_logic;
		reset : IN std_logic;          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT IP_Com
	GENERIC (Mycode : std_logic_vector (7 downto 0));
	PORT(
		ipcode : IN std_logic_vector(10 downto 0);
      shift_xy, shift_pm: out std_logic;  
		tore : out std_logic;		
		Shift_en : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT IP_MEcom
	GENERIC (Mycode : std_logic_vector (9 downto 0));
	PORT(
		ipcode : IN std_logic_vector(10 downto 0);
		Tin: in std_logic_vector (31 downto 0);
		Tout: out std_logic_vector (31 downto 0);
		Qbus: in std_logic_vector (31 downto 0);
		Dbus: out std_logic_vector (31 downto 0);
		write_net : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT IP_Rdm
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		clk , reset: IN std_logic;
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
--COMPONENT IP_muladd
--	GENERIC (Mycode : std_logic_vector (10 downto 0));
--	PORT(
--		Tin : IN std_logic_vector(31 downto 0);
--		Nin : IN std_logic_vector(31 downto 0);
--		N2in : IN std_logic_vector(31 downto 0);
--		IPcode : IN std_logic_vector(10 downto 0);          
--		Tout : OUT std_logic_vector(31 downto 0)
--		);
--	END COMPONENT;
	
COMPONENT IP_mul16
	GENERIC (Mycode : std_logic_vector (10 downto 0));
	PORT(
		Tin : IN std_logic_vector(31 downto 0);
		Nin : IN std_logic_vector(31 downto 0);
		IPcode : IN std_logic_vector(10 downto 0);          
		Tout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	



signal ortbus : std_logic_vector ( NX_SLAVE-1 downto 0) ;
signal  Xb, Yb: std_logic_vector (1 downto 0);
signal litld : std_logic;
signal Litteral : std_logic_vector (11 downto 0);	
signal resetmem : std_logic;
signal clearstack: std_logic;
signal reset_or_clearstack : std_logic :=  reset or clearstack;
signal shift_and_tore : std_logic := shift_cmd and tore;
signal shift_cmd_tore_shift_xy : std_logic := shift_cmd and (tore or not shift_xy);
begin
--
Inst_mem_Master: inst_mem Port map( 
	        clk    => clock,
           addr_a =>  addr_WR,
           data_a => data_WR,
			  wphase => enb,
			  
			  w48    => w48b,
           addr_b => Adrbus(5 downto 0),
			  addr_w =>  wr_ah(5 downto 0),
			  data_w => wr_dh,
           data_b => Instbus
			  );

Inst_add_gen: add_gen PORT MAP(
		clk => clock,
		reset => resetmem,
		next_addr => enb,
		addr1bit => addr_WR
	);


   rst_mem: reset_mem PORT MAP(
		clk => clock, 
		reset_homade => reset , 
		reset_mem => resetmem
   );
--=========================================================	
---- slaves
--=========================================================	

Xslaves : for I in 0 to NX_SLAVE-1 generate	
   begin
	Yslaves : for J in 0 to NY_SLAVE-1 generate
	One_salve : HSlave PORT MAP(
		clock => clock,
		xnum => conv_std_logic_vector( i, 5),
		ynum => conv_std_logic_vector( j, 5),
		reset => reset,
		put => d_bus_link (i,j),
		put_en =>ld_reg_link(i,j),
		get => q_bus_link(i,j),
		starthcu =>  spmdt,
		startadr => spmdc,
		ortree => ort_link(i,j),
		
		xbit_broadcast => bbx(i),
		ybit_broadcast => bby(j),
		data_bit => data_S,
		w_bit =>wphase_S,
		we_broadcast => ld_actif
		--============

	);
	end generate YSlaves;
end generate Xslaves;	

Xortree:	for i in 0 to NX_SLAVE -1 generate
	Yortree: for j in 0 to NY_SLAVE -1 generate
		firstj: 	if  j=0  generate 
				ortbus2D(i,j) <= ort_link(i,j);
		end generate firstj;
		otherj:	if j> 0 generate 
				ortbus2D(i,j) <= ortbus2D(i,j-1) or ort_link(i,j);
		end generate otherj;
	end generate Yortree;
	firsti: 	if i=0  generate 
			ortbus(0) <= ortbus2D(0,NY_SLAVE -1);
	end generate firsti;
	otheri:	if i> 0 generate 
			ortbus(i) <= ortbus(i-1) or ortbus2D(i,NY_SLAVE -1);
	end generate otheri;
	
end generate Xortree;
	
withslaves: if NBSLAVE > 0 generate
   ort <= ortbus (NX_SLAVE-1);
end generate withslaves;

--
-- NEWS
--

Grid_2Dx : for I in 0 to NX_SLAVE-1 generate
	Grid_2Dy : for J in 0 to NY_SLAVE-1 generate
	
		acces_master : if I = 0 and j= 0 generate 
			sreg_master :netring_master PORT MAP(
			O => q_bus_link(0,0), 
			I_X => q_bus_link(NX_SLAVE - 1,0), 
					I_Xmoins => q_bus_link( 1,0), 
			I_put => d_bus_link(0,0), 
			I_master => dbus0,
			I_y => q_bus_link(0,NY_SLAVE - 1), 
					I_ymoins => q_bus_link(0,(j+1) MOD NY_slave), 
			X_Y =>shift_xy,
			P_M => shift_pm,
			E_put => ld_reg_link(0,0),
			E_shift => shift_and_tore,
			E_master => write_net_en,
			clk => clock 
		);
		end generate acces_master;

		node_net : if i/= 0 or j/=0 generate
			sreg :  netring PORT MAP(
			O => q_bus_link(i,j), 
			I_X => q_bus_link((i - 1) mod NX_slave ,j), 
					I_Xmoins => q_bus_link((i +  1 ) mod NX_slave ,j), 
					
			I_put => d_bus_link(i,j), 
			I_y => q_bus_link(i,(j-1)MOD NY_slave), 
					I_ymoins => q_bus_link(i,(j+1) MOD NY_slave), 
					
			X_Y =>shift_XY,
					P_M =>shift_pm,
					
			E_put => ld_reg_link(i,j),
			E_shift => shift_cmd_tore_shift_xy ,
			clk => clock 
		);
		end generate node_net;
	end generate Grid_2Dy;
end generate Grid_2Dx;




--==============================================================================================	
Stack_Master: Hstack PORT MAP(
		Tout => Tbusld,
		Nout => Nbusld,
		N2out => N2busld,
		Tin => Tbusst,
		Nin => NbusST,
		N2in => N2busST,		
		clk => clock, 
		reset => reset_or_clearstack, 
		oversized => oversized,
		Litload => Litld  , 
		offset => ofs,
		Lit => Litteral, 
		ipdone => IPd, 
		shortIP => Sip, 
		X => Xb, 
		Y => Yb
   );	

------------------------------------------------------------	
	----
HCU_Master: HCU PORT MAP(
		StartHomade => '0',
		Startadres => x"00000000",
		clr => reset,
		clk => clock,
		offset =>ofs ,
		w48e=> w48b,
		ortree=> ortree,
		orwait => ort,
		write_adr => wr_ah,
		write_data => wr_dh,
		it8 => it8,
		kernel=> kernel,
		IPdone => Ipd,
		prog_adr => Adrbus,
		Prog_instr => Instbus,
		Tlit => Litteral,
--           IPtrig : out  STD_LOGIC;
           Ipcode => icode,
           LITload =>Litld,
			  shortIP =>Sip,
			  X => Xb,
			  Y => Yb,
			  spmdcode =>spmdc,
			  spmdtrig => spmdt
			  );	
	--
BufO_reg: reg0 
		generic map (N=>32)
		PORT MAP(
		load => BufOld,
		d => Tbusld(31 downto 0),
		clk => clock,
		clr => reset,
		q => Out32
	);
	
BufLed_reg: reg0 
	generic map (N=>16)
	PORT MAP(
		load => BusLdld,
		d => Tbusld(15 downto 0),
		clk => clock,
		clr => reset,
		q => Out16
	);

BufSwitch_reg: reg0c 
		generic map (N=>16)
		PORT MAP(
		d => In16,
		clk => clock,
		clr => reset,
		q => Bswbus
	);
	
	
--
--  IP insatanciation here
--
Mled : if genM_led = '1' generate
Inst_IP_Led: IP_Led
		generic map (Mycode =>IPLed)
		PORT MAP(
		IPcode => Icode,
		BusLedld =>BusLdld
	);
end generate Mled;

Mswitch : if genM_switch = '1' generate
Inst_IP_Switch: IP_Switch
		generic map (Mycode =>IPSwitch)
		PORT MAP(
		Tout => Tbusst,
		IPcode => Icode,
		Bsw =>Bswbus
	);
end generate Mswitch;
	
Mbufout : if genM_bufout = '1' generate
Inst_IPBufO: IP_BufO
		generic map (Mycode =>IPBufOut)
		PORT MAP(
		IPcode => Icode,
		BOld =>BufOld
	);
end generate Mbufout;
	
Mwaitbtn : if genM_waitbtn = '1' generate
Inst_IPwaitBt: IP_waitBt 
		generic map (Mycode =>IPWaitBtn)
		PORT MAP(
		Tin => Tbusld( 4 downto 0),
		clk => clock,
		reset => reset,
		IPcode => Icode,
		Btn => InBtn,
		Tout => Tbusst,
		IPdone => IPdbt
	);
end generate Mwaitbtn;
	
--Mfibo : if genM_fibo = '1' generate
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
--end generate Mfibo;

Mdelay : if genM_delay = '1' generate
	Inst_IP_delay: IP_delay 
		generic map (Mycode =>IPdelay)
		PORT MAP(
		Tin => Tbusld,
		IPcode => Icode,
		clk => clock,
		IPdone => IPdwt
	);
end generate Mdelay;

MRAM : if genM_RAM = '1' generate
	Inst_IPRAM : IP_RAM
		generic map (Mycode => IPRAM,
						 Pmem_length => 10)
		PORT MAP(
		Tin => Tbusld( 31 downto 0),
		Nin => Nbusld( 31 downto 0),
		clk => clock,
		IPcode => Icode,
		Tout => Tbusst
	);	
end generate MRAM;

Mregister : if genM_register = '1' generate
Inst_IP_regfile: IP_regfile 
		generic map (Mycode =>IPregister)
		PORT MAP(
		clk => clock,
		Tin => Tbusld,
		Tout => Tbusst,
		IPcode => Icode
	);
end generate Mregister;
		
Mfunit : if genM_funit = '1' generate	
Inst_IPFunit: IP_Funit
		generic map (Mycode =>IPFunit)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		IPcode => Icode,
		Tout => Tbusst
	);
end generate Mfunit;
	
Mstack : if genM_stack= '1' generate
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
end generate Mstack;
	
Midentity : if genM_identity = '1' generate
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
end generate Midentity;
	
Mdatastack : if genM_datastack = '1' generate
Inst_IPdataStack: IP_dataStack
		generic map (Mycode =>IPDataStack)
		PORT MAP(
		Tin => Tbusld,
		clk=> clock,
		clr=>reset, 
		IPcode => Icode,
		Tout => Tbusst
	);
end generate Mdatastack;

	
MTic : if genM_Tic = '1' generate
	Inst_IP_Tic: IP_Tic
		generic map (Mycode =>IPTic)
		PORT MAP(
		Tout => Tbusst,
		ipcode => Icode,
		clk =>clock ,
		reset => reset 
	);
end generate MTic;

--
-- only if nslave >0
--

slv: IF NBSLAVE > 0 generate

	Mcom : if genM_com = '1' generate
	Inst_IP_Com: IP_Com
			generic map (Mycode =>IPCom)
			PORT MAP(
			ipcode => Icode,
			shift_xy => shift_xy,
			shift_pm => shift_pm,
			tore => tore,
			shift_en => shift_cmd_1
		);
	end generate Mcom;
		
--	Mcom32 : if genM_com32 = '1' generate
--	Inst_IP_Com32: IP_Com32
--				generic map (Mycode =>IPCom32)
--				PORT MAP(
--				ipcode => Icode,
--				clk => clock,
--				reset => reset,
--				IPdone=> IPdC32,
--				shift_en => shift_cmd_32
--			);
--	end generate Mcom32;


--	shift_cmd <= shift_cmd_1 or shift_cmd_32;
	shift_cmd <= shift_cmd_1 ;
	MME : if genM_ME = '1' generate
	Inst_IPMEcom: IP_MEcom
				generic map (Mycode =>IPME)
				PORT MAP(		Tin => Tbusld,
				IPcode => Icode,
				Dbus=> dbus0,
				Qbus=> Q_bus_link(0,0),
				write_net => write_net_en,
				Tout => Tbusst
			);
	end generate MME;

	Mactif : if genM_actif = '1'  generate
	Inst_IPactif: IP_actif
			generic map (Mycode =>IPactif)
			PORT MAP(
			IPcode => Icode,
			Tin => Tbusld,
			Nin => Nbusld,
			bit_broadcast_X => bbx,
			bit_broadcast_Y => bby,
			load_actif =>ld_actif
		);
	end generate Mactif;


end generate slv;

--Mrdm : if genM_rdm = '1' generate
--Inst_IP_Rdm: IP_Rdm 
--		generic map (Mycode =>IPRdm)
--		PORT MAP(
--		clk => clock,
--		reset => reset,
--		IPcode => Icode,
--		Tout => Tbusst
--	);
--end generate Mrdm;
	
--Mmuladd : if genM_muladd = '1' generate
--Inst_IP_muladd: IP_muladd 
--		generic map (Mycode =>IPmuladd)
--		PORT MAP(
--		Tin => Tbusld,
--		Nin => Nbusld,
--		N2in => N2busld,
--		IPcode => Icode,
--		Tout => Tbusst
--	);
--end generate Mmuladd;

Mmul16 : if genM_mul16 = '1' generate
Inst_IP_mul16: IP_mul16
		generic map (Mycode =>IPmul16)
		PORT MAP(
		Tin => Tbusld,
		Nin => Nbusld,
		IPcode => Icode,
		Tout => Tbusst
	);
end generate Mmul16;

--
-- all IPDONE must be connected here	
--
		IPd <= IPdwt or IPdbt or IPdft or IPdC32;
end Behavioral;

