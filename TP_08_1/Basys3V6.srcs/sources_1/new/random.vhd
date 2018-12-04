library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity random is
 generic ( width : integer:=  32 ); 
port (
   clk , reset : in std_logic;
   enable : in std_logic;
   random_num : out std_logic_vector (width-1 downto 0)   --output vector            
   );
end random;

architecture Behavioral of random is
    signal r : std_logic_vector(31 downto 0) := x"80000000";
begin

    process (clk)
    begin
        if rising_edge(clk) then
                if(reset = '1') then
                    r <= x"80000000";
                else
                    if(enable = '1') then
                        r(30 downto 0) <= r(31 downto 1);
                        r(31) <= (((r(0) xor r(2)) xor r(3)) xor r(4));
                    end if;         
                end if;
            end if;
    end process;
    
    random_num <= r;

end Behavioral;
