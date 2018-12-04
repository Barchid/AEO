--                                                   
-- Description :  Stack ouput managment
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity next_count is
    Port ( count_in : in  STD_LOGIC_VECTOR (7 downto 0);
				lastcycle , clk, reset : in std_logic;
           count_out : out  STD_LOGIC_VECTOR (7 downto 0);
           X,Y  : in  STD_LOGIC_vector (1 downto 0));

end next_count;

architecture Behavioral of next_count is
signal val : integer range -3 to 3;
signal value : std_logic_vector(2 downto 0);
signal NY0,NY1,nX0,NX1 : std_logic;
begin



ny0<= not y(0);
ny1<= not  y(1);

nx0<= not x(0);
nx1<= not  x(1);

					  
Value(2)<= lastcycle and (
			(nx1 and x(0) and ny1 and ny0  ) or 
			( x(1) and x(0) and y(1) and ny0  ) or 
			( x(1) and ny1 )
			);
value(1)<= lastcycle and (
			(nx1 and  x(0) and ny1 and ny0  ) or 
			( x(1) and x(0) and y(1) and ny0  ) or 
			( nx1 and y(1) and y(0)  ) or 
			( nx1 and nx0 and y(1)  ) or 
			( x(1) and ny1 and y(0)  ) or 
			( x(1) and nx0 and ny1  )
			);
value(0)<= lastcycle and (
			(x(0) and ny0  ) or 
			( nx0 and y(0)  )
			);
val <= to_integer(signed(value));

process ( clk)
begin
	if clk'event and clk='1' then
		IF reset ='1' then
			count_out <= "00000000";
		else
			count_out <= count_in  +  val  ;
		end if;
	end if;
end process;

end Behavioral;

