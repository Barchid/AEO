library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity btn_pulse is
    Port ( btn : in std_logic;
           clk : in std_logic;
           enable: in std_logic;
           pulse : out std_logic
   );
end btn_pulse;

architecture Behavioral of btn_pulse is
signal q0,q1,q2,q3,q4,q5  : std_logic;
begin
process(clk)

begin
    if rising_edge(clk) then
    
        if (enable = '1') then
            q0 <= btn;
            q1 <= q0;
            q2 <= q1;
        end if;
        
        q3 <= q0 and q1 and q2;
        q4 <= q3;
        q5 <= q4;
    end if;
    
     pulse <= q3 and q4 and (not q5);
end process;

end Behavioral;
