--                                                   
-- Description :  create 64 bits word from 8 x 8 bits
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_dispatch is
    Port ( 		
			rx8        :in std_logic_vector( 7 downto 0);
			rxe : in  std_logic;
			data_m, data_s: out std_logic;
			e_m, e_s : out std_logic;
			start : out std_logic;
			clk   : in     STD_LOGIC
			  );
attribute clock_signal : string;
attribute clock_signal of clk : signal is "yes";

end uart_dispatch;

architecture Behavioral of uart_dispatch is
signal buf64 : std_logic_vector (63 downto 0);
signal buf64e: std_logic := '0';
signal nextbit,nextbit_i : std_logic_vector(6  downto 0):="0000000";
signal ldnb, ldmot, resetmot : std_logic:='0';
signal  sizecode, nbmot, nbmot_i: std_logic_vector(31 downto 0);

type StateType is (master,hmd, hmd64, slave, shmd, shmd64, fin);
signal current_state, next_state: StateType:= master;

	COMPONENT reg1
	PORT(
		load : IN std_logic;
		d : IN std_logic_vector(31 downto 0);
		clk : IN std_logic;
		clr : IN std_logic;          
		q : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin


process (clk) 
variable count : std_logic_vector (2 downto 0):= "000";

begin
if rising_edge(clk) then
		buf64e<='0';
		if rxe='1' then 
		case count  is
			when "111" => buf64(7 downto 0)   <= rx8;
							  buf64e<= '1';
			when "110" => buf64(15 downto 8)  <= rx8;
			when "101" => buf64(23 downto 16) <= rx8;
			when "100" => buf64(31 downto 24) <= rx8;
			when "011" => buf64(39 downto 32) <= rx8;	
			when "010" => buf64(47 downto 40) <= rx8;
			when "001" => buf64(55 downto 48) <= rx8;
			when "000" => buf64(63 downto 56) <= rx8;

			when others =>
		 end case;
		 count := count + 1 ;
	end if;
end if;
end process;

process (clk)
begin
	if rising_edge(clk) then
		current_state<=next_state;
		nextbit <= nextbit_i;
	end if;
end process;
	
process( current_state, buf64e, nextbit)




begin


	e_m<= '0';
	data_m<='0';
	e_s<= '0';
	data_s<='0';
--	ldnb  <= '0';
	start <='0';
	nextbit_i<= nextbit;
--	nbmot_i<= nbmot+4;
--	ldmot <= '0';
--	resetmot<='0';
	
	case current_state is
		when master =>

			if buf64e ='1' then 
--				ldnb<= '1';
				next_state <= hmd;
				nextbit_i <="0000000";
--				resetmot<='1';
			else  
				next_state <= master;
			end if;
		when hmd =>
			if buf64(63 downto 48) /= x"ffff" then 
				nextbit_i <="0000000";
--				ldmot<='1';
				next_state <= hmd64;
			else
				next_state <= slave;
			end if;
		when hmd64 =>
			if nextbit(6) ='0' then
				data_m<= buf64(conv_integer(nextbit));
				e_m<= '1';
				nextbit_i <= nextbit +1;
				next_state <= hmd64;
			else 
				next_state <= master;
			end if;
				
		when slave=>
			if buf64e ='1' and buf64(63 downto 48) /= x"ffff"then 
--			ldnb<= '1';
				next_state <= shmd64;
				nextbit_i <="0000000";
--				resetmot<='1';
			else
				if buf64e /= '1' then
					next_state <= slave;
				else
					next_state <= fin;
				end if;
			end if;
--		when shmd=>
----				if nbmot = sizecode then
----					next_state <= fin;
----				else 
--					if buf64e = '1'  then 
--						nextbit_i <="0000000";
----						ldmot<='1';
--						next_state <= shmd64;
--					else
--						next_state <= shmd;
--					end if;			
----				end if;
		when shmd64 =>
			if nextbit(6) ='0' then
				data_s<= buf64(conv_integer(nextbit));
				e_s<= '1';
				nextbit_i <= nextbit +1;
				next_state<= shmd64;
			else 
					next_state <= slave;
			end if;
		when fin=> 
			if buf64e ='1' then 
--				ldnb<= '1';
				next_state <= hmd;
				nextbit_i <="0000000";
--				resetmot<='1';
			else  
				start <= '1';
				next_state<= fin;
			end if;
				
		when others =>
			next_state <= master;
	end case;
end process;

end Behavioral;

