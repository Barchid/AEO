--                                                   
-- Description :  IP register file cf >1 >2 etc
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP_regfile is
		GENERIC (Mycode : std_logic_vector(6 downto 0) := IPregister);

    Port ( clk : in  STD_LOGIC;
           Tin: in  STD_LOGIC_VECTOR (31 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_VECTOR (10 downto 0) );
end IP_regfile;

architecture Behavioral of IP_regfile is
signal actif, store_enable : std_logic;
signal Rldbus : std_logic_vector (31 downto 0);

   COMPONENT regfile
   PORT( Rstore	:	IN	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          clk	:	IN	STD_LOGIC; 
          Rload	:	OUT	STD_LOGIC_VECTOR (31 DOWNTO 0); 
          Nreg	:	IN	STD_LOGIC_VECTOR (2 DOWNTO 0); 
          store	:	IN	STD_LOGIC);
   END COMPONENT;


begin
   my_registers: regfile PORT MAP(
		Rstore => Tin, 
		clk => clk, 
		Rload => Rldbus, 
		Nreg => IPcode(2 downto 0), 
		store => store_enable
   );
actif <= '1' when IPcode(10 downto 4) = Mycode  else '0';
store_enable <=  actif   and IPcode(3) ;
Tout <= Rldbus when actif='1' and  IPcode(3)= '0' else (others=>'Z');

end Behavioral;

