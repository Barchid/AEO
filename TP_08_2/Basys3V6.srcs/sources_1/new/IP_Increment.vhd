library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity IP_Increment is
    GENERIC (Mycode : std_logic_vector(10 downto 0));
    Port ( 
       Tin : in  STD_LOGIC_VECTOR (31 downto 0);
       IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
       Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_Increment;

architecture Behavioral of IP_Increment is

begin

    Tout <= Tin + x"00000001" when IPcode(10 downto 0) = Mycode else (others =>'Z');

end Behavioral;
