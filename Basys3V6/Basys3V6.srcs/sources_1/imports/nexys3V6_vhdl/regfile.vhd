----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:47:09 01/03/2017 
-- Design Name: 
-- Module Name:    regfile - Behavioral 
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
use IEEE.STD_LOGIC_1164.all;

entity D4_16 is
  
port(

    D1  : out std_logic;
    D3  : out std_logic;
    D5  : out std_logic;
    D7  : out std_logic;
    D9  : out std_logic;
    D11  : out std_logic;
    D13  : out std_logic;
    D15  : out std_logic;

    A0  : in std_logic;
    A1  : in std_logic;
    A2  : in std_logic;
    A3  : in std_logic
  );
end D4_16;

architecture D4_16_V of D4_16 is
  signal d_tmp : std_logic_vector(7 downto 0);
begin
  process (A0, A1, A2, A3)
  variable sel   : std_logic_vector(2 downto 0);
  begin
	 d_tmp <= "00000000";
    sel := A3&A2&A1;
	 if A0 = '1' then 
      case sel is
      when "000" => d_tmp(0) <= '1';
      when "001" => d_tmp(1) <= '1';
      when "010" => d_tmp(2) <= '1';
      when "011" => d_tmp(3) <= '1';
      when "100" => d_tmp(4) <= '1';
      when "101" => d_tmp(5) <= '1';
      when "110" => d_tmp(6) <= '1';
      when "111" => d_tmp(7) <= '1';
      when others => null;
      end case;
	end if ;
		
  end process; 

    D15 <= d_tmp(7);

    D13 <= d_tmp(6);

    D11 <= d_tmp(5);

    D9  <= d_tmp(4);

    D7  <= d_tmp(3);

    D5  <= d_tmp(2);

    D3  <= d_tmp(1);

    D1  <= d_tmp(0);


end D4_16_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


entity regfile is
   port ( clk    : in    std_logic; 
          Nreg   : in    std_logic_vector (2 downto 0); 
          Rstore : in    std_logic_vector (31 downto 0); 
          store  : in    std_logic; 
          Rload  : out   std_logic_vector (31 downto 0));
end regfile;

architecture BEHAVIORAL of regfile is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal E0       : std_logic;
   signal E1       : std_logic;
   signal E2       : std_logic;
   signal E3       : std_logic;
   signal E4       : std_logic;
   signal E5       : std_logic;
   signal E6       : std_logic;
   signal E7       : std_logic;
   signal Rload0   : std_logic_vector (31 downto 0);
   signal Rload0_3 : std_logic_vector (31 downto 0);
   signal Rload1   : std_logic_vector (31 downto 0);
   signal Rload2   : std_logic_vector (31 downto 0);
   signal Rload3   : std_logic_vector (31 downto 0);
   signal Rload4   : std_logic_vector (31 downto 0);
   signal Rload4_7 : std_logic_vector (31 downto 0);
   signal Rload5   : std_logic_vector (31 downto 0);
   signal Rload6   : std_logic_vector (31 downto 0);
   signal Rload7   : std_logic_vector (31 downto 0);
    component mux2x32
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
   
   component QDE_1
      port ( E   : in    std_logic; 
             clk : in    std_logic; 
             d   : in    std_logic_vector (31 downto 0); 
             q   : out   std_logic_vector (31 downto 0));
   end component;
   
   component D4_16
      port ( A0  : in    std_logic; 
             A1  : in    std_logic; 
             A2  : in    std_logic; 
             A3  : in    std_logic;  
             D1  : out   std_logic; 
             D11 : out   std_logic; 
             D13 : out   std_logic; 
             D15 : out   std_logic; 
             D3  : out   std_logic; 
             D5  : out   std_logic; 
             D7  : out   std_logic; 
             D9  : out   std_logic);
   end component;
   


begin
   mux2 : mux2x32
      port map (sel=>Nreg(2),
                X0(31 downto 0)=>Rload0_3(31 downto 0),
                X1(31 downto 0)=>Rload4_7(31 downto 0),
                Y(31 downto 0)=>Rload(31 downto 0));
   
   mux40 : Mux4
      port map (sel(1 downto 0)=>Nreg(1 downto 0),
                X0(31 downto 0)=>Rload0(31 downto 0),
                X1(31 downto 0)=>Rload1(31 downto 0),
                X2(31 downto 0)=>Rload2(31 downto 0),
                X3(31 downto 0)=>Rload3(31 downto 0),
                Y(31 downto 0)=>Rload0_3(31 downto 0));
   
   mux41 : Mux4
      port map (sel(1 downto 0)=>Nreg(1 downto 0),
                X0(31 downto 0)=>Rload4(31 downto 0),
                X1(31 downto 0)=>Rload5(31 downto 0),
                X2(31 downto 0)=>Rload6(31 downto 0),
                X3(31 downto 0)=>Rload7(31 downto 0),
                Y(31 downto 0)=>Rload4_7(31 downto 0));
   
   R0 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E0,
                q(31 downto 0)=>Rload0(31 downto 0));
   
   R1 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E1,
                q(31 downto 0)=>Rload1(31 downto 0));
   
   R2 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E2,
                q(31 downto 0)=>Rload2(31 downto 0));
   
   R3 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E3,
                q(31 downto 0)=>Rload3(31 downto 0));
   
   R4 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E4,
                q(31 downto 0)=>Rload4(31 downto 0));
   
   R5 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E5,
                q(31 downto 0)=>Rload5(31 downto 0));
   
   R6 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E6,
                q(31 downto 0)=>Rload6(31 downto 0));
   
   R7 : QDE_1
      port map (clk=>clk,
                d(31 downto 0)=>Rstore(31 downto 0),
                E=>E7,
                q(31 downto 0)=>Rload7(31 downto 0));
   
   decode : D4_16
      port map (A0=>store,
                A1=>Nreg(0),
                A2=>Nreg(1),
                A3=>Nreg(2),
                D1=>E0,
                D3=>E1,
                D5=>E2,
                D7=>E3,
                D9=>E4,
                D11=>E5,
                D13=>E6,
                D15=>E7);
   
 
   
end BEHAVIORAL;