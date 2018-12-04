--                                                   
-- Description :  bank selection
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
use IEEE.std_Logic_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity select_out is
    Port ( count : in  STD_LOGIC_VECTOR (1 downto 0);
           selTout : out  STD_LOGIC_VECTOR (1 downto 0);
           selNout : out  STD_LOGIC_VECTOR (1 downto 0);
           selN2out : out  STD_LOGIC_VECTOR (1 downto 0);
			  seloverS : out  STD_LOGIC_VECTOR (1 downto 0));
end select_out;

architecture Behavioral of select_out is
  type rom_array is array (0 to 3 ) of std_logic_vector ( 7 downto 0 ) ;
constant  rom : rom_array := (
"00011011",   -- count 00
"01101100",  --  count 01
"10110001",  --  count 10
"11000110"  --  count 11
);
begin 

selTout <= rom(conv_integer(count))(1 downto 0);
selNout <= rom(conv_integer(count))(3 downto 2);
selN2out <= rom(conv_integer(count))(5 downto 4);
seloverS <= rom(conv_integer(count))(7 downto 6);

--seltout(0)<= not count(0);
--seltout(1)<= Not (count (0) xor count(1));
--selNout(0)<=count(0);
--selNout(1)<=not count(1);
--selN2out(0)<= not count(0);
--selN2out(1)<= count (0) xor count(1);
--selovers(0)<=count(0);
--selovers(1)<=count(1);


--begin
--selTout <= 	"00" when count = "01" else
--				"01" when count = "10" else
--				"10" when count = "11" else
--				"11";
--				
--selNout <= 	"00" when count = "10" else
--				"01" when count = "11" else
--				"10" when count = "00" else
--				"11";
--				
--selN2out <= "00" when count = "11" else
--				"01" when count = "00" else
--				"10" when count = "01" else
--				"11";
--seloverS <= "00" when count = "00" else
--				"01" when count = "01" else
--				"10" when count = "10" else
--				"11";

end Behavioral;

