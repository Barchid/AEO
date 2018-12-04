library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IP_Push1F is
 GENERIC (Mycode : std_logic_vector(10 downto 0));
  Port ( 
     IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
     Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_Push1F;

architecture Behavioral of IP_Push1F is

begin
    Tout <= x"0000001F" when IPcode(10 downto 0) = Mycode else (others =>'Z');
end Behavioral;
