--                                                   
-- Description :  display with special char for start and stop
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

entity x7seg is
    Port ( sw : in  STD_LOGIC_VECTOR (3 downto 0);
			  state : in STD_LOGIC_VECTOR (1 downto 0) ;
           sevenseg : out  STD_LOGIC_VECTOR (6 downto 0));
end x7seg;

architecture Behavioral of x7seg is
signal s7: STD_LOGIC_VECTOR (6 downto 0);
begin

with sw select 
	s7 <=  
				"1000000" when x"0" ,
				"1111001" when x"1" ,
				"0100100" when x"2" , 
				"0110000" when x"3" , 
				"0011001" when x"4" , 
				"0010010" when x"5" , 
				"0000010" when x"6" , 
				"1111000" when x"7" , 
				"0000000" when x"8" , 
				"0010000" when x"9" , 
				"0001000" when x"A" , 
				"0000011" when x"B" , 
				"1000110" when x"C" , 
				"0100001" when x"D" , 
				"0000110" when x"E" , 
				"0001110" when others; 
with state select 
	sevenseg <=
				"0101100" when "00",
				"1110001" when "01",
				"0111111" when "10",
				s7 when others;
				
end Behavioral;

