library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IP_increm is
		GENERIC (Mycode : std_logic_vector(5 downto 0) := "000000" );
Port ( 
      Tin : in  STD_LOGIC_VECTOR (31 downto 0);
   Nin : in  STD_LOGIC_VECTOR (31 downto 0);
   IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
   Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_increm;

architecture Behavioral of IP_increm is

begin

    Tout <= 
end Behavioral;
