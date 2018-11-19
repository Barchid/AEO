--                                                   
-- Description :  IP stack operations
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



entity IP_stack is
		GENERIC (Mycode : std_logic_vector(7 downto 0) );
    Port ( Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Nin : in  STD_LOGIC_VECTOR (31 downto 0);
           N2in : in  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_vector (10 downto 0);
			  clearstack : out std_logic;
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           Nout : out  STD_LOGIC_VECTOR (31 downto 0);
           N2out : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_stack;

architecture Behavioral of IP_stack is

signal tout1, nout1, N2out1 : std_logic_vector (31 downto 0);
signal actif : std_logic ;

begin
actif <= '1' when IPcode(10 downto 3 ) = Mycode else '0' ;

Tout1 <= N2in when IPcode (2 downto 0) =  IRot else
			Tin when (IPcode (2 downto 0) =  IDup or IPcode (2 downto 0) =  ITuck or IPcode (2 downto 0) =  INip) else 
			Nin ;
Tout <= Tout1 when actif='1'  else (others =>'Z');

Nout1 <= N2in when   IPcode (2 downto 0) =  IInvRot else 
			Nin when IPcode (2 downto 0) =  ITuck  else
			Tin ;
Nout <= Nout1 when actif='1'  else (others =>'Z');

N2out1 <= Tin when IPcode (2 downto 0) = IInvRot or IPcode (2 downto 0) = ITuck or IPcode (2 downto 0) =  IDup else 
			Nin ;	
N2out <= N2out1 when actif='1'  else (others =>'Z');

clearstack <= IPcode(2) and IPcode(1) and IPcode(0) and actif ;


end Behavioral;

