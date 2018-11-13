--                                                   
-- Description :  Debounce for buton
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
use IEEE.std_logic_1164.all;

entity debounce4 is
	  port (
		cclk, clr, E: in std_logic;
		inp: in std_logic_vector(4 downto 0);
		outp: out std_logic_vector(4 downto 0)
	  );
	attribute clock_signal : string;
	attribute clock_signal of cclk : signal is "yes";
end debounce4;

architecture debounce4 of debounce4 is
signal delay1, delay2, delay3: std_logic_vector(4 downto 0);
begin
    process(cclk, clr)
    begin
       	if clr = '1' then
    		delay1 <= "00000";
	   	    	delay2 <= "00000";
	   		delay3 <= "00000"; 
		elsif cclk'event and cclk='1' then
			if E='1' then
	   		delay1 <= inp;
	   		delay2 <= delay1;
	   		delay3 <= delay2;
			end if;
		end if;
    end process;

    outp <= delay1 and delay2 and  delay3;
end debounce4;
