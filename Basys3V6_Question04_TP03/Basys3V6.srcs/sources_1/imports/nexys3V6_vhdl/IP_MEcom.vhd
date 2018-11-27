--                                                   
-- Description :  IP master to load and store communication network of slave [0,0}
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP_MEcom is
		GENERIC (Mycode : std_logic_vector(9 downto 0) );
    Port ( IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
           Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           Write_net : out  STD_LOGIC;
           Dbus : out  STD_LOGIC_VECTOR (31 downto 0);
           Qbus : in  STD_LOGIC_VECTOR (31 downto 0));
end IP_MEcom;

architecture Behavioral of IP_MEcom is

begin
tout <= Qbus when Mycode &"0" = IPcode else (others=>'Z');
Dbus <= Tin;
Write_net <= '1' when Mycode &"1" = IPcode else '0';
end Behavioral;

