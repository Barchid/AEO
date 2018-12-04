----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:44:24 01/03/2017 
-- Design Name: 
-- Module Name:    reset_mem - Behavioral 
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
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


entity reset_mem is
   port ( clk          : in    std_logic; 
          reset_homade : in    std_logic; 
          reset_mem    : out   std_logic);
end reset_mem;

architecture BEHAVIORAL of reset_mem is
signal Q1,Q2 : std_logic :='0';
begin
	process (clk)
	begin
	if clk'event and clk='1' then
		Q2 <= Q1;
		Q1<= reset_homade;
	end if;

	end process;
reset_mem<= Q2 and not Q1;
 
end BEHAVIORAL;

