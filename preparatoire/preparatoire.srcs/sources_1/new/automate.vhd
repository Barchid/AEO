library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity automate is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           e190: in std_logic;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (3 downto 0);
           reset : in STD_LOGIC);
end automate;

architecture Behavioral of automate is
    type state_type is (DIGIT1, DIGIT2, DIGIT3, DIGIT4);
    signal state, next_state : state_type;
    signal data_i : std_logic_vector(3 downto 0);
    signal an_i : std_logic_vector(3 downto 0);
begin

--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk)
   begin
      if rising_edge(clk) then
         if (reset = '1') then
            state <= DIGIT1;
            data <= sw(3 downto 0);
            an <= "1110";
         else
            state <= next_state;
            an <= an_i;
            data <= data_i;
         end if;
      end if;
   end process;

   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      case state is
        when DIGIT1 =>
            data_i <= sw(3 downto 0);
            an_i <= "1110";
        when DIGIT2 =>
            data_i <= sw(7 downto 4);
            an_i <= "1101";
        when DIGIT3 =>
            data_i <= sw(11 downto 8);
            an_i <= "1011";
        when others =>
            data_i <= sw(15 downto 12);
            an_i <= "0111";
      end case;
   end process;

   NEXT_STATE_DECODE: process (state, e190)
   begin
      next_state <= state;
      if e190 = '1' then
        case (state) is
           when DIGIT1 =>
              next_state <= DIGIT2;
           when DIGIT2 =>
              next_state <= DIGIT3;
           when DIGIT3 =>
              next_state <= DIGIT4;
           when others => -- digit 4
              next_state <= DIGIT1;
        end case;
      end if;
   end process;
end Behavioral;
