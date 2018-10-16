library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           clk: in std_logic;
           btn : in STD_LOGIC_VECTOR (4 downto 0));
end decoder;

architecture Behavioral of decoder is

--signals
signal code: std_logic_vector(1 downto 0);
signal clk190: std_logic;
signal E190: std_logic;
signal pulses: std_logic_vector(4 downto 0);
signal magic: std_logic;

-- components
component decode_sequence
  port (
    reset: in STD_LOGIC;
    clk: in std_logic;
    led: out STD_LOGIC_VECTOR(1 downto 0);
    seq: in std_logic_vector(7 downto 0);
    code : in STD_LOGIC_VECTOR (1 downto 0);
    magic: in std_logic
  );
end component;

component btnToCode
    Port ( btn : in STD_LOGIC_VECTOR (3 downto 0);
       code : out STD_LOGIC_VECTOR (1 downto 0);
       magic: out std_logic
   );
end component;

component clkdiv
    Port ( 
        clk : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        E190, clk190 : out  STD_LOGIC);
end component;

component btn_pulse
    Port ( 
        btn : in std_logic;
        clk : in std_logic;
        enable: in std_logic;
        pulse : out std_logic
   );
end component;

begin

inst_clkdiv : clkdiv port map(
    clk => clk,
    reset => '0',
    E190 => E190,
    clk190 => clk190
);

inst_btns_pulses :
   for i in 0 to 4 generate
    begin 
        inst_btn_pulse : btn_pulse port map(
            btn => btn(i),
            clk => clk190,
            enable => E190,
            pulse => pulses(i)
        );
   end generate inst_btns_pulses;

inst_btnToCode: btnToCode port map (
    btn => pulses(3 downto 0),
    code => code,
    magic => magic
);

inst_decode_sequence: decode_sequence port map(
    reset => pulses(4),
    clk => clk190,
    led => led(1 downto 0),
    seq => sw(7 downto 0),
    code => code,
    magic => magic
);

end Behavioral;
