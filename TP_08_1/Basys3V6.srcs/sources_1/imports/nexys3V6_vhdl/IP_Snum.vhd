--                                                   
-- Description :  IP slave num of slave
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

entity IP_Snum is
		GENERIC (Mycode : std_logic_vector(9 downto 0) );

    Port ( IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           xnum : in  STD_LOGIC_VECTOR (4 downto 0);
           ynum : in  STD_LOGIC_VECTOR (4 downto 0));
end IP_Snum;

architecture Behavioral of IP_Snum is

begin
Tout <= 	"000000000000000000000000000" & xnum  when ipcode(10 downto 0)= Mycode & '0' else
			"000000000000000000000000000" & ynum  when ipcode(10 downto 0)= Mycode & '1' else
			(others =>'Z');


end Behavioral;

