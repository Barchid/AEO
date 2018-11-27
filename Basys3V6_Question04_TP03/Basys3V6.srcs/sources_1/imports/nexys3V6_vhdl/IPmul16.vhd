--                                                   
-- Description :  IP mul 16 bit unsigned return 32 bits
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP_mul16 is
	GENERIC (Mycode : std_logic_vector(10 downto 0):="00000000000" );
    Port ( 
				Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Nin : in  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_vector(10 downto 0) ;
           Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_mul16;

architecture Behavioral of IP_mul16 is
component multiply
	port (
	a: in std_logic_vector(15 downto 0);
	b: in std_logic_vector(15 downto 0);
	p: out std_logic_vector(31 downto 0));
end component;
signal mult : std_logic_vector (31 downto 0) ;

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of multiply: component is true;
begin
my_mul16 : multiply
		port map (
			a => Tin(15 downto 0),
			b => Nin (15 downto 0),
			p => mult);
Tout <= mult when Mycode = IPcode else (others =>'Z');

end Behavioral;