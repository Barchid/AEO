--                                                   
-- Description :  bank selection for wirting
-- 
-- ----------------------------------------------------------------------------------
-- Copyright : UNIVERSITE DE LILLE 1 - INRIA Lille Nord de France
--  Villeneuve d'Accsq France
-- 
-- Module Name  : Nexys3v6
-- Project Name : Homade V6
-- Revision :     IPcore timer
--                                         
-- Target Device :     spartan 6 spartan 3 virtex 7
-- Tool Version : tested on ISE 12.4,/14.7

-- Contributor(s) :
-- Dekeyser Jean-Luc ( Creation  juin 2012) jean-luc.dekeyser@univ_lille1.fr
-- 
-- 
-- Cecil Licence:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;
USE ieee.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity select_in is
    Port ( count : in  STD_LOGIC_VECTOR (7 downto 0);
			  X,Y : in  STD_LOGIC_vector(1 downto 0);
			  Lastcycle : in std_logic;
			  litload : in std_logic;
			  
			  adr0 : out STD_LOGIC_VECTOR (3 downto 0);
			  adr1 : out STD_LOGIC_VECTOR (3 downto 0);
			  adr2 : out STD_LOGIC_VECTOR (3 downto 0);
			  adr3 : out STD_LOGIC_VECTOR (3 downto 0);
			  selin0 : out STD_LOGIC_VECTOR (1 downto 0);
			  selin1 : out STD_LOGIC_VECTOR (1 downto 0);
			  selin2 : out STD_LOGIC_VECTOR (1 downto 0);
			  selin3 : out STD_LOGIC_VECTOR (1 downto 0);  
			  selreg0 : out STD_LOGIC_VECTOR (1 downto 0);
			  selreg1 : out STD_LOGIC_VECTOR (1 downto 0);
			  selreg2 : out STD_LOGIC_VECTOR (1 downto 0);
			  selreg3 : out STD_LOGIC_VECTOR (1 downto 0); 		  
           we0 : out  STD_LOGIC;
           we1 : out  STD_LOGIC;
           we2 : out  STD_LOGIC;
			  we3 : out  STD_LOGIC);
end select_in;

architecture Behavioral of select_in is

signal ptr : std_logic_vector( 5 downto 0) ;
signal adr : std_logic_vector (3 downto 0) ;
signal  F0,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27 : std_logic;
signal C5,C4,C3,C2,C1,C0, NC5,NC4,NC3,NC2,NC1,NC0: std_logic;


signal control, control_rom : std_logic_vector ( 27 downto 0 ) ;
signal S01, S02, S03, S11, S12, S13, S21, S22, S23, S31, S32, S33 , R0, R1, R2, R3, W0, W1, W2, W3: std_logic;
--  type rom_array is array (0 to 63) of std_logic_vector ( 27 downto 0 ) ;
--constant  select_rom : rom_array := (
----"A0A1A2A3r0r1r2r3I0I1I2I3wwww" ---- 
--"0000000000000000000000000000",--000000
--"0000000000000000000000000000",--000001
--"0000000000000000000000000000",--000010
--"0000000000000000000000000000",--000011
--
--"0000000001000000000000001000",--000100
--"0000000000010000000000000100",--000101
--"0000000000000100000000000010",--000110
--"0000000000000001000000000001",--000111
--
--"0000000001010000010000001100",--001000
--"0000000000010100000100000110",--001001
--"0000000000000101000001000011",--001010
--"0100000001000001000000011001",--001011
--
--"0000000001010100100100001110",--001100
--"0000000000010101001001000111",--001101
--"0100000001000101000010011011",--001110
--"0101000001010001010000101101",--001111
--
--"0000001000000010000000000000",--010000
--"1100000010000000000000000000",--010001
--"0011000000100000000000000000",--010010
--"0000110000001000000000000000",--010011
--
--"0000001100000001000000000001",--010100
--"0000000001000000000000001000",--010101
--"0000000000010000000000000100",--010110
--"0000000000000100000000000010",--010111
--
--"0000001101000001000000011001",--011000
--"0000000001010000010000001100",--011001
--"0000000000010100000100000110",--011010
--"0000000000000101000001000011",--011011
--
--"0000001101010001010000101101",--011100
--"0000000001010100100100001110",--011101
--"0000000000010101001001000111",--011110
--"0000000001000101000010011011",--011111
--
--"0000101000001010000000000000",--100000
--"1100001010000010000000000000",--100001
--"1111000010100000000000000000",--100010
--"0011110000101000000000000000",--100011
--
--"0000111000000110000000000010",--100100
--"1100001110000001000000000001",--100101
--"0011000001100000000000001000",--100110
--"0000110000011000000000000100",--100111
--
--"0000111100000101000001000011",--101000
--"0000001101000001000000011001",--101001
--"0000000001010000010000001100",--101010
--"0000000000010100000100000110",--101011
--
--"0000101001000101000010011011",--101100
--"0000001001010001010000101101",--101101
--"0000000001010100100100001110",--101110
--"0000000000010101001001000111",--101111
--
--"0010101000101010000000000000",--110000
--"1100101010001010000000000000",--110001
--"1111001010100010000000000000",--110010
--"1111110010101000000000000000",--110011
--
--"0011101000011010000000000100",--110100
--"1100111010000110000000000010",--110101
--"1111001110100001000000000001",--110110
--"0011110001101000000000001000",--110111
--
--"0011111000010110000100000110",--111000
--"1100111110000101000001000011",--111001
--"0011001101100001000000011001",--111010
--"0000110001011000010000001100",--111011
--
--"0011111100010101001001000111",--111100
--"0000111101000101000010011011",--111101
--"0000001101010001010000101101",--111110
--"0000000001010100100100001110"--111111
--
--);

begin
			
C5<= X(1);
C4 <= X(0);
C3 <= Y(1);
C2 <= Y(0);
C1 <= count(1);
C0 <= count(0);
NC5<= not C5;
NC4<= not C4;
NC3<= not C3;
NC2<= not C2;
NC1<= not C1;
NC0<= not C0;


F0 <= ( c4 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 );
F1 <= ( NC5 AND NC4 AND c3 AND c2 AND c1 ) OR 
 ( c4 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 );
F2 <= ( c5 AND NC4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 );
F3 <= ( NC5 AND NC4 AND c3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 );
F4 <= ( c5 AND NC4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND c0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F5 <= ( c5 AND NC4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F6 <= ( c4 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND NC0 ) OR 
 ( c5 AND c3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F7 <= ( c5 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F8 <= ( c4 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 );
F9 <= ( NC5 AND NC4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( NC5 AND c4 AND c2 AND NC1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND NC1 AND NC0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND c0 ) OR 
 ( c5 AND NC4 AND c3 AND c1 AND NC0 ) OR 
 ( NC5 AND NC4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND NC0 ) OR 
 ( NC4 AND c3 AND c2 AND NC0 ) OR 
 ( c4 AND c3 AND c2 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND c1 AND NC0 );
F10 <= ( c5 AND NC4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 );
F11 <= ( NC5 AND NC4 AND c2 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND NC1 AND NC0 ) OR 
 ( NC5 AND NC4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c3 AND c1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND c1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c3 AND c2 AND c1 ) OR 
 ( NC4 AND c3 AND c2 AND c0 ) OR 
 ( c4 AND c3 AND c2 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 );
F12 <= ( c5 AND NC4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c4 AND NC3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND c1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND c0 ) OR 
 ( c5 AND NC3 AND NC2 AND c1 AND c0 );
F13 <= ( NC5 AND NC4 AND c2 AND c1 AND NC0 ) OR 
 ( NC5 AND c4 AND c2 AND c1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND c1 AND NC0 ) OR 
 ( NC5 AND c4 AND c3 AND c1 AND NC0 ) OR 
 ( NC5 AND c4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( NC4 AND c3 AND c2 AND NC0 ) OR 
 ( c4 AND c3 AND c2 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F14 <= ( c4 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND NC2 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND NC0 );
F15 <= ( NC5 AND NC4 AND c2 AND c1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND c1 AND NC0 ) OR 
 ( NC5 AND c4 AND c3 AND c1 AND c0 ) OR 
 ( NC5 AND NC4 AND c3 AND c1 AND c0 ) OR 
 ( c5 AND NC4 AND NC3 AND c2 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC2 AND NC1 AND NC0 ) OR 
 ( c5 AND NC4 AND c3 AND NC1 AND c0 ) OR 
 ( NC5 AND c4 AND c3 AND NC1 AND NC0 ) OR 
 ( c5 AND c3 AND c2 AND NC1 AND NC0 ) OR 
 ( NC4 AND c3 AND c2 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND c1 AND NC0 ) OR 
 ( c4 AND c3 AND c2 AND NC0 ) OR 
 ( c5 AND c4 AND NC3 AND c2 AND c1 AND NC0 ) OR 
 ( c5 AND c4 AND c3 AND NC2 AND NC1 AND c0 ) OR 
 ( c5 AND c4 AND c3 AND c2 AND NC1  );
F16 <= ( C5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR (Litload ) ;
F17 <= ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR (Litload) ;
F18 <= ( C5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR (Litload) ;
F19 <= ( C5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR (Litload) ;
F20 <= ( C5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND C0 ) OR (Litload) ;
F21 <= ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND C0 ) OR (Litload) ;
F22 <= ( NC5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR (Litload) ;
F23 <= ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND NC0 ) OR (Litload) ;
F24 <= ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND NC4 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND C0 ) ;
F25 <= ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND C4 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND NC0 ) ;
F26 <= ( C5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND C1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND NC0 ) ;
F27 <= ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND NC2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND NC2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C3 AND NC2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C3 AND NC2 AND C1 AND C0) OR 
 ( NC5 AND C4 AND C2 AND NC1 AND NC0) OR 
 ( C5 AND C4 AND C2 AND C1 AND NC0) OR 
 ( C5 AND NC4 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND NC4 AND C2 AND C1 AND C0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND C1 AND C0) OR 
 ( C5 AND NC4 AND C3 AND C2 AND NC1 AND NC0) OR 
 ( NC5 AND NC4 AND C3 AND C2 AND C1 AND NC0) OR 
 ( C5 AND C4 AND C3 AND C2 AND NC1 AND C0) OR 
 ( NC5 AND C4 AND C3 AND C2 AND C1 AND C0 ) ;



control(27) <= F0 and lastcycle;
control(26) <= F1 and lastcycle;
control(25) <= F2 and lastcycle;
control(24) <= F3 and lastcycle;
control(23) <= F4 and lastcycle;
control(22) <= F5 and lastcycle;
control(21) <= F6 and lastcycle;
control(20) <= F7 and lastcycle;
control(19) <= F8 and lastcycle;
control(18) <= F9 and lastcycle;
control(17) <= F10 and lastcycle;
control(16) <= F11 and lastcycle;
control(15) <= F12 and lastcycle;
control(14) <= F13 and lastcycle;
control(13) <= F14 and lastcycle;
control(12) <= F15 and lastcycle;
control(11) <= F16 and lastcycle;
control(10) <= F17 and lastcycle;
control(9) <= F18 and lastcycle;
control(8) <= F19 and lastcycle;
control(7) <= F20 and lastcycle;
control(6) <= F21 and lastcycle;
control(5) <= F22 and lastcycle;
control(4) <= F23 and lastcycle;
control(3) <= F24 and lastcycle;
control(2) <= F25 and lastcycle;
control(1) <= F26 and lastcycle;
control(0) <= F27 and lastcycle;






ptr<= X & Y & count(1 downto 0);
adr<= count(5 downto 2);
--control <= control_rom when lastcycle='1' else x"0000000" ;
we0<=control(3); 
we1<=control(2);
we2<=control(1); 
we3<=control(0);
adr0<= adr + conv_integer(control(27 downto 26)); 
adr1<= adr + conv_integer(control(25 downto 24)); 
adr2<= adr + conv_integer(control(23 downto 22)); 
adr3<= adr + conv_integer(control(21 downto 20)); 
selreg0<=control(19 downto 18);
selreg1<=control(17 downto 16);
selreg2<=control(15 downto 14);
selreg3<=control(13 downto 12);
selin0<=control(11 downto 10) ;
selin1<=control(9 downto 8) ;
selin2<=control(7 downto 6) ;
selin3<=control(5 downto 4) ;

--
--begin
--process(X,Y,count,lastcycle)
--variable sel : std_logic_vector (3 downto 0) ;
--variable adr : std_logic_vector(3 downto  0):="0000" ;
--variable bank : std_logic_vector (1 downto 0):="00" ;
--begin
--sel := X&Y;
--we0<='0'; we1<='0';we2<='0'; we3<='0';
--adr0<= "0000"; 
--adr1<= "0000"; 
--adr2<= "0000"; 
--adr3<= "0000"; 
--selreg0<="00";
--selreg1<="00";
--selreg2<="00";
--selreg3<="00";
--selin0<="00";
--selin1<="00";
--selin2<="00";
--selin3<="00";
--adr := count(5 downto 2);
--bank := count(1 downto 0);
--if lastcycle='1' then
--	case sel is
--		when "0000"  => null;
--		when "0100" => 
--			case bank is 
--				when "00" =>  selreg3 <= "10"; adr3 <= adr -2;
--				when "01" =>  selreg0 <= "10"; adr0 <= adr-1;
--				when "10" =>  selreg1 <= "10"; adr1 <= adr-1;
--				when "11" =>  selreg2 <= "10"; adr2 <= adr-1;
--				when others => null;
--			end case;
--		when "1000" => 
--			case bank is 
--				when "00" =>  selreg3 <= "10"; adr3 <= adr -2; 	 selreg2 <= "10"; adr2 <= adr -2;
--				when "01" =>  selreg0 <= "10"; adr0 <= adr-1; 		 selreg3 <= "10"; adr3 <= adr -2;
--				when "10" =>  selreg1 <= "10"; adr1 <= adr-1; 		 selreg0 <= "10"; adr0 <= adr-1;
--				when "11" =>  selreg2 <= "10"; adr2 <= adr-1; 		 selreg1 <= "10"; adr1 <= adr-1;
--				when others  => null;
--			end case;
--		when "1100" => 
--			case bank is 
--				when "00" =>  selreg3 <= "10"; adr3 <= adr -2; 	 selreg2 <= "10"; adr2 <= adr -2; 	 selreg1 <= "10"; adr1 <= adr -2;
--				when "01" =>  selreg0 <= "10"; adr0 <= adr-1; 		 selreg3 <= "10"; adr3 <= adr -2; 	 selreg2 <= "10"; adr2 <= adr -2; 
--				when "10" =>  selreg1 <= "10"; adr1 <= adr-1; 		 selreg0 <= "10"; adr0 <= adr-1; 		 selreg3 <= "10"; adr3 <= adr -2;
--				when "11" =>  selreg2 <= "10"; adr2 <= adr-1; 		 selreg1 <= "10"; adr1 <= adr-1; 		 selreg0 <= "10"; adr0 <= adr-1;
--				when others => null;
--			end case;
--		when "0001" =>
--			case bank is
--				when "00" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <= "00";
--				when "01" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ;
--				when "10" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ;
--				when "11" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="00" ;
--				when others => null;
--			end case;		
--		when "0010" =>
--			case bank is
--				when "00" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <= "01"; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ;
--				when "01" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ;
--				when "10" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="01" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="00" ;
--				when "11" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="01" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr +1 ; selin0 <= "00";
--				when others => null;
--			end case;	
--		when "0011" =>
--			case bank is
--				when "00" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <= "10"; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ;		we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ;
--				when "01" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="10" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="01" ;		we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="00" ;
--				when "10" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="10" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="01" ; 		we0 <= '1'; selreg0 <= "01"; adr0 <= adr +1 ; selin0 <= "00";
--				when "11" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="10" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr +1 ; selin0 <= "01";	we1 <= '1'; selreg1 <= "01"; adr1 <= adr +1; selin1 <="00" ;
--				when others => null;
--			end case;	
--		when "0101" =>
--			case bank is
--				when "00" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <= "00"; 	 
--				when "01" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 	 
--				when "10" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 	
--				when "11" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ; 	
--				when others => null;
--			end case;	
--		when "0110" =>
--			case bank is
--				when "00" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <= "01"; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 
--				when "01" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 	 
--				when "10" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ; 
--				when "11" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="01" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <= "00";
--				when others => null;
--			end case;	
--		when "0111" =>
--			case bank is
--				when "00" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <= "10"; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 
--				when "01" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="10" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ;  
--				when "10" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="10" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="01" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <= "00";
--				when "11" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="10" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <= "01";	we0 <= '1'; selreg0 <= "01"; adr0 <= adr +1; selin0 <="00" ;
--				when others => null;
--			end case;			
--		when "1001" =>
--			case bank is
--				when "00" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <= "00"; 		 selreg3 <= "10"; adr3 <= adr -2; 
--				when "01" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr -1; selin3 <="00" ; 	 selreg0 <= "10"; adr0 <= adr -1; 
--				when "10" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 		 selreg1 <= "10"; adr1 <= adr -1; 
--				when "11" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 		 selreg2 <= "10"; adr2 <= adr -1; 
--				when others => null;
--			end case;	
--		when "1010" =>
--			case bank is
--				when "00" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <= "01"; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="00" ; 
--				when "01" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="01" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 	 
--				when "10" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 
--				when "11" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <= "00";
--				when others => null;
--			end case;	
--		when "1011" =>
--			case bank is
--				when "00" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <= "10"; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="01" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 
--				when "01" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="10" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ;
--				when "10" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="10" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="01" ; 		we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <= "00";
--				when "11" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="10" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <= "01";		we3 <= '1'; selreg3 <= "01"; adr3 <= adr; selin3 <="00" ;
--				when others => null;
--			end case;			
--		when "1101" =>
--			case bank is
--				when "00" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr-1; selin1 <= "00"; 		 selreg2 <= "10"; adr2 <= adr -2;  	 selreg3 <= "10"; adr3 <= adr -2; 
--				when "01" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr -1; selin2 <="00" ; 	 selreg3 <= "10"; adr3 <= adr -2; 		 selreg0 <= "10"; adr0 <= adr -1; 
--				when "10" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr -1; selin3 <="00" ; 	 selreg0 <= "10"; adr0 <= adr -1; 		 selreg1 <= "10"; adr1 <= adr -1;
--				when "11" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 		 selreg1 <= "10"; adr1 <= adr -1; 		 selreg2 <= "10"; adr2 <= adr -1;
--				when others => null;
--			end case;	
--		when "1110" =>
--			case bank is
--				when "00" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr-1; selin1 <= "01"; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <="00" ; 	selreg3 <= "10"; adr3 <= adr -2; 
--				when "01" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <="01" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="00" ; 	selreg0 <= "10"; adr0 <= adr -1; 
--				when "10" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="01" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ;  	selreg1 <= "10"; adr1 <= adr -1;
--				when "11" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <= "00";		selreg2 <= "10"; adr2 <= adr -1;
--				when others => null;
--			end case;	
--		when "1111" =>
--			case bank is
--				when "00" => we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <= "00"; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <="01" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr-1; selin1 <="10" ; 
--				when "01" => we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="00" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <="01" ; 	we2 <= '1'; selreg2 <= "01"; adr2 <= adr-1; selin2 <="10" ;  
--				when "10" => we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <="00" ; 	we0 <= '1'; selreg0 <= "01"; adr0 <= adr; selin0 <="01" ; 	we3 <= '1'; selreg3 <= "01"; adr3 <= adr-1; selin3 <= "10";
--				when "11" => we2 <= '1'; selreg2 <= "01"; adr2 <= adr; selin2 <="00" ; 	we1 <= '1'; selreg1 <= "01"; adr1 <= adr; selin1 <= "01";	we0 <= '1'; selreg0 <= "01"; adr0 <= adr ; selin0 <="10" ;
--				when others => null;
--			end case;			
--		when others  => null ;
--		end case;
--end if;
--if litload='1' then
---- litteral : un seul input, on force  les entrées sur le bus lit
--	 selin0<= "11";
--	 selin1<= "11";
--	 selin2<="11";
--	 selin3<= "11";
--end if;
-- 
--end process;
				


end Behavioral;
