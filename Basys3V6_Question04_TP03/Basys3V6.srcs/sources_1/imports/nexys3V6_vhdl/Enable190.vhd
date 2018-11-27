----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:25 01/03/2017 
-- Design Name: 
-- Module Name:    Enable190 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Enable190 is
    Port ( clk : in  STD_LOGIC;
           Enable190 : out  STD_LOGIC);
end Enable190;

architecture Behavioral of Enable190 is

	signal Q1, Q2 : std_logic;
begin
	process (clk)

	variable cpt : std_logic_vector (19 downto 0):= x"00000";
	begin
	if clk'event and clk='1' then
		cpt := cpt + 1;
		q1<= cpt(17);
		q2<= Q1;
	end if;
	end process;
Enable190 <= not Q2 and  Q1;

	
	

end Behavioral;

