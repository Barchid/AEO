--                                                   
-- Description :  IP active wait n cycles
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
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;



entity IP_delay is
		GENERIC (Mycode : std_logic_vector(10 downto 0) :="00000000110");
    Port ( Tin : in  STD_LOGIC_VECTOR (31 downto 0);
           IPcode : in  STD_LOGIC_vector (10 downto 0);
				clk : in STD_LOGIC;
           IPdone : out  STD_LOGIC);
	attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end IP_delay;


architecture FSM of IP_delay is
--
--    -- define the states of FSM model
-- signal action,rst, cp_zero,IPd: STD_LOGIC:='0';
 signal  IPd : std_logic;
 signal cptr_d,cptr_next : std_logic_vector (31 downto 0);
--
--
 
    -- define the states of FSM model

    type state_type is (idle, starting, finish);
    signal next_state, current_statew: state_type:= idle;
begin 

-- cocurrent process#1: state registers
state_reg: process(clk)
    begin
	 if (clk'event and clk='1') then
			current_statew <= next_state; 
			IPdone<=IPd;
			cptr_d <= cptr_next;
	 end if;
    end process;        

    -- cocurrent process#2: combinational logic
comb_logic: process( Ipcode,current_statew,cptr_d)
    begin

 -- use case statement to show the 
 -- state transistion
IPd<='0';
cptr_next <= cptr_d;
 case current_statew is
     when idle => 
			if Ipcode =  Mycode then
				cptr_next <= Tin-5;
				next_state <= starting;
			else
				next_state <= idle;
			end if;
     when starting =>
			if cptr_d(31)='1'  then
				next_state <= finish;
			else 
				next_state <= starting;  
				cptr_next <= cptr_d - x"00000001"; 
			end if; 
     when finish => 
			IPd  <= '1';  
			next_state <= idle;
     when others =>  
			next_state <= idle;
 end case;

    end process;

end FSM;

----------------------------
