library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btnToCode is
    Port ( btn : in STD_LOGIC_VECTOR (3 downto 0);
           code : out STD_LOGIC_VECTOR (1 downto 0);
           magic: out std_logic
    );
end btnToCode;

architecture Behavioral of btnToCode is

begin
    with btn select code <=
        "00" when "0001",
        "01" when "0010",
        "10" when "0100",
        "11" when "1000",
        "00" when others;
        
   with btn select magic <=
        '1' when "0001",
        '1' when "0010",
        '1' when "0100",
        '1' when "1000",
        '0' when others;
        
end Behavioral;
