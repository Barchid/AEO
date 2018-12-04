--                                                   
-- Description : protocole UART 
-- 
-- ----------------------------------------------------------------------------------
-- Copyright : UNIVERSITE DE LILLE 1 - INRIA Lille Nord de France
--  Villeneuve d'Accsq France
-- 
-- Module Name  : Nexys3v6
-- Project Name : Homade V6
-- Revision :     IPcore timer
--                                         
-- Target Device :     spartan 6 spartan 3 virtex 7
-- Tool Version : tested on ISE 12.4,/14.7

-- Contributor(s) :
-- Dekeyser Jean-Luc ( Creation  juin 2012) jean-luc.dekeyser@univ_lille1.fr
-- 
-- 
-- Cecil Licence:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_Logic_1164.ALL;
use IEEE.std_Logic_UNSIGNED.ALL;
use IEEE.std_Logic_ARITH.ALL;


entity uart_rx is
    Port ( 		
			rx_reg        :out std_logic_vector( 7 downto 0);
			rx_ok : out  std_logic;
			rx_in        :in  std_logic;
	
			rxclk ,hclk    : in     STD_LOGIC
			  );
attribute clock_signal : string;
attribute clock_signal of rxclk : signal is "yes";

end uart_rx;

architecture inst_rx of uart_rx is
--===================================================================
    signal rx_sample_cnt  :std_logic_vector (3 downto 0);
    signal rx_cnt        :std_logic_vector (3 downto 0):= "0000";
    signal rx_d1          :std_logic:='1';
    signal rx_d2          :std_logic:='1';
    signal rx_busy , shiftE, shiftep :std_logic:='0';
	 signal rx_reg_inv : std_logic_vector(7 downto 0);
--=================================================================== 
--  COMPONENT shitfreg8
--   PORT( D	:	IN	STD_LOGIC; 
--          CE	:	IN	STD_LOGIC; 
--          clk	:	IN	STD_LOGIC; 
--          Q	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0));
--   END COMPONENT;
	component mySR8CE 
port (
    Q   : out STD_LOGIC_VECTOR(7 downto 0);
    C   : in STD_LOGIC;
    CE  : in STD_LOGIC;
    CLR : in STD_LOGIC;
    SLI : in STD_LOGIC
    );
end component;
  COMPONENT pulse
     PORT( clk : IN STD_LOGIC; 
          inp : IN STD_LOGIC; 
          outp : OUT STD_LOGIC);
   END COMPONENT;

begin
--=====================================================================================

   buf8: mySR8CE PORT MAP(
		SLI => rx_d2, 
		CE => shiftEp, 
		c => hclk, 
		clr=>'0', 
		Q => rx_reg_inv
   );
							
pulse_shift: pulse PORT MAP(
  clk => Hclk, 
  inp => shiftE, 
  outp => shiftep
   );
	
rx_reg(0)<= rx_reg_inv(7);
rx_reg(1)<= rx_reg_inv(6);
rx_reg(2)<= rx_reg_inv(5);
rx_reg(3)<= rx_reg_inv(4);
rx_reg(4)<= rx_reg_inv(3);
rx_reg(5)<= rx_reg_inv(2);
rx_reg(6)<= rx_reg_inv(1);
rx_reg(7)<= rx_reg_inv(0);

	
--=====================================================================================
    -- UART RX Logic
    process (rxclk) 
	 begin
			if (rising_edge(rxclk)) then
            -- Synchronize the asynch signal
            rx_d1 <= rx_in;
            rx_d2 <= rx_d1;
				rx_ok <= '0';
				shiftE<='0';
            -- Uload the rx data

            -- Receive data only when rx is enabled
                -- Check if just received start of frame
                if (rx_busy = '0' and rx_d2 = '0') then
                    rx_busy       <= '1';
                    rx_sample_cnt <= X"1";
                    rx_cnt        <= X"0";
                end if;
                -- Start of frame detected, Proceed with rest of data
                if (rx_busy = '1') then
                    rx_sample_cnt <= rx_sample_cnt + 1;
                    -- Logic to sample at middle of data
                    if (rx_sample_cnt = 7 ) then
                        if ((rx_d2 = '1') and (rx_cnt = 0)) then
                            rx_busy <= '0';
                        else
                            rx_cnt <= rx_cnt + 1;
                            -- Start storing the rx data
									shiftE <= (( not rx_cnt(3) and (rx_cnt(2) or  rx_cnt(1) or  rx_cnt(0))) or  (rx_cnt(3)) );
									if rx_cnt(3)='1' and rx_cnt(0)='1'		 then
										rx_ok <= '1';
                              rx_busy <= '0';
										rx_cnt  <= X"0";
                             -- Check if End of frame received correctly
                                
                           end if;
                        end if;
                    end if;
					end if;
			end if;
    end process;
--====================================================================================================================
end inst_rx;
