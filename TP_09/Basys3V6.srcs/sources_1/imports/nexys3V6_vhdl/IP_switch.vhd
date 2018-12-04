--                                                   
-- Description :  IP master for switch read
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



entity IP_switch is
		GENERIC (Mycode : std_logic_vector(10 downto 0) );
		Port ( 
				Bsw : in  STD_LOGIC_VECTOR (15 downto 0);
				IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
				Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_switch;

architecture Behavioral of IP_switch is
begin
Tout <= x"0000" & Bsw when IPcode(10 downto 0) = Mycode else (others =>'Z');

end Behavioral;

