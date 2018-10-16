library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity determine_direction is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           clk: in STD_LOGIC;
           chenillard : in STD_LOGIC_VECTOR (15 downto 0);
           direction : out STD_LOGIC);
end determine_direction;

architecture Behavioral of determine_direction is

begin
    
    process(clk)
    variable droite_gauche: std_logic := '0';
    begin
        if rising_edge(clk) then
            for i in 0 to 15 loop
                if sw(i) = '1' and chenillard(i) = '1' then
                    droite_gauche := not droite_gauche;
                    direction <= droite_gauche;
                end if;
            end loop; 
        end if;
    end process;
end Behavioral;
