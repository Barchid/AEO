----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:20:13 01/03/2017 
-- Design Name: 
-- Module Name:    afficheur - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity afficheur is
   port ( clk       : in    std_logic; 
          din       : in    std_logic_vector (15 downto 0); 
          E190      : in    std_logic; 
          state7seg : in    std_logic_vector (1 downto 0); 
          anodes    : out   std_logic_vector (3 downto 0); 
          sevenseg  : out   std_logic_vector (6 downto 0));
end afficheur;

architecture BEHAVIORAL of afficheur is
   attribute HU_SET     : string ;
   signal sel                   : std_logic_vector (1 downto 0);
   signal digit                : std_logic_vector (3 downto 0);

   component x7seg
      port ( sw       : in    std_logic_vector (3 downto 0); 
             sevenseg : out   std_logic_vector (6 downto 0); 
             state    : in    std_logic_vector (1 downto 0));
   end component;
 signal cpt : std_logic_vector(1 downto 0)  :="00"; 
 signal my_anodes : std_logic_vector ( 3 downto 0) :="1110";
 
begin
   XLXI_1 : x7seg
      port map (state(1 downto 0)=>state7seg(1 downto 0),
                sw(3 downto 0)=>digit(3 downto 0),
                sevenseg(6 downto 0)=>sevenseg(6 downto 0));
   
 process ( clk )

 
begin 
	if clk'event and clk='1' then
		if E190 ='1' then
			cpt <= cpt + 1;
			my_anodes <= my_anodes(2 downto 0) & my_anodes (3);
		end if;
	end if;
end process;
anodes<= my_anodes;

digit <= din(3 downto 0) when cpt = "00" else
				din(7 downto 4) when cpt = "01" else
				din(11 downto 8)  when cpt ="10" else
				din(15 downto 12) when cpt ="11" ;			
   
end BEHAVIORAL;

