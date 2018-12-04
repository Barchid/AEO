library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IP_PushInit is
 GENERIC (Mycode : std_logic_vector(10 downto 0));
  Port ( 
     IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
     Tout : out  STD_LOGIC_VECTOR (31 downto 0);
     Nout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_PushInit;

architecture Behavioral of IP_PushInit is

begin
    Tout <= x"00010000" when IPcode(10 downto 0) = Mycode else (others =>'Z');
    Nout <= x"00000000" when IPcode(10 downto 0) = Mycode else (others =>'Z');
end Behavioral;
