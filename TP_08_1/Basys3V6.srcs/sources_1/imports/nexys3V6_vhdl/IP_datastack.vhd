--                                                   
-- Description :  Data stack  cf >r r>
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
use work.IPcodes.all;

entity IP_datastack is
		GENERIC (Mycode : std_logic_vector(9 downto 0) );
    Port ( clk : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_VECTOR(10 downto 0));
			  	attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end IP_datastack;

architecture Behavioral of IP_datastack is

	COMPONENT dstack
	PORT(
		clk : IN std_logic;
		push : IN std_logic;
		pop : IN std_logic;
		data_in : IN std_logic_vector(31 downto 0);
		clr : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT reg0c
	generic (N : integer := 32);
	PORT(
		d : IN std_logic_vector(N-1 downto 0);
		clr ,clk: IN std_logic;          
		q : OUT std_logic_vector(N-1 downto 0)
		);
	END COMPONENT;	
	
signal stbus , Topbus, busreg: std_logic_vector (31 downto 0) ;
signal popld, pushld: std_logic;
signal actif: std_logic;

begin
	DatastackTop_reg: reg0c
		generic map (N=>32)
		PORT MAP(
		d => busreg,
		clk => clk,
		clr => clr,
		q => Topbus
	);
	Inst_datastack: dstack PORT MAP(
		clk => clk,
		push => pushld,
		pop => popld,
		data_in =>Tin,
		data_out => stbus(31 downto 0),
		clr => clr
	);		
actif <= '1' when IPcode(10 downto 1) = Mycode  else '0';
pushld <= '1' when actif ='1'  and IDataPush = IPcode(0 downto 0) else '0';
popld <= '1' when actif ='1' and IDataPop=IPcode(0 downto 0) else '0';
Tout <= Topbus when actif='1' and IDataPop=IPcode(0 downto 0) else (others=>'Z');


busreg <= Tin when actif='1' and IDataPush =IPcode(0 downto 0) else stbus;

end Behavioral;

