----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2018 05:17:13 PM
-- Design Name: 
-- Module Name: IP_Rdm - Behavioral
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


entity IP_Rdm is
    GENERIC (Mycode : std_logic_vector(10 downto 0) := "00000010000"
); 
    port (
 clk , reset : in std_logic; 
 IPcode : in std_logic_vector (10 downto 0);
 Tout : out std_logic_vector (31 downto 0)
); 
end IP_Rdm;

architecture Behavioral of IP_Rdm is

component random
 generic ( width : integer :=  32 ); 
port (
   clk , reset : in std_logic;
   enable : in std_logic;
   random_num : out std_logic_vector (width-1 downto 0)   --output vector            
   );
end component;
    signal random_num : std_logic_vector (31 downto 0);
    signal enable : std_logic;
begin

enable <= '1' when IPcode(10 downto 0) = Mycode else '0';

inst_random: random 
		generic map (width=>32)
		PORT MAP(
		clk => clk,
		reset => reset,
		enable => enable,
		random_num => random_num
		);
		
		
 Tout <= random_num when IPcode(10 downto 0) = Mycode else (others =>'Z');


end Behavioral;
