--                                                   
-- Description :  IP master for 7seg display via a buffer 32 bits
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


entity IP_BufO is
		GENERIC (Mycode : std_logic_vector(10 downto 0) );
    Port ( 
			  IPcode : IN std_logic_vector(10 downto 0);   
           BOld : out  STD_LOGIC :='0');
end IP_BufO;

architecture Behavioral of IP_BufO is


begin
BOld <= '1' when IPcode(10 downto 0) = Mycode else '0';


end Behavioral;

