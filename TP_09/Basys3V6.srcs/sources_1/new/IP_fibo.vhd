library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity IP_fibo is
generic ( mycode : STD_LOGIC_VECTOR (10 downto 0):= "10000000011");
   port ( 
   clk : in  STD_LOGIC;
   reset : in  STD_LOGIC:='0';
   Tin : in  STD_LOGIC_VECTOR (31 downto 0);
   Tout : out  STD_LOGIC_VECTOR (31 downto 0);
   Ipcode : in  STD_LOGIC_VECTOR (10 downto 0); 
   IPdone : out STD_LOGIC);
end IP_fibo;

architecture Behavioral of IP_fibo is
    type state_type is (IDLE, NEXT_FIBO);
    signal state, next_state : state_type;
    signal done: std_logic;
    signal compteur: std_logic_vector(7 downto 0);
    signal compteur_i: std_logic_vector(7 downto 0);
    signal fibobus  : STD_LOGIC_VECTOR (31 downto 0);
    signal init: std_logic;
    
    
    -- component
    component fibogen
       Port ( 
           clk      : in  STD_LOGIC;
           init     : in  STD_LOGIC;
           fiboout  : out STD_LOGIC_VECTOR (31 downto 0)
       );    
    end component;
begin

    inst_fibogen : fibogen
    PORT MAP(
            clk => clk,
            init => init,
            fiboout => fibobus
     );
   
   SYNC_PROC: process (clk)
   begin
      if (rising_edge(clk)) then
         if (reset = '1') then
            compteur <= x"00";
            state <= IDLE;
         else
            compteur <= compteur_i;
            state <= next_state;
         end if;
      end if;
   end process;


   OUTPUT_DECODE: process (state, compteur)
   begin
      if state = IDLE then
         init <= '1';
         compteur_i <= Tin(7 downto 0);
      else
         init <= '0';
         compteur_i <= compteur - x"01";
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, Ipcode, compteur)
   begin
      done <= '0';
      next_state <= state;
      case (state) is
         when IDLE =>
            if Ipcode = mycode then
               next_state <= NEXT_FIBO;
            end if;
         when NEXT_FIBO =>
            if compteur = 3 then
               next_state <= IDLE;
               done <= '1';
            end if;
         end case;
   end process;
   
   Tout <= fibobus when done = '1' else (others => 'Z');

end Behavioral;