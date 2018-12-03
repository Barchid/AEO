library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IP_Comparateur is
 GENERIC (Mycode : std_logic_vector(10 downto 0));
   Port ( 
         Tin : in  STD_LOGIC_VECTOR (31 downto 0);
      IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
      Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_Comparateur;

architecture Behavioral of IP_Comparateur is

begin

Tout <= x"00000001" when IPcode(10 downto 0) = Mycode and Tin = x"00FFE001"
    else x"00000000" when IPcode(10 downto 0) = Mycode and Tin /= x"00FFE001" 
    else (others =>'Z');

end Behavioral;
