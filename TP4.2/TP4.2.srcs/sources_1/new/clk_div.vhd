library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_div is
    Port ( clk : in STD_LOGIC;
           clk_4hz : out STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is
signal clk_temp : std_logic := '0';
begin

process (clk)
variable counter : unsigned(23 downto 0):= (others => '0');
begin
    if rising_edge(clk) then
        counter := counter + 1;
        if counter = 12500000 then
            counter := (others => '0');
            clk_temp <= not clk_temp;
        end if;
    end if;
end process;

clk_4hz <= clk_temp;

end Behavioral;
