--                                                   
-- Description :  IP On chip RAM
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

entity IP_ram is
	GENERIC (Mycode : std_logic_vector(9 downto 0) := "0000001011";
				Pmem_length : integer := 10 -- 2048
	);
   Port (Tin : in  STD_LOGIC_VECTOR (31 downto 0);
			Nin : in STD_LOGIC_VECTOR (31 downto 0);
			clk : in  STD_LOGIC;
         IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
         Tout : out  STD_LOGIC_VECTOR (31 downto 0)
			);
end IP_ram;

architecture Behavioral of IP_ram is

	signal outbus : std_logic_vector(31 downto 0) := (others=>'Z');
	signal w : std_logic := '0';
	signal address : std_logic_vector(Pmem_length-1 downto 0);
	signal value : std_logic_vector(31 downto 0);

	component my_ram
		port (
		a: in std_logic_vector(Pmem_length-1 downto 0);
		d: in std_logic_vector(31 downto 0);
		clk: in std_logic;
		we: in std_logic;
		spo: out std_logic_vector(31 downto 0));
	end component;

begin
	RAM : my_ram
	port map (
		a => address(Pmem_length-1 downto 0),
		d => value,
		clk => clk,
		we => w,
		spo => outbus);

	address <= Tin(Pmem_length-1 downto 0);
	value <= Nin;

	Tout <= outbus when ipcode(10 downto 1) = Mycode AND ipcode(0) = '0' else (others => 'Z');
	w <= '1' when ipcode(10 downto 1) = Mycode AND ipcode(0) = '1' else '0';

end Behavioral;

