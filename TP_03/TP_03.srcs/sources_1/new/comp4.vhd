----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2018 05:08:09 PM
-- Design Name: 
-- Module Name: comp4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp4 is
   Port (spfa : in std_logic_vector(3 downto 0);
    spfo : in std_logic_vector(3 downto 0);
    cout : out std_logic
   );
end comp4;

architecture Behavioral of comp4 is

begin

--cout <= '1' when spfa = spfo else
--        '0';

    process(spfa, spfo)
        begin
        if spfa = spfo then 
            cout <= '1'; 
        else
            cout <= '0';
        end if; 
    end process;

end Behavioral;
