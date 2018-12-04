library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity fibogen is
    Port ( clk      : in  STD_LOGIC;
           init     : in  STD_LOGIC;
           fiboout  : out STD_LOGIC_VECTOR (31 downto 0));
 
 attribute clock_signal : string;
 attribute clock_signal of clk : signal is "yes";
end fibogen;

architecture Behavioral of fibogen is
signal fib1 : std_logic_vector(31 downto 0);
signal fib2 : std_logic_vector(31 downto 0);
signal tmp : std_logic_vector(31 downto 0);
begin

process(clk)
    variable tmp : std_logic_vector(31 downto 0) := x"00000000";
begin
    if rising_edge(clk) then
        if (init = '1') then
            fib1 <= x"00000001";
            fib2 <= x"00000001";
            
        else
            tmp := fib1;
            fib1 <= fib2;
            fib2 <= tmp + fib2;
        end if;
    end if;
end process;

fiboout <= fib2;
end Behavioral;
