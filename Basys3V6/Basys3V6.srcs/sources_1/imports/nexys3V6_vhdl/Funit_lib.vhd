--                                                   
-- Description :  IP Funit for 32 bit ALU unsigned complement 2
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use work.IPcodes.all;

entity IP_Funit is
		GENERIC (Mycode : std_logic_vector(5 downto 0) := "000000" );
    Port ( 
			  Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           Nin : in  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_VECTOR (10 downto 0);
           Tout : out  STD_LOGIC_VECTOR (31 downto 0));
end IP_Funit;


architecture myFunit of IP_Funit is

signal  tbb, unit, Teq, Tneq, Tgt, Tge, Tle, Tlt: std_logic;
signal tbool1,  tbool3, tbool4,  tbool7, tbool8, tbool9, tbool10, tbool11, tbool12, tbool13, tbool14, tbool15, tbool16, tbool17: std_logic :='0';


signal Tbus1, Tbus2, Tbus3, Tbus4, Tbus5, Tbus6, Tbus7, Tbus8, Tbus9, Tbus10, Tbus11, Tbus12, Tbus13, Tbus14, Tbus15,  tbb32, Tadd, Ta, Tb, Ts, Tsinc : std_logic_vector(31 downto 0) ;
signal uadd, uminus, udec,uinc,ucomp2 , seladd, selci: std_logic;

--component incdec
--	port (
--	a: in std_logic_vector(31 downto 0);
--	add: in std_logic;
--	s: out std_logic_vector(31 downto 0));
--end component;

-- Synplicity black box declaration
--attribute syn_black_box : boolean;
--attribute syn_black_box of incdec: component is true;
--component addsub
--	port (
--	a: in std_logic_vector(31 downto 0);
--	b: in std_logic_vector(31 downto 0);
--	add: in std_logic;
--	s: out std_logic_vector(31 downto 0));
--end component;

-- Synplicity black box declaration
--attribute syn_black_box of addsub: component is true;

begin
--my_incdec: incdec
--		port map (
--			a => Tin ,
--			add => uinc,
--			s => tsinc);

tsinc<= Tin+ 1 when uinc = '1' else Tin - 1;
			
--my_addsub: addsub
--		port map (
--			a => Nin,
--			b => Tin,
--			add => uadd,
--			s => ts);

ts <= Nin + Tin when uadd ='1' else Nin - Tin;

unit <= '1' when mycode = ipcode(10 downto 5) else '0';
uadd <= '1' when Ipcode(4 downto 0 ) = IPadd else '0';
uminus <= '1' when Ipcode(4 downto 0 ) = IPminus else '0';
uinc <= '1' when Ipcode(4 downto 0 ) = IPinc else '0';
udec <= '1' when Ipcode(4 downto 0 ) = IPdec else '0';
ucomp2 <= '1' when Ipcode(4 downto 0 ) = IPcomp2 else '0';




			
Tbus1<= Ts;
Tbus2 <= Ts ;


Tbus3 <= Tsinc ;
Tbus4 <= Tsinc ;
Tbus5 <= Not Tin  ;
Tbus6 <= Tin AND Nin  ;
Tbus7 <= Tin OR Nin;
Tbus8 <= Tin XOR Nin  ;
Tbus9 <= Tin(30 downto 0) & '0'  ;
Tbus10 <= '0' & Tin(31 downto 1) ;
Tbus11 <= Tin(31)  & Tin(31 downto 1) ;
Tbus12 <= SHR( Nin , Tin(4 downto 0))  ;
Tbus13 <= SHL (Nin, Tin(4 downto 0) )  ;


Tbus14 <=  Tbus5 + 1 ;
Tbus15 <= Tin(19 downto 0) & Nin(11 downto 0)  ;

						
tout <= tbus1   when unit='1' and uadd='1'  else (others => 'Z')  ;
tout <= tbus2   when unit='1' and uminus='1'  else (others => 'Z') ;
tout <= tbus3   when unit='1' and udec='1'  else (others => 'Z');
tout <= tbus4   when unit='1' and uinc ='1'  else (others => 'Z');
tout <= tbus5   when unit='1' and  Ipcode(4 downto 0 ) = IPnot  else (others => 'Z');
tout <= tbus6   when unit='1' and  Ipcode(4 downto 0 ) = IPand   else (others => 'Z');
tout <= tbus7   when unit='1' and  Ipcode(4 downto 0 ) = IPor    else (others => 'Z') ;
tout <= tbus8   when unit='1' and Ipcode(4 downto 0 ) = IPxor  else (others => 'Z');
tout <= tbus9   when unit='1' and  Ipcode(4 downto 0 ) = IPmul2   else (others => 'Z');
tout <= tbus10   when unit='1' and Ipcode(4 downto 0 ) = IPdiv2U  else (others => 'Z') ;
tout <= tbus11  when unit='1' and Ipcode(4 downto 0 ) = IPdiv2   else (others => 'Z') ;
tout <= tbus12   when unit='1' and Ipcode(4 downto 0 ) = IPrshift   else (others => 'Z');
tout <= tbus13   when unit='1' and Ipcode(4 downto 0 ) = IPlshift  else (others => 'Z');
tout <= tbus14  when unit='1' and ucomp2 ='1'   else (others => 'Z') ;
tout <= tbus15  when unit='1' and Ipcode(4 downto 0 ) = IPshiftlit   else (others => 'Z');

Tbool1 <= '1' when Ipcode(4 downto 0 ) = IPtrue else '0';
--Tbool2 <= '0' when Ipcode(4 downto 0 ) = IPfalse else '0';
Tbool3 <= '1' when Tin = x"00000000"  and Ipcode(4 downto 0 ) = IPEQzero else '0';
Tbool4 <= '1' when Tin(31) = '1' and Ipcode(4 downto 0 ) = IPNeg else '0';


Teq <= '1' when NIN = Tin else '0';
Tneq <= not Teq;

Tlt <=  Ts(31);

Tgt <= not Tle;
Tge <= not Tlt;
TLe <= Tlt or Teq;



Tbool7 <= Teq when Ipcode(4 downto 0 ) = IPEq else '0';
Tbool10 <= Tneq when  Ipcode(4 downto 0 ) = IPNe else '0';
Tbool11 <= Tgt when (Ipcode(4 downto 0 ) = IPGt) else '0';
Tbool12 <=  Tlt when  Ipcode(4 downto 0 ) = IPLt else '0';
Tbool13 <= Tle when  Ipcode(4 downto 0 ) = IPLe else '0';
Tbool14 <= Tge when   Ipcode(4 downto 0 ) = IPGe else '0';


Tbool15  <= '1'  when (Tin(0) AND Nin(0))='1' and   Ipcode(4 downto 0 ) = IPand2 else '0'; 
Tbool16  <= '1'  when (Tin(0) OR Nin(0))='1' and  Ipcode(4 downto 0 ) = IPor2 else '0';
Tbool17  <= '1'  when  (Tin(0) XOR Nin(0))='1' and Ipcode(4 downto 0 ) = IPxor2 else '0'; 


tbb <= tbool1 or tbool3 or tbool4 or tbool7 or tbool10 or tbool11 or tbool12 or tbool13 or tbool14 or tbool15 or tbool16 or tbool17 ;

--
tbb32 <= (31 downto 0 =>     tbb ) ;
						
tout <= tbb32   when ipcode(4)='1' and unit='1' else (others => 'Z');
end myFunit;

