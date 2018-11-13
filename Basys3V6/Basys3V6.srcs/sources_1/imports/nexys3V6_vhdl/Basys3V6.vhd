--                                                   
-- Description :  Homade toplevel for nexys3 borad
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

entity Basys3V6 is
    Port ( btn   : in  STD_LOGIC_VECTOR (4 downto 0);
			  an      : out  STD_LOGIC_VECTOR (3 downto 0);
           a_to_g   : out  STD_LOGIC_VECTOR (6 downto 0);
			  sw     : in STD_LOGIC_VECTOR (15 downto 0);
			  led    : out STD_LOGIC_VECTOR (15 downto 0);

           mclk : in  STD_LOGIC;

           rx_in   :in  std_logic
		  );
	attribute clock_signal : string;
	attribute clock_signal of mclk : signal is "yes";

end Basys3V6;

architecture Behavioral of Basys3V6 is

component HMaster
Port 	(			clock: in std_logic;
					reset : in std_logic;
					Out32:out std_logic_vector(31 downto 0);
					Out16:out std_logic_vector(15 downto 0);
					In16:in std_logic_vector(15 downto 0);
					InBtn : in std_logic_vector (4 downto 0);
					ortree : out std_logic;
					IT8 : in std_logic_vector (2 downto 0);
					kernel : out std_logic;
			--   Master ============
              enb      : in STD_LOGIC;
				  data_WR : in STD_LOGIC ;
			--   Slaves ============
              data_S             : in     STD_LOGIC;
              wphase_S           : in     STD_LOGIC			  
			);
end component;

component timer
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic
 );
end component;

COMPONENT afficheur
   PORT( din	:	IN	STD_LOGIC_VECTOR (15 DOWNTO 0); 
			 state7seg : in STD_LOGIC_VECTOR (1 downto 0) ;
          sevenseg	:	OUT	STD_LOGIC_VECTOR (6 DOWNTO 0); 
          clk	:	IN	STD_LOGIC; 
          anodes	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          E190	:	IN	STD_LOGIC);
   END COMPONENT;

COMPONENT Enable190 -- generate Enable signal actif for one period any 1/190 seconde for 100Mhz input clock
   PORT( Enable190	:	OUT	STD_LOGIC; 
          clk	:	IN	STD_LOGIC);
   END COMPONENT;

--=================================================================
COMPONENT Wrapper_RAM 
    Port ( 

		  start        :out std_logic;
        rx_in        :in  std_logic;
       rxclk         : in     STD_LOGIC;  
		 Hclk      : in     STD_LOGIC;  
--Master
       wphase_M           : out     STD_LOGIC;
       data_M             : out     STD_LOGIC;
--Slave
       data_S             : out     STD_LOGIC;
       wphase_S           : out     STD_LOGIC		 
			  );
end COMPONENT;

 
component ckl_gen
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic
 );
end component;
--========================================		 
COMPONENT debounce4
	PORT(
		cclk : IN std_logic;
		clr : IN std_logic;
		E : IN std_logic;
		inp : IN std_logic_vector(4 downto 0);          
		outp : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
component sample is
    Port ( data : in std_logic_vector(31 downto 0);
           RS : out  STD_LOGIC;
           RW : out  STD_LOGIC;
           E : out  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (3 downto 0);
			  clk50 : in std_logic  
			  );
	END COMPONENT;


	COMPONENT arbitre
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		it1 : IN std_logic;
		it2 : IN std_logic;
		it3 : IN std_logic;
		it4 : IN std_logic;
		it5 : IN std_logic;
		it6 : IN std_logic;
		it7 : IN std_logic;
		kernel : IN std_logic;          
		ack1 : OUT std_logic;
		ack2 : OUT std_logic;
		ack3 : OUT std_logic;
		ack4 : OUT std_logic;
		ack5 : OUT std_logic;
		ack6 : OUT std_logic;
		ack7 : OUT std_logic;
		it_homade : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
--	COMPONENT PS2_Ctrl
--	PORT(
--		Clk : IN std_logic;
--		Reset : IN std_logic;
--		PS2_Clk : IN std_logic;
--		PS2_Data : IN std_logic;
--		ack : IN std_logic;          
--		Scan_Err : OUT std_logic;
--		Scan_DAV : OUT std_logic;
--		Scan_Code : OUT std_logic_vector(7 downto 0)
--		);
--	END COMPONENT;
	
	COMPONENT uart_rx
	PORT(
		rx_in : IN std_logic;
		rxclk : IN std_logic;
		hclk : IN std_logic;          
		rx_reg : OUT std_logic_vector(7 downto 0);
		rx_ok : OUT std_logic
		);
	END COMPONENT;
	
signal Busdisplay : std_logic_vector (31 downto 0) := x"00000000" ;
signal Hclk , clk190 , clk200Mhz, clk100, clk50, E190, ram_clk : std_logic ;
signal btnd : std_logic_vector (4 downto 0) ;
signal master_data, ortree : std_logic ;--
signal reset_Homade, start ,slave_W, master_W, slave_data: std_logic;--
signal state7seg : std_logic_vector (1 downto 0):= "00" ;

---
-- interruption signal
--
signal btn_ack , ps2_ack, GPS_it, it2, kernel: std_logic;
signal it8: std_logic_vector (2 downto 0) ;
signal GPS_char: std_logic_vector (7 downto 0) ;


type state_type is (idle,finish);
    signal next_state: state_type:=idle;
begin

Hclk <= clk50;

--==========================================
UART_Wrapper : Wrapper_RAM  PORT MAP(
	start     => start,
	rx_in     => rx_in,
	rxclk     => clk100, 
	Hclk      => Hclk,
	data_M    => master_data,   
	data_S    => slave_data,  
	wphase_M  => master_W,  
	wphase_S  => slave_W
);
--==========================

state7seg <=  "11" when start = '1' and ortree ='1' else 
					"00" when start='0' and ortree ='1' else
					"10" when start ='1' and ortree ='0' else
					"00" when start= '0' and ortree='1'  else "00" ;
					



my_Master : HMaster PORT MAP(
		clock => Hclk,
		reset => reset_homade,
		Out32 => Busdisplay,
		Out16 => led,
		In16 => sw,
		InBtn => Btnd ,
		ortree => ortree,
		IT8=>it8,
		kernel=>kernel,
		enb		=> master_W,
		data_WR	=> master_data,
		---==============

		 data_S  => slave_data,
		 wphase_S => slave_W
	
	);

--	======================================
--=====================================================================================

Inst_debounce4: debounce4 PORT MAP(
		cclk => clk100,
		clr => reset_homade,
		E => E190,
		inp => btn,	
		outp => btnd);

clk_gen : timer
  port map
   (-- Clock in ports
    CLK_IN1            => mclk,
    -- Clock out ports
    CLK_OUT1           => clk100,
    CLK_OUT2           => clk50);

D7seg_display : afficheur PORT MAP(
		din => Busdisplay ( 15 downto 0), 
		sevenseg => a_to_g, 
		state7seg => state7seg,
		clk => clk100, 
		anodes => an, 
		E190 => E190
   );
	
My_E190: Enable190 PORT MAP(
		Enable190 => E190, 
		clk => clk100
   );
--====
	My_arbitre: arbitre PORT MAP(
		clk => Hclk,
		reset => reset_homade,
		it1 => btnd(4),
		it2 => it2,
		it3 => '0',
		it4 => '0',
		it5 => '0',
		it6 => '0',
		it7 => '0',
		ack1 => btn_ack,
		ack2 => ps2_ack,
		ack3 => open,
		ack4 => open,
		ack5 => open,
		ack6 => open,
		ack7 => open,
		it_homade => it8,
		kernel => kernel
	);
	
--My_PS2_Ctrl: PS2_Ctrl PORT MAP(
--		Clk => Hclk,
--		Reset => reset_homade,
--		PS2_Clk => PS2_Clk,
--		PS2_Data => PS2_Data,
--		ack => ps2_ack,
--		Scan_Err => open,
--		Scan_DAV => it2,
--		Scan_Code => open
--	);

--GPS_uart_rx: uart_rx PORT MAP(
--		rx_reg => GPS_char,
--
----		rx_ok => GPS_it,
----		rx_in => rx_GPS,
--		rx_ok => led(0),
--		
--		rx_in => rx_GPS,
--		rxclk => clk100,
--		hclk => Hclk
--	);
--	
--	led(1)<= rx_GPS;
--	led(2) <= fix_GPS;
--		led(3) <= pps_GPS;
--		led(7 downto 4) <= "1111";
--====================================================================================	
	
	
reset_logic: process(Hclk)
begin

if Hclk'event and Hclk='1' then

	case next_state is
---====================
		when idle =>	
			reset_homade <='1';
			if start = '1' then 
				next_state <= finish;  
			else 
				next_state <= idle;
			end if ;	
---====================	
		when finish =>	
			reset_homade <='0';
			if start = '0' then 
				next_state <= idle;
			else 
				next_state <= finish;
			end if ;
		when others =>
			reset_homade <='1';
			next_state <= idle;
	end case;
end if ;
end process;

end Behavioral;

