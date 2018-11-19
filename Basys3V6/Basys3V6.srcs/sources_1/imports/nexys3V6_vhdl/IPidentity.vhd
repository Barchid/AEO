--                                                   
-- Description :  IP identity dup dup2 dup3
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
use work.IPcodes.all;



entity IP_identity is
		GENERIC (Mycode : std_logic_vector(10 downto 0) );
    Port ( Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Nin : in  STD_LOGIC_VECTOR (31 downto 0);
           N2in : in  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_vector (10 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           Nout : out  STD_LOGIC_VECTOR (31 downto 0);
           N2out : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_identity;

architecture Behavioral of IP_identity is
begin

Tout <= Tin when (IPcode = Mycode) else (others =>'Z');
Nout <= Nin when (IPcode = Mycode) else (others =>'Z');
N2out <= N2in when (IPcode = Mycode) else (others =>'Z');

end Behavioral;

