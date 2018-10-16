----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2018 12:19:30 PM
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

entity add4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (3 downto 0);
           cout : out STD_LOGIC);
end add4;

architecture Behavioral of add4 is

    component add1
    port (
       a : in STD_LOGIC;
       b : in STD_LOGIC;
       cin : in STD_LOGIC;
       s : out STD_LOGIC;
       cout : out STD_LOGIC
    );
    end component;
    signal c1, c2, c3 : std_logic;
begin

    Inst0: add1 PORT MAP(
        a => a(0),b => b(0),cin => cin,s => s(0),cout => c1);
    Inst1: add1 PORT MAP(
        a => a(1),b => b(1),cin => c1,s => s(1),cout => c2);
    Inst2: add1 PORT MAP(
        a => a(2),b => b(2),cin => c2,s => s(2),cout => c3);
    Inst3: add1 PORT MAP(
        a => a(3),b => b(3),cin => c3,s => s(3),cout => cout);

end Behavioral;
