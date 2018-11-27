--                                                   
-- Description   :  UART Driver : a wrapper disign for storing data-RAM providing from PC-USB-connection
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
use IEEE.std_Logic_1164.ALL;
use IEEE.std_Logic_UNSIGNED.ALL;
use IEEE.std_Logic_ARITH.ALL;


entity Wrapper_RAM is
    Port ( 
			start        :out std_logic;
        rx_in        :in  std_logic;
       rxclk     : in     STD_LOGIC;  
		 Hclk      : in     STD_LOGIC;  	 
--Master
       wphase_M           : out     STD_LOGIC;
       data_M             : out     STD_LOGIC;
--Slave
       data_S             : out     STD_LOGIC;
       wphase_S           : out     STD_LOGIC
			  );
attribute clock_signal : string;
attribute clock_signal of rxclk : signal is "yes";

end Wrapper_RAM;

architecture rom_io of Wrapper_RAM is
--
	COMPONENT uart_rx
	PORT(
		rx_in : IN std_logic;
		rxclk ,Hclk : IN std_logic;  
		rx_reg : OUT std_logic_vector(7 downto 0);
		rx_ok : OUT std_logic
		);
	END COMPONENT;

component uart_baudClock is
    Port (      in_clk : in std_logic;
             baud_clk : out std_logic
         );
end component;

  COMPONENT shitfreg8
   PORT( D	:	IN	STD_LOGIC; 
          CE	:	IN	STD_LOGIC; 
          clk	:	IN	STD_LOGIC; 
          Q	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0));
   END COMPONENT;
	
  COMPONENT pulse
     PORT( clk : IN STD_LOGIC; 
          inp : IN STD_LOGIC; 
          outp : OUT STD_LOGIC);
   END COMPONENT;
	
	COMPONENT uart_dispatch
	PORT(
		rx8 : IN std_logic_vector(7 downto 0);
		rxe : IN std_logic;
		clk : IN std_logic;          
		data_m : OUT std_logic;
		data_s : OUT std_logic;
		e_m : OUT std_logic;
		e_s : OUT std_logic;
		start : OUT std_logic
		);
	END COMPONENT;
--=====================================================================================
signal buf8 : std_logic_vector(7 downto 0);
signal rx_ok , buf8E: std_logic;
signal  baud_clk : std_logic;
--==============================
--==============================
begin
	Inst_uart_rx: uart_rx PORT MAP(
		rx_reg => buf8,
		rx_ok => rx_ok,
		rx_in => rx_in,
		Hclk=> hclk,
		rxclk => baud_clk
	);

							
pulse_shift: pulse PORT MAP(
  clk => Hclk, 
  inp => rx_ok, 
  outp => buf8E
   );


uart_baudClock_inst : uart_baudClock

  port map (      in_clk => rxclk,
               baud_clk => baud_clk
           );
			  
			  

	Inst_uart_dispatch: uart_dispatch PORT MAP(
		rx8 => buf8,
		rxe => buf8E,
		data_m => data_M,
		data_s => data_S,
		e_m => wphase_M,
		e_s => wphase_S,
		start => start,
		clk => Hclk
	);







end rom_io;
