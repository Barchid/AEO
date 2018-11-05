library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shift_vector is
	port (
		sw : in STD_LOGIC_VECTOR (15 downto 0);
		clk : in STD_LOGIC;
		led : out STD_LOGIC_VECTOR (15 downto 0)
	);
end shift_vector;

architecture Behavioral of shift_vector is
	signal temp : std_logic_vector(15 downto 0) := "0000000000000001";
	signal sDirection : std_logic := '0';
begin
	process (clk)
	variable tmp : std_logic;
	variable vDirection : std_logic := '0';
	begin
		if rising_edge(clk) then
			vDirection := sDirection;
 
			if temp(0) = '1' or temp(15) = '1' then
				vDirection := not vDirection;
			else
                if (sw(15 downto 0) and temp(15 downto 0)) = temp then
                    vDirection := not vDirection;
                end if;
			end if;

			if vDirection = '1' then
				tmp := temp(15);
				temp(15 downto 1) <= temp(14 downto 0);
				temp(0) <= tmp;
			else
				tmp := temp(0);
				temp(14 downto 0) <= temp(15 downto 1);
				temp(15) <= tmp;
			end if;
		end if;
		sDirection <= vDirection;
	end process;

	led <= temp;
 
end Behavioral;