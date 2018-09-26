----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/18/2018 06:05:15 PM
-- Design Name: 
-- Module Name: add4 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_add is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000");
        
end my_add;

architecture Behavioral of my_add is
    signal a : std_logic_vector(3 downto 0); -- 4 bit number (left operand)
    signal b : std_logic_vector(3 downto 0); -- 4 bit number (right operand)
    signal sum : std_logic_vector(4 downto 0); -- 4 bit number (right operand)
begin
    a(3 downto 0) <= sw(3 downto 0);
    b(3 downto 0) <= sw(15 downto 12);
    
    sum <= ('0' & a) + ('0' & b);
    led(4 downto 0) <= sum;
    
end Behavioral;
