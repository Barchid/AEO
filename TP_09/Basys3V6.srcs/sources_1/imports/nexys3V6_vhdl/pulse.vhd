----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:51 01/03/2017 
-- Design Name: 
-- Module Name:    pulse - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse is
    Port ( clk : in  STD_LOGIC;
           inp : in  STD_LOGIC;
           outp : out  STD_LOGIC);
end pulse;

architecture Behavioral of pulse is
signal Q1, Q2, Q3 : std_logic :='0';

begin
process (clk)
begin
	if clk'event and clk ='1' then
		Q1<= inp;
		Q2<= Q1;
		Q3<= Q2;
	end if;
end process;
outp<= Q1 and Q2 and not Q3;

end Behavioral;

