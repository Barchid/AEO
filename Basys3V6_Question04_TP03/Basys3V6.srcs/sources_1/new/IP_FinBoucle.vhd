library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity IP_FinBoucle is
 GENERIC (Mycode : std_logic_vector(10 downto 0) := "000000" );
    Port ( 
        Tin : in  STD_LOGIC_VECTOR (31 downto 0);
        IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
        Tout : out  STD_LOGIC_VECTOR (31 downto 0);
        Nout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_FinBoucle;

architecture Behavioral of IP_FinBoucle is
signal s : STD_LOGIC_VECTOR (31 downto 0);
begin
    s <= Tin - x"00000001";
   
    Tout <= x"00000001" when IPcode(10 downto 0) = Mycode and s = x"00000000" else
            x"00000000" when IPcode(10 downto 0) = Mycode and s /= x"00000000" else (others =>'Z');
            
    Nout <= s when IPcode(10 downto 0) = Mycode else (others =>'Z') ; 

end Behavioral;
