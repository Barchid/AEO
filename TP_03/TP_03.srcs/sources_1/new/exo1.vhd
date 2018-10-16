----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/02/2018 03:41:13 PM
-- Design Name: 
-- Module Name: exo1 - Behavioral
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

entity exo1 is
  Port (
    adr : in std_logic_vector(1 downto 0);
    a : in std_logic;
    b : in std_logic;
    c : in std_logic;
    d : in std_logic;
    s : out std_logic
  );
end exo1;

architecture Behavioral of exo1 is
begin
        
    process (adr, a, b, c, d)
    begin
       case adr is
        when "00" => s <= a;
        when "01" => s <= b;
        when "10" => s <= c;
        when others => s <= d;
       end case; 
    end process;
end Behavioral;
