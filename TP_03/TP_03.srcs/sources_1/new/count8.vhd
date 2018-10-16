----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2018 06:00:06 PM
-- Design Name: 
-- Module Name: count8 - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity count8 is
    Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC_VECTOR (3 downto 0));
end count8;

architecture Behavioral of count8 is

begin

    PROCESS(sw)
    VARIABLE count : INTEGER := 0;
    BEGIN
    
        cout <= "0000";
    
        for I in 0 to 7 loop 
            IF sw(I) = '1' THEN 
                count := count + 1;
            ELSE
                count := count;
            END IF;
        end loop; 
        
        cout <= conv_std_logic_vector(count, 4);
    END PROCESS;

end Behavioral;
