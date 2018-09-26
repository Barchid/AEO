----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/25/2018 05:46:40 PM
-- Design Name: 
-- Module Name: calc4 - Behavioral
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

entity calc4 is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           btnL : in STD_LOGIC;
           btnR: in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0) := "1110"
          );
           
end calc4;

architecture Behavioral of calc4 is
 component my_add
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
            led : out STD_LOGIC_VECTOR (15 downto 0));
  end component;
  
   component x7seg
      Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
             sevenseg : out STD_LOGIC_VECTOR (6 downto 0));
   end component;
    signal b : std_logic_vector(1 downto 0);
    signal add : std_logic_vector(15 downto 0); -- 5 bit result
    signal sum : std_logic_vector(15 downto 0); -- 5 bit result
  
begin

 inst_add: my_add port map (sw => sw, led => add);
 
 b <= (btnL & btnR);
 
 with b select
 sum <= add when "00",
 ("000000000000" & (sw(15 downto 12) and sw(3 downto 0))) when "01",
 ("000000000000" & (sw(15 downto 12) or sw(3 downto 0))) when "10",
 ("000000000000" & (sw(15 downto 12) xor sw(3 downto 0))) when others;
  
  led <= sum;
  inst_x7seg:  x7seg port map (sw => sum(3 downto 0), sevenseg => seg);
   

end Behavioral;
