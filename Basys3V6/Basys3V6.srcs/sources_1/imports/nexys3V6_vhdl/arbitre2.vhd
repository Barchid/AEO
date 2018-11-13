--                                                   
-- Description :  static arbiter for interruptions
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity arbitre is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           it1 : in  STD_LOGIC;
           it2 : in  STD_LOGIC;
           it3 : in  STD_LOGIC;
           it4 : in  STD_LOGIC;
           it5 : in  STD_LOGIC;
           it6 : in  STD_LOGIC;
           it7 : in  STD_LOGIC;
           ack1 : out  STD_LOGIC;
           ack2 : out  STD_LOGIC;
           ack3 : out  STD_LOGIC;
           ack4 : out  STD_LOGIC;
           ack5 : out  STD_LOGIC; 
			  ack6 : out  STD_LOGIC;
           ack7 : out STD_LOGIC;  
			  it_homade : out  STD_LOGIC_VECTOR (2 downto 0);
           kernel : in  STD_LOGIC
			  );


end arbitre;

architecture Behavioral of arbitre is
   type state_type is (idle, int1,int2,int3,int4,int5,int6,int7, release); 
   signal state, next_state : state_type; 


   --Declare internal signals for all outputs of the state-machine
   signal it_homade_i : std_logic_vector(2 downto 0);  -- example output signal
	signal ack1_i,ack2_i,ack3_i,ack4_i,ack5_i,ack6_i,ack7_i: std_logic;
   --other outputs
begin 
--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk)
   begin
      if (clk'event and clk = '1') then
         if (reset = '1') then
            state <= idle;
            it_homade <= "000"; 
         else
            state <= next_state;

            ack1 <= ack1_i;
				ack2 <= ack2_i;
				ack3 <= ack3_i;
				ack4 <= ack4_i;
				ack5 <= ack5_i;
				ack6 <= ack6_i;
				ack7 <= ack7_i;
				it_homade <= it_homade_i;
				
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
 

 
   NEXT_STATE_DECODE: process (state,kernel,  it1,it2,it3,it4,it5,it6,it7)

   begin

      next_state <= state;  

		ack1_i<='0';
		ack2_i<='0';
		ack3_i<='0';
		ack4_i<='0';
		ack5_i<='0';
		ack6_i<='0';
		ack7_i<='0';
		it_homade_i <="000";

	     case (state) is	
         when idle =>
           if it1 = '1' then
					if kernel = '1' then
						next_state<= int1;
						ack1_i<='1';
					else
						it_homade_i <= "001";
					end if;
				elsif	it2 = '1' then
					if kernel = '1' then
						next_state<= int2;
						ack2_i<='1';
					else
						it_homade_i <= "010";
					end if;
				elsif	it3 = '1' then
					if kernel = '1' then
						next_state<= int3;
						ack3_i<='1';
					else
						it_homade_i <= "011";
					end if;
				elsif	it4 = '1' then
					if kernel = '1' then
						next_state<= int4;
						ack4_i<='1';
					else
						it_homade_i <= "100";
					end if;
				elsif	it5 = '1' then
					if kernel = '1' then
						next_state<= int5;
						ack5_i<='1';
					else
						it_homade_i <= "101";
					end if;
				elsif	it6 = '1' then
					if kernel = '1' then
						next_state<= int6;
						ack6_i<='1';
					else
						it_homade_i <= "110";
					end if;
				elsif	it7 = '1' then
					if kernel = '1' then
						next_state<= int7;
						ack7_i<='1';
					else
						it_homade_i <= "111";
					end if;
            end if; 
				
			when int1	=>
				if kernel ='0' then 
					if it1='0' then
						next_state <= idle;
					end if;
				else
					ack1_i<='1';
				end if;

			when int2	=>
				if kernel ='0' then  
					if it2='0' then
						next_state <= idle;
					end if;
				else
					ack2_i<='1';
				end if;

			when int3	=>
				if kernel ='0' then  
					if it3='0' then
						next_state <= idle;
					end if;
				else
					ack3_i<='1';
				end if;

			when int4	=>
				if kernel ='0' then  
					if it4='0' then
						next_state <= idle;
					end if;
				else
					ack4_i<='1';
				end if;

			when int5	=>
				if kernel ='0' then  
					if it5='0' then
						next_state <= idle;
					end if;
				else
					ack5_i<='1';
				end if;

			when int6	=>
				if kernel ='0' then  
					if it6='0' then
						next_state <= idle;
					end if;
				else
					ack6_i<='1';
				end if;

			when int7	=>
				if kernel ='0' then  
					if it7='0' then
						next_state <= idle;
					end if;
				else
					ack7_i<='1';
				end if;

          when others =>
            next_state <= idle;
      end case;      
   end process;

end Behavioral;

