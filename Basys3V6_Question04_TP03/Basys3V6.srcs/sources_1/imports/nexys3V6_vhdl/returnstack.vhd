--                                                   
-- Description :  Return Stack  for call
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
use IEEE.STD_LOGIC_unsigned.all;

entity rstack is
    Port ( clk  : in  STD_LOGIC;
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
           data_in : in  STD_LOGIC_VECTOR (31 downto 0);
           data_out : out  STD_LOGIC_VECTOR (31 downto 0);
           clr : in  STD_LOGIC);
			  	attribute clock_signal : string;
	attribute clock_signal of clk : signal is "yes";
end rstack;

architecture Behavioral of rstack is
  type ram_type is array (15 downto 0)of std_logic_vector (31 downto 0);
  signal RAM : ram_type;
  signal dout : STD_LOGIC_VECTOR (31 downto 0);
  signal stack_ptr : std_logic_vector (3 downto 0 ) := "1111";
  	attribute KEEP : string;
	attribute KEEP of RAM : signal is "yes";
	attribute KEEP of dout : signal is "yes";
begin                                                      


process (clk,clr, push,ram,stack_ptr)

begin 


if(clk'event and clk='0') then 

if clr='1' then 
	stack_ptr<= "1111";


	elsif push = '1' then
		RAM(conv_integer(stack_ptr)) <=data_in;
		if stack_ptr/= "0000" then
			stack_ptr <= stack_ptr - 1;
		end if;
	end if;
	if pop = '1' then
		if stack_ptr/= "1111" then
			stack_ptr<= stack_ptr + 1;
			
		end if;
	end if;
end if;
end process;




process (clk,stack_ptr,ram)
begin
	if stack_ptr /= "1111" then 
		data_out <= RAM(conv_integer(stack_ptr) +1);
	else 
		data_out <= RAM(conv_integer(stack_ptr));
	end if;


	
end process;


end Behavioral;

