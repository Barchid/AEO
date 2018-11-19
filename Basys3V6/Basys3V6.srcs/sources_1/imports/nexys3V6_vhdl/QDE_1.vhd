----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:26 04/18/2014 
-- Design Name: 
-- Module Name:    QDE_1 - Behavioral 
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

entity QDE_1 is
	 generic(N : integer := 32);
    Port ( d : in  STD_LOGIC_VECTOR (N-1 downto 0);
           E : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (N-1 downto 0));
			  
		attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end QDE_1;

architecture Behavioral of QDE_1 is

begin
	process(clk)
	begin
	if clk'event   and clk = '0' then
		if E='1' then 
				q <= d;
		end if;
	end if;						 
	end process;

end Behavioral;

