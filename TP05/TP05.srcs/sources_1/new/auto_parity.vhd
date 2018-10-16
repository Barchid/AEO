library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity auto_parity is
port(
    clk: in std_logic;
    reset: in std_logic;
    x: in std_logic;
    isEven: out std_logic
);
end auto_parity;

architecture Behavioral of auto_parity is
type state_type is (EVEN, ODD);
    signal state, next_state : state_type;
    signal isEven_i : std_logic; -- la dessus qu'on travaille, signal interne
                                -- On sait à quel moment on synchronise
                                --les sorties _i deviennent les sorties quand clock front montant
begin 

-- Process qui synchronise (pas obligé de faire un reset)
SYNC_PROC : process (clk)
begin
if rising_edge(clk) then
    if (reset = '1') then -- si reset, on dit quel est l'état par lequel je commence 
                            -- (par défaut, c'est le premier état qu'on déclare)
        state <= EVEN;
        isEven <= '0';
    else -- Pas sur un reset
        state <= next_state;
        isEven <= isEven_i; --la sortie devient la sortie que j'ai calculé, ça se passe sur un front montant tjrs
    end if;
end if;
end process; 

-- Process qui décode l'output basé sur le state (moore)
-- On regarde mes sorties
-- TESTER TOUS LES CAS POSSIBLES SINON LATCH
-- INDISPENSABLE
OUTPUT_DECODE : process (state)
    begin
    case (state) is
        when EVEN =>
            isEven_i <= '1';
        when ODD =>
            isEven_i <= '0';
        when others =>
            isEven_i <= '0';
    end case;
end process;

-- Process qui calcule le prochain transfert (décoder le prochain état)
-- Dit ce qu'on fait en vrai
-- Synchrone sur les entrées et les états
-- On sépare en trois trucs
NEXT_STATE_DECODE : process (state, x)
begin
    next_state <= EVEN; --comme ça on est sur qu'il n'y aura pas de LATCH
    case (state) is
        when EVEN =>
            if (x = '1') then
                next_state <= ODD;
            end if;
        when ODD =>
            if (x = '0') then
                next_state <= ODD;
        end if;
        when others =>
            next_state <= EVEN;
    end case;
end process;

end Behavioral;
