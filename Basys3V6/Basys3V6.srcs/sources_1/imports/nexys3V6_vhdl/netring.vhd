----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:10:07 01/03/2017 
-- Design Name: 
-- Module Name:    netring - Behavioral 
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
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity netring is
   port ( clk      : in    std_logic; 
          E_put    : in    std_logic; 
          E_shift  : in    std_logic; 
          I_put    : in    std_logic_vector (31 downto 0); 
          I_X      : in    std_logic_vector (31 downto 0); 
          i_Xmoins : in    std_logic_vector (31 downto 0); 
          I_Y      : in    std_logic_vector (31 downto 0); 
          I_Ymoins : in    std_logic_vector (31 downto 0); 
          P_M      : in    std_logic; 
          X_Y      : in    std_logic; 
          O        : out   std_logic_vector (31 downto 0));
end netring;

architecture BEHAVIORAL of netring is

   signal com_in          : std_logic_vector (31 downto 0);
   signal com_or_slave_in : std_logic_vector (31 downto 0);
   signal final_enable    : std_logic;
   signal sel             : std_logic_vector (1 downto 0);
   component QDE
      port ( E   : in    std_logic; 
             clk : in    std_logic; 
             d   : in    std_logic_vector (31 downto 0); 
             q   : out   std_logic_vector (31 downto 0));
   end component;
   

   
   component Mux2
      port ( sel : in    std_logic; 
             X0  : in    std_logic_vector (31 downto 0); 
             X1  : in    std_logic_vector (31 downto 0); 
             Y   : out   std_logic_vector (31 downto 0));
   end component;
   
   component Mux4
      port ( X0  : in    std_logic_vector (31 downto 0); 
             X1  : in    std_logic_vector (31 downto 0); 
             X2  : in    std_logic_vector (31 downto 0); 
             X3  : in    std_logic_vector (31 downto 0); 
             sel : in    std_logic_vector (1 downto 0); 
             Y   : out   std_logic_vector (31 downto 0));
   end component;
   
   
begin
   XLXI_2 : QDE
      port map (clk=>clk,
                d(31 downto 0)=>com_or_slave_in(31 downto 0),
                E=>final_enable,
                q(31 downto 0)=>O(31 downto 0));
   
   final_enable<=E_put or E_shift;
   
   XLXI_5 : Mux2
      port map (sel=>E_put,
                X0(31 downto 0)=>com_in(31 downto 0),
                X1(31 downto 0)=>I_put(31 downto 0),
                Y(31 downto 0)=>com_or_slave_in(31 downto 0));
   
   XLXI_6 : Mux4
      port map (sel(1 downto 0)=>sel(1 downto 0),
                X0(31 downto 0)=>I_X(31 downto 0),
                X1(31 downto 0)=>I_Y(31 downto 0),
                X2(31 downto 0)=>i_Xmoins(31 downto 0),
                X3(31 downto 0)=>I_Ymoins(31 downto 0),
                Y(31 downto 0)=>com_in(31 downto 0));
   
   sel(0)<=X_Y;
   sel(1)<=P_M;
   
end BEHAVIORAL;
