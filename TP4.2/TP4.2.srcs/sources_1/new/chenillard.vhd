library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity chenillard is
	port (
		sw : in std_logic_vector(15 downto 0);
		clk : in STD_LOGIC;
		led : out STD_LOGIC_VECTOR (15 downto 0)
	);
end chenillard;

architecture Behavioral of chenillard is

	component shift_vector
		port (
			sw : in STD_LOGIC_VECTOR (15 downto 0);
			clk : in STD_LOGIC;
			led : out STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;

	component clk_div
		port (
			clk : in STD_LOGIC;
			clk_4hz : out STD_LOGIC
		);
	end component;

	signal clk_4hz : std_logic;

begin
	inst_clk_div : clk_div
	port map(
		clk => clk, 
		clk_4hz => clk_4hz
	);

	inst_shift_vector : shift_vector
	port map(
		sw => sw, 
		clk => clk_4hz, 
		led => led
	);

end Behavioral;