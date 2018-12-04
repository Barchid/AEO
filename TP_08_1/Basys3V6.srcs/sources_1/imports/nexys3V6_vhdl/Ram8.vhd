--                                                   
-- Description :  mamory bank 1- word 32 bits 
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
use IEEE.Numeric_Std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ram8 is
    Port ( clk : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (3 downto 0);
           datain : in  STD_LOGIC_VECTOR (31 downto 0);
           dataout : out  STD_LOGIC_VECTOR (31 downto 0);
           we : in  STD_LOGIC);
	attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end Ram8;

architecture rtl of Ram8 is

type ram_type is array (0 to 15) of std_logic_vector(31 downto 0);
signal ram :ram_type;
begin

dataout<= ram ( to_integer (unsigned(addr))) ;
process (clk) is
begin
	if rising_edge ( clk) then
		if we='1' then
			ram ( to_integer (unsigned(addr))) <= datain;
				
		end if;
	end if;
end process;

end architecture rtl;
	

