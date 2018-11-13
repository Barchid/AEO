--                                                   
-- Description :  testbench for program simulation with ISM
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
use std.textio.all;
use IEEE.std_Logic_1164.ALL;
use IEEE.std_Logic_UNSIGNED.ALL;
use IEEE.std_Logic_ARITH.ALL;

ENTITY masterbench IS

END masterbench;

ARCHITECTURE behavior OF masterbench IS 

-- Component Declaration
COMPONENT HMaster is
	Port 	(	clock: in std_logic;
			reset : in std_logic;
			Out32 :out std_logic_vector(15 downto 0);
			Out16:out std_logic_vector(15 downto 0);
			In16:in std_logic_vector(15 downto 0);
			InBtn : in std_logic_vector (4 downto 0);
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

END COMPONENT;

SIGNAL mclk :  std_logic := '0';
signal master : std_logic :='1';
			 
signal rx_out:  std_logic;

--
--  put your program here!!!!!!
--
type rom_array is array (natural range <>) of std_logic_vector ( 63 downto 0 ) ;

constant  rom : rom_array := ( 
 --  master code 
 x"0C00_0000_000C_FFFF", -- 0000
 x"201F_A402_8804_8003", -- 0004
 x"A002_03FB_1400_FFFF", -- 0008
 x"1000_0000_0004_1C00", -- 000C
 x"FFFF_FFFF_FFFF_FFFF", -- 0010
 --  slave code 
 x"1c00_ffff_ffff_ffff", -- 0x0000
 x"ffff_ffff_ffff_ffff"  -- 0x0004
);

--
--  your intit  I/O
--
signal btn   : STD_LOGIC_VECTOR (4 downto 0):="00000";
signal sw     : STD_LOGIC_VECTOR (15 downto 0):="0000000000001111";

--
-- loading signal NOT change!!!
--
signal count :integer := 0;
signal nb_master : integer :=0; 
signal nb_slave : integer :=0; 
signal nbit : integer :=0;
signal rstfsm : std_logic:='1';
signal data_buff : std_logic_vector (63 downto 0);
signal  finish : std_logic :='0';          
signal en, ens: std_logic :='0';
signal last: std_logic :='0';
signal rst : std_logic:='0';

BEGIN




  -- Component Instantiation
HoMade: HMaster PORT MAP(
					clock => mclk,
					reset =>rst,
					Out32 => open,
					Out16=> open,
					In16=>sw ,
					InBtn =>btn,
					it8=> "000",
					kernel=> open,
  --   clock Wrapper ============
			--   Master ============           
              enb      =>en ,
				  data_WR =>rx_out,
			--   Slaves ============
              data_S      =>rx_out,
              wphase_S     =>ens
      );
--
-- process frequency  100 Mhz
--
clkin_process :process
   begin
		mclk <= '1';
		wait for 5 ns;
		mclk <= '0';
		wait for 5 ns;
   end process;

process 
begin
	rstfsm<='1';
	wait for 30 ns;
	rstfsm<='0';
	wait for 1 ms;
--	finish <= '0' ;  -- reload the same programme after 1 ms 
-- comment the following wait in this case
	wait;
end process;

--
--  change your inputs if needed
--

btn <= "00001" after 4 us, "00000" after 5 us;  -- simulate btn0 push after 4us  during 1 us.  This program loading simualution takes around 3,9 us!!!

--
-- process to load the program on the master ans slaves
---	
process (mclk)
begin
if rstfsm ='0' then 

	if mclk' event and mclk='1' then

		if finish ='0' then 
			if nbit = 0 then 
				data_buff <= rom (conv_integer(count));
				if rom (conv_integer(count))(63 downto 48 ) /= x"FFFF" then 
					rx_out <= rom (conv_integer(count))(0);
					if master='1' then 
						en<='1' ;
						ens<='0';
					else 
						ens<='1';
						en<='0';
					end if;
					nbit <= 1;	
				else
					if master ='1' then
						master <='0';
						en<='0';
						count<=count+1;
					else
						finish <= '1' ;
						ens<='0';
						en<='0';
						rst <= '0';

					end if;
					
				end if;

			else 
				rx_out <= data_buff(nbit);	
				
				nbit <= nbit+1;
				if nbit = 63 then 
					count<=count +1;
					nbit<= 0;
				end if;

			end if;
			rst<='1';
		else
			rst <= '0'; 
		end if ;
	end if;


end if;
end process;
end ;

