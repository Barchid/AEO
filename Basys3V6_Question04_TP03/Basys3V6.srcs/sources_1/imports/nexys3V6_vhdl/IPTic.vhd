--                                                   
-- Description :  IP timer
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

entity IP_Tic is
		GENERIC (Mycode : std_logic_vector(10 downto 0) );
    Port ( Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           ipcode : in  STD_LOGIC_vector (10 downto 0);
           clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC
			  );
			  	attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end IP_Tic;


architecture Behavioral of IP_Tic is
signal qbus , busreg: std_logic_vector(31 downto 0) ;
signal rstbus : std_logic;



	COMPONENT reg1c
	generic (N : integer := 32);
	PORT(
		d : IN std_logic_vector(N-1 downto 0);
		clr ,clk: IN std_logic;          
		q : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;

begin
	Tic_count: reg1c 
		generic map (N=>32)
		PORT MAP(
		d => busreg,
		clk => clk,
		clr => rstbus,
		q => qbus
		);


--busreg <= x"00000000" when  ipcode(10 downto 0)= Mycode else qbus + 1 ;
busreg <= qbus + 1;
rstbus <= '1' when ipcode(10 downto 0)= Mycode or reset ='1'  else '0';
Tout <= qbus when ipcode(10 downto 0)= Mycode else (others =>'Z');

end Behavioral;

