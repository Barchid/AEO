----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2018 03:56:47 PM
-- Design Name: 
-- Module Name: exo1_2 - Behavioral
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

entity exo1_2 is
    Port ( 
        sw : in STD_LOGIC_VECTOR (3 downto 0);
        sevenseg : out STD_LOGIC_VECTOR (6 downto 0)
    );
end exo1_2;

architecture Behavioral of exo1_2 is
    signal seg : std_logic_vector(6 downto 0);
begin  

process (sw)
    begin
       case sw is
    when "0000" => sevenseg <= "1000000";
    when "0001" => sevenseg <= "1111001";
    when "0010" => sevenseg <= "0100100";
    when "0011" => sevenseg <= "0110000";
    when "0100" => sevenseg <= "0011001";
    when "0101" => sevenseg <= "0010010";
    when "0110" => sevenseg <= "0000010";
    when "0111" => sevenseg <= "1111000";
    when "1000" => sevenseg <= "0000000";
    when "1001" => sevenseg <= "0010000";
    when "1010" => sevenseg <= "0001000";
    when "1011" => sevenseg <= "0000011";
    when "1100" => sevenseg <= "1000110";
    when "1101" => sevenseg <= "0100001";
    when "1110" => sevenseg <= "0000110";
    when others => sevenseg <= "0001110";
       end case; 
    end process;

end Behavioral;
