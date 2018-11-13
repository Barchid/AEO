library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity toplevel is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC);
end toplevel;

architecture Behavioral of toplevel is

-- components
component clkdiv
Port ( clk : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       E190, clk190 : out  STD_LOGIC);
end component;

component x7seg
Port ( mot : in STD_LOGIC_VECTOR (3 downto 0);
       seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component automate
Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
      clk : in STD_LOGIC;
      e190: in std_logic;
      an : out STD_LOGIC_VECTOR (3 downto 0);
      data : out STD_LOGIC_VECTOR (3 downto 0);
      reset : in STD_LOGIC);
end component;

-- signals
signal clk190 : std_logic;
signal E190: std_logic;
signal sevenseg: std_logic_vector(3 downto 0);
begin

inst_clkdiv: clkdiv port map (
    clk => clk,
    reset => '0',
    clk190 => clk190,
    E190 => E190
);

inst_automate: automate port map(
    sw => sw,
    clk => clk190,
    e190 => E190,
    an => an,
    data => sevenseg,
    reset => '0'
);

inst_x7seg: x7seg port map (
    mot => sevenseg,
    seg => seg
);

end Behavioral;
