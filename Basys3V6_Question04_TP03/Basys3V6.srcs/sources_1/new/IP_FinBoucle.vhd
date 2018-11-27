----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2018 06:48:02 PM
-- Design Name: 
-- Module Name: IP_FinBoucle - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IP_FinBoucle is
 GENERIC (Mycode : std_logic_vector(5 downto 0) := "000000" );
   Port ( 
      Tin : in  STD_LOGIC_VECTOR (31 downto 0);
      Nin : in  STD_LOGIC_VECTOR (31 downto 0);
      IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
      Tout : out  STD_LOGIC_VECTOR (31 downto 0);
      Nout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_FinBoucle;

architecture Behavioral of IP_FinBoucle is
signal s : STD_LOGIC_VECTOR (31 downto 0);
begin

    Tout <= Tin - x"00000001";
    Nout <= x"00000001" when (Tin - x"00000001") = x"00000000" else x"00000001"; 

end Behavioral;
