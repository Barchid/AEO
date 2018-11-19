--                                                   
-- Description :  address generator  to store the program in master/slave memory 
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
use IEEE.STD_LOGIC_signed.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity add_gen is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           next_addr : in  STD_LOGIC;
           addr1bit : out  STD_LOGIC_VECTOR (11 downto 0));
end add_gen;

architecture Behavioral of add_gen is
signal count: STD_LOGIC_VECTOR (11 downto 0):=x"000";
begin

genaddr: process (clk, reset)

begin
	if clk = '1' and clk'event   then
		if reset ='1' then 
			count<= (others=>'0');
		else
			if next_addr = '1' then
				count <= count + '1';
			else 
				count<= count;
			end if;
		end if;

	end if;	

end process;

addr1bit<= count;	

end Behavioral;

