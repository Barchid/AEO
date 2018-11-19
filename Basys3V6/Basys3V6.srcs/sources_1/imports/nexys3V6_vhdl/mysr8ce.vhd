-------------------------------------------------------------------------------
-- Copyright (c) 2006 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor      : Xilinx
-- \   \   \/     Version     : J.23
--  \   \         Description : Xilinx HDL Macro Library
--  /   /                       8-Bit Serial-In Parallel-Out Shift Register with Clock Enable and Asynchronous Clear
-- /___/   /\     Filename    : SR8CE.vhd
-- \   \  /  \    Timestamp   : Fri Jul 21 2006
--  \___\/\___\
--
-- Revision:
-- 07/21/06 - Initial version.
-- End Revision

----- CELL SR8CE -----


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mySR8CE is
port (
    Q   : out STD_LOGIC_VECTOR(7 downto 0);
    C   : in STD_LOGIC;
    CE  : in STD_LOGIC;
    CLR : in STD_LOGIC;
    SLI : in STD_LOGIC
    );
end mySR8CE;

architecture Behavioral of mySR8CE is
signal q_tmp : std_logic_vector(7 downto 0);
begin

process(C, CLR)
begin
  if (CLR='1') then
    q_tmp <= (others => '0');
  elsif (C'event and C = '1') then
    if (CE='1') then 
      q_tmp <= ( q_tmp(6 downto 0) & SLI );
    end if;
  end if;
end process;

Q <= q_tmp;


end Behavioral;

