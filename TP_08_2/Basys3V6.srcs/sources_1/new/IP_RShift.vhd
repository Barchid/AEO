----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2018 12:28:11 PM
-- Design Name: 
-- Module Name: IP_RShift - Behavioral
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
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP_RShift is
GENERIC (Mycode : std_logic_vector(10 downto 0));
    Port ( 
        Tin : in  STD_LOGIC_VECTOR (31 downto 0);
        IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
        Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_RShift;

architecture Behavioral of IP_RShift is
begin

Tout <= x"0000" & Tin(31 downto 16) when IPcode(10 downto 0) = Mycode else (others =>'Z');

end Behavioral;
