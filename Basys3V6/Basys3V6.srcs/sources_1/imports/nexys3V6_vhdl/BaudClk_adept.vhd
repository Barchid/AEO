--                                                   
-- Description :  clock UART 9600 baud
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Static Module to turn chip clock into a baud rate clock to be
--    used by uarts
entity uart_baudClock is
    Generic ( clock_rate : integer := 100000000;
               baud_rate : integer := 9600
            );

    Port (   in_clk : in std_logic;
             baud_clk : out std_logic;
			    clk : out std_logic
           );
end uart_baudClock;


architecture Behavioral of uart_baudClock is
signal q : std_logic_vector (1 downto 0):= "00";
signal in_clk_aux : std_logic;
begin



-- The following process controls the baud clock. The signal baud_clk is 
-- pulsed high for one clock cycle at a rate 16 times of the baud rate. 
-- Clock rate and baud rate are set in the top-level VHDL-file.
baudRate_process : process(in_clk)

-- Adjust the clock rate and the baud rate:
constant clock_rate : integer := 100000000;	-- 100 MHz
constant  baud_rate : integer := 9600;		-- 9600 buad	

variable count : integer range 0 to 2047 := 0;
constant clk_divide : integer := clock_rate / (baud_rate * 16 );
begin


--	Wait for a rising clock edge
	if in_clk'event and in_clk = '1' then
		count := count + 1;
		if count = clk_divide/2 then
		   clk <= '1';
		elsif count = clk_divide then
			count := 0;
			baud_clk <= '1';
			clk <= '1';
		else
		   clk <= '0';
			baud_clk <= '0';
		end if;
	end if;
end process;
--========================================================


end Behavioral;
