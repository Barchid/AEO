library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decode_sequence is
	port (
		reset : in STD_LOGIC;
		clk : in STD_LOGIC;
		led : out STD_LOGIC_VECTOR (1 downto 0);
		seq : in std_logic_vector(7 downto 0);
		code : in STD_LOGIC_VECTOR (1 downto 0);
		magic: in std_logic
	);
end decode_sequence;

architecture Behavioral of decode_sequence is
	type state_type is (DIGIT_0, DIGIT_1, DIGIT_2, DIGIT_3, DIGIT_4);
	signal state, next_state : state_type;
	signal led_i : STD_LOGIC_VECTOR (1 downto 0);
 
begin
	SYNC_PROC : process (clk)
	begin
		if rising_edge(clk) then
			if (reset = '1') then
				state <= DIGIT_0;
				led <= (others => '0');
			else
				state <= next_state;
				led <= led_i;
			end if;
		end if;
	end process;

	OUTPUT_DECODE : process (state)
	begin
		case (state) is
			when DIGIT_0 => 
				led_i <= "00";
			when DIGIT_4 => 
				led_i <= "10";
			when others => 
				led_i <= "01";
		end case;
	end process;

	NEXT_STATE_DECODE : process (state, code, magic)
	begin
        next_state <= state;
		if magic = '1' then
		    next_state <= DIGIT_0;
            case (state) is
                when DIGIT_0 => 
                    if (code = seq(1 downto 0)) then
                        next_state <= DIGIT_1;
                    end if;
                when DIGIT_1 => 
                    if (code = seq(3 downto 2)) then
                        next_state <= DIGIT_2;
                    end if;
                when DIGIT_2 => 
                    if (code = seq(5 downto 4)) then
                        next_state <= DIGIT_3;
                    end if;
                when DIGIT_3 => 
                    if (code = seq(7 downto 6)) then
                        next_state <= DIGIT_4;
                    end if;
                when DIGIT_4 => 
                    next_state <= DIGIT_4;
                when others => 
                    next_state <= DIGIT_0;
            end case;
		end if;
	end process;

end Behavioral;