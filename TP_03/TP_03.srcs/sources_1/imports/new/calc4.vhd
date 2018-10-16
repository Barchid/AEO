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
           btnC : in STD_LOGIC;
           btnU: in STD_LOGIC;
           btnD : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0) := "1110"
          );
           
end calc4;

architecture Behavioral of calc4 is
    component add4
        port(
           a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (3 downto 0);
           cout : out STD_LOGIC
        ); 
    end component;
    
    component x7seg
        port (
            sw : in STD_LOGIC_VECTOR (3 downto 0);
            sevenseg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;
    
    component comp4
       port(
        spfa : in std_logic_vector(3 downto 0);
        spfo : in std_logic_vector(3 downto 0);
        cout : out std_logic
       ); 
    end component;
    
    component pari8
      Port ( cin : in STD_LOGIC_VECTOR (7 downto 0);
               cout : out STD_LOGIC);
    end component;
    
    component count8
         Port ( sw : in STD_LOGIC_VECTOR (7 downto 0);
               cout : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    signal btns : std_logic_vector(4 downto 0); -- Les boutons
    signal s : std_logic_vector(4 downto 0);
    signal sum : std_logic_vector(15 downto 0); -- 5 bit result
    signal coutCmp: std_logic;
    signal coutCount: std_logic_vector(3 downto 0);
    signal coutPari: std_logic;
begin

 inst_add: add4 port map (
    a => sw(3 downto 0),
    b => sw(15 downto 12),
    cin => '0',
    s => s(3 downto 0),
    cout => s(4)
 );
 
 inst_comp4: comp4 port map (
    spfa => sw(3 downto 0),
    spfo => sw(15 downto 12),
    cout => coutCmp
 );
 
 inst_pari8: pari8 port map(
    cin => sw(7 downto 0),
    cout => coutPari
 );
 
 inst_count8: count8 port map (
    sw => sw(7 downto 0),
    cout => coutCount 
 );
 
 btns <= (btnU & btnR & btnD & btnL & btnC);
 
 with btns select
 sum <= 
 ("00000000000" & s(4 downto 0)) when "00000",
 ("000000000000" & (sw(15 downto 12) and sw(3 downto 0))) when "00001",
 ("000000000000" & (sw(15 downto 12) or sw(3 downto 0))) when "00010",
 ("000000000000" & (sw(15 downto 12) xor sw(3 downto 0))) when "00011",
 ("000000000000000" & coutCmp) when "00100",
 ("000000000000000" & coutPari) when "01000",
 ("000000000000" & coutCount) when "10000",
 (others => '0') when others
 ;
  
  led <= sum;
  inst_x7seg:  x7seg port map (sw => sum(3 downto 0), sevenseg => seg);
   

end Behavioral;
