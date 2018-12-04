--                                                   
-- Description :  IP master to trig communications 
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

entity IP_Com is
		GENERIC (Mycode : std_logic_vector(7 downto 0) );

    Port ( IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
				shift_xy, shift_pm: out std_logic;
				Tore: out std_logic;
           Shift_en : out  STD_LOGIC);
end IP_Com;

architecture Behavioral of IP_Com is

begin
shift_en <= '1'  when ipcode(10 downto 3)= Mycode else '0';
shift_xy <= ipcode(0);
shift_pm <= ipcode (2); 
tore<= ipcode(1);
end Behavioral;

