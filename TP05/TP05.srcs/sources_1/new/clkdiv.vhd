library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
entity clkdiv is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           E190, clk190 : out  STD_LOGIC);
end clkdiv;

architecture clkdiv of clkdiv is
signal clkin: std_logic :='0';
begin
    --clock divider
    process(clk,reset)
    variable q: std_logic_vector(23 downto 0):= X"000000";
    begin   
        if reset ='1' then
            q := X"000000";
            clkin <= '0';
        elsif clk'event and clk = '1' then
            q := q+1;
            if Q(18)='1' and clkin='0' then 
		E190 <= '1' ;
	    else 
	        E190 <= '0';
	    end if;
        end if;
        clkin<= Q(18);
    end process;
    clk190 <= clkin;
end clkdiv;