library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_vector2 is
    Port (
        clk : in STD_LOGIC;
        sw: in STD_LOGIC_VECTOR(15 downto 0);
        led : out STD_LOGIC_VECTOR (15 downto 0)
    );
end shift_vector2;

architecture Behavioral of shift_vector2 is
signal temp : std_logic_vector(15 downto 0) := "0000000000000001";
begin


process(clk)
variable tmp : std_logic;
variable direction: std_logic := '0';
begin
    if rising_edge(clk) then
        if direction = '0' then -- Si le bouton n'est pas pressé, on va à droite
            tmp := temp(15);
            temp(15 downto 1) <= temp(14 downto 0);
            temp(0) <= tmp;
        else -- Si le bouton est pressé, on va à gauche
            tmp := temp(0);
            temp(14 downto 0) <= temp(15 downto 1);
            temp(15) <= tmp;
        end if;
    end if;    
end process;

led <= temp;
end Behavioral;
