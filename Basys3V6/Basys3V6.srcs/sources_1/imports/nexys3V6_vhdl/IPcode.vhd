----------------------------------------------------------------------------------
-- Copyright : UNIVERSITE DE LILLE 1 - INRIA Lille Nord de France
--  Villeneuve d'Accsq France
-- 
-- Module Name  : IPcodes
-- Project Name :  Homade V1.4
-- Revision :      
--                                         
-- Target Device :     spartan 6 spartan 3
-- Tool Version : tested on ISE 12.4,
--                                                   
-- Description :  IPcodes : A package of IPcodes for the Homade stack processor
-- 
-- 
-- Contributor(s) :
-- Dekeyser Jean-Luc ( Creation  juin 2012) jean-luc.dekeyser@lifl.fr
-- Wissem Chouchene ( revision 001,  Ocotbre 2012) wissem.chouchene@inria.fr
-- 
-- 
-- Cecil Licence:
-- This software is a computer program whose purpose is to Implement the
-- Homade processor on Xilinx FPGA systems.
-- 
-- This software is governed by the CeCILL license under French law and
-- abiding by the rules of distribution of free software.  You can  use,
-- modify and/ or redistribute the software under the terms of the CeCILL
-- license as circulated by CEA, CNRS and INRIA at the following URL
-- "http://www.cecill.info".
-- 
-- As a counterpart to the access to the source code and  rights to copy,
-- modify and redistribute granted by the license, users are provided only
-- with a limited warranty  and the software's author,  the holder of the
-- economic rights,  and the successive licensors  have only  limited
-- liability.
--                                                                                          
-- In this respect, the user's attention is drawn to the risks associated
-- with loading,  using,  modifying and/or developing or reproducing the
-- software by the user in light of its specific status of free software,
-- that may mean  that it is complicated to manipulate,  and  that  also
-- therefore means  that it is reserved for developers  and  experienced
-- professionals having in-depth computer knowledge. Users are therefore
-- encouraged to load and test the software's suitability as regards their                                                                           
-- requirements in conditions enabling the security of their systems and/or
-- data to be ensured and,  more generally, to use and operate it in the
-- same conditions as regards security.
-- 
-- The fact that you are presently reading this means that you have had
-- knowledge of the CeCILL license and that you accept its terms.   
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

package IPcodes is          
  subtype code is std_logic_vector(10 downto 0);


--
-- code "11111111111" is forbidden!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

-- IP NOP  0

constant IPNop 			: code := "00000000000";  -- x x  nop pop1 ... push3

-- IP system 1
constant GenM_Tic : std_logic :='1';
constant GenS_Tic : std_logic :='0';
constant IPTic 			: code := "00000000001";  -- 0 1 

-- IP I/O 2 to 4
constant GenM_bufout : std_logic :='1';
constant GenS_bufout : std_logic :='0';
constant IPBufOut 		: code := "00000000010";  -- 1/0 0

constant GenM_led : std_logic :='1';
constant GenS_led : std_logic :='0';
constant IPLed 			: code := "00000000011";   -- 1/0 1 

constant GenM_switch : std_logic :='1';
constant GenS_switch : std_logic :='0';
constant IPSwitch 		: code := "00000000100";	-- 0 1 

-- IP identity   5
constant GenM_identity : std_logic :='1';
constant GenS_identity : std_logic :='1';
constant IPidentity  	: code := "00000000101";	-- x y  manip sur les sommets de piles

-- dta stack T to R, R to T 6 et 7
constant GenM_datastack : std_logic :='1';
constant GenS_datastack : std_logic :='1';
constant IPDataStack		: std_logic_vector (9 downto 0) :="0000000011";
constant IDataPush		: std_logic_vector (0 downto 0) :="1";
constant IDataPop		: std_logic_vector (0 downto 0) :="0";
constant IPDataPush 		: code := IPDataStack & IDataPush;	-- 1/0 0
constant IPDataPop 		: code := IPDataStack & IDataPop;	-- 0 1 






--  IP stack operations   Unit  8 to E
constant GenM_stack : std_logic :='1';
constant GenS_stack : std_logic :='1';
constant IPStack		: std_logic_vector (7 downto 0) :="00000001";
constant IDup 			: std_logic_vector (2 downto 0) := "000";  -- 1 2
constant ISwap 		: std_logic_vector (2 downto 0) := "001";	-- 2 2 
--constant IDrop 		: std_logic_vector (2 downto 0) := "000";  --same as IPNop with 1 0
constant ITuck			: std_logic_vector (2 downto 0) := "010";  -- 2 3
constant IOver 		: std_logic_vector (2 downto 0) := "011";  -- 2 3 
constant IRot 			: std_logic_vector (2 downto 0) := "100";  -- 3 3 
constant IInvRot 		: std_logic_vector (2 downto 0) := "101";  -- 3 3
constant INip 			: std_logic_vector (2 downto 0) := "110";  -- 2 1
constant Iclearstack : std_logic_vector (2 downto 0) := "111";  -- 0 0
constant IPDup 			: code := IPStack & IDup;  -- 1 2
constant IPSwap 			: code := IPStack & ISwap;	-- 2 2 
--constant IPDrop 			: code := IPStack & IDrop;  --same as IPNop with 1 0
constant IPTuck			: code := IPStack & ITuck;  -- 2 3
constant IPOver 			: code := IPStack & IOver;  -- 2 3 
constant IPRot 			: code := IPStack & IRot;  -- 3 3 
constant IPInvRot 		: code := IPStack & IInvRot;  -- 3 3
constant IPNip 			: code := IPStack & INip;  -- 2 1
constant IPclearstack 			: code := IPStack & Iclearstack;  -- 2 1

---- IP RDM  F
constant GenM_rdm : std_logic :='1';
constant GenS_rdm : std_logic :='1';
constant IPRdm 		: code := "00000010000";  --  0  1


--  Master slave com 12 , 13
constant GenM_ME : std_logic :='1';
constant GenS_ME : std_logic :='0';
constant IPME			: std_logic_vector (9 downto 0) :="0000001001";
constant IPM2E			: code := IPME & "1";
constant IPE2M			: code := IPME & "0";

-- mul16 14

constant GenM_mul16 : std_logic :='1';
constant GenS_mul16 : std_logic :='1';
constant IPmul16	: code := "00000010100";  --   2 1

-- muladd not used 15
constant GenM_muladd : std_logic :='0';
constant GenS_muladd : std_logic :='0';
constant IPmuladd 	: code := "00000010101";  --   3 1

-- IPunit  from 20 to 3F
constant GenM_funit : std_logic :='1';
constant GenS_Funit : std_logic :='1';
constant IPFunit		: std_logic_vector (5 downto 0) :="000001";

-- 32 result bit(4) = 0

constant IPAdd 			: std_logic_vector (4 downto 0) := "00000";  --2 1
constant IPMinus 			: std_logic_vector (4 downto 0) := "00001";  -- 2 1
constant IPInc 			: std_logic_vector (4 downto 0) := "00010";  -- 1 1
constant IPDec 			: std_logic_vector (4 downto 0) := "00011";  -- 1 1
constant IPNot 			: std_logic_vector (4 downto 0) := "00100";  -- 1 1
constant IPAnd 			: std_logic_vector (4 downto 0) := "00101";  -- 2 1
constant IPOr 				: std_logic_vector (4 downto 0) := "00110";  -- 2 1
constant IPXor 			: std_logic_vector (4 downto 0) := "00111";  -- 2 1
constant IPMul2 			: std_logic_vector (4 downto 0) := "01000";  -- 1 1
constant IPDiv2U 			: std_logic_vector (4 downto 0) := "01001";  -- 1 1
constant IPDiv2 			: std_logic_vector (4 downto 0) := "01010";  -- 1 1
constant IPRshift 		: std_logic_vector (4 downto 0) := "01011";  -- 2 1
constant IPLshift 		: std_logic_vector (4 downto 0) := "01100";  -- 2 1
constant IPShiftLit 		: std_logic_vector (4 downto 0) := "01101";  -- 2 1 -- Literal : shitf 12 left  the top and fill the 12  first bit with 12 bit of subtop 
-- 01110  free for 32 bits result
constant IPcomp2 			: std_logic_vector (4 downto 0) := "01111";  --  1 1 

-- boolean result bit(4) = 1
constant IPTrue 			: std_logic_vector (4 downto 0) := "10000";  -- 0 1
constant IPFalse 			: std_logic_vector (4 downto 0) := "10001";  -- 0 1
constant IPEqZero 		: std_logic_vector (4 downto 0) := "10010";  -- 1 1
constant IPNeg				: std_logic_vector (4 downto 0) := "10011";  -- 1 1
constant IPand2 		   : std_logic_vector (4 downto 0) := "10100";  -- 2 1
constant IPxor2			: std_logic_vector (4 downto 0) := "10101";  -- 2 1
constant IPEq 				: std_logic_vector (4 downto 0) := "10110";  -- 2 1
constant IPor2 			: std_logic_vector (4 downto 0) := "10111";  -- 2 1
constant IPLeU 			: std_logic_vector (4 downto 0) := "11000";  -- 2 1
constant IPNe 				: std_logic_vector (4 downto 0) := "11001";  -- 2 1
constant IPGt 				: std_logic_vector (4 downto 0) := "11010";  -- 2 1
constant IPLt 				: std_logic_vector (4 downto 0) := "11011";  -- 2 1
constant IPLe 				: std_logic_vector (4 downto 0) := "11100";  -- 2 1
constant IPGe 				: std_logic_vector (4 downto 0) := "11101";  -- 2 1



-- 11110 and 11111 free for boolean result
-- regsiter file
-- 40 4F 
--  register load  40 -- 47   store 48 -- 4F
constant GenM_register : std_logic :='0';
constant GenS_register : std_logic :='0';
constant IPregister :  std_logic_vector (6 downto 0) :="0000100";


-- local ram
--  50 51
constant genM_RAM : std_logic :='0';
constant genS_RAM : std_logic :='0';
constant IPRAM			: std_logic_vector (9 downto 0) :="0000101000";
constant IPREAD			: code := IPME & "0";
constant IPWRITE			: code := IPME & "1";





-- 1F0 1F1 1F2 (1F3 idle  idem a 1F2)
constant GenM_actif : std_logic :='1';
constant GenS_actif : std_logic :='0';
constant IPactif		: std_logic_vector (8 downto 0) := "001111100";	--  
constant IPonx			: code := IPactif & "00";
constant IPony			: code := IPactif & "01";
constant IPonxy			: code := IPactif & "10";
constant IPall			: code := IPactif & "11";

--  1F8 1F9 1FA 1FB  1FE 1FF com 1FC 1FD bcom
constant GenM_com : std_logic :='1';
constant GenS_com : std_logic :='0';
constant IPCom 		: std_logic_vector (7 downto 0) := "00111111";	-- 000 bcomx 001 bcomy  010 comx 011 comy 110 comx- 111 comy-


-- slaves
-- 200
constant GenM_get : std_logic :='0';
constant GenS_get : std_logic :='1';
constant IPGet  : code := "01000000000";
-- 201
constant GenM_put : std_logic :='0';
constant GenS_put : std_logic :='1';
constant IPPut  : code := "01000000001";
-- 202 203 
constant GenM_snum : std_logic :='0';
constant GenS_snum : std_logic :='1';
constant IPSnum  : std_logic_vector (9 downto 0) := "0100000001";  --  0 xnum, 1 ynum
-- 204
constant GenM_sleep : std_logic :='0';
constant GenS_sleep : std_logic :='1';
constant IPsleep  : code := "01000000100";
--  long IP
--401
constant GenM_delay : std_logic :='0';
constant GenS_delay : std_logic :='0';
constant IPdelay 		   : code := "10000000001";  -- 1 0
-- 402
constant GenM_waitbtn : std_logic :='1';
constant GenS_waitbtn : std_logic :='0';
constant IPWaitBtn 		: code := "10000000010";   -- 1 0
-- 403
constant GenM_fibo : std_logic :='1';
constant GenS_fibo : std_logic :='0';
constant IPfibo 		: code := "10000000011";   -- 1 0
-- 5FF
constant GenM_com32 : std_logic :='0';
constant GenS_com32 : std_logic :='0';
constant IPCom32 		: code := "10111111111";	--  long







  
end IPcodes;
