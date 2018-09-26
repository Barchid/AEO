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
           led : out STD_LOGIC_VECTOR (15 downto 0);
           dp : out STD_LOGIC );
        
end my_add;

architecture Behavioral of my_add is
    signal a : std_logic_vector(15 downto 0);
    signal b : std_logic_vector(15 downto 0);
    signal sum : std_logic_vector(15 downto 0);
begin
    a(0) <= sw(0);
    a(1) <= sw(1);
    a(2) <= sw(2);
    a(3) <= sw(3);
    
    b(0) <= sw(4);
    b(1) <= sw(5);
    b(2) <= sw(6);
    b(3) <= sw(7);
    
    sum <= ('0' & a) + ('0'& b);
    
    
    
    
    led <= sum;
    
    dp <= sum(15);
    
end Behavioral;
