----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:29:19 01/03/2017 
-- Design Name: 
-- Module Name:    Hstack - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


entity Hstack is
   port ( clk       : in    std_logic; 
          ipdone    : in    std_logic; 
          Lit       : in    std_logic_vector (11 downto 0); 
          Litload   : in    std_logic; 
          Nin       : in    std_logic_vector (31 downto 0); 
          N2in      : in    std_logic_vector (31 downto 0); 
          reset     : in    std_logic; 
          shortIP   : in    std_logic; 
          Tin       : in    std_logic_vector (31 downto 0); 
          X         : in    std_logic_vector (1 downto 0); 
          Y         : in    std_logic_vector (1 downto 0); 
          Nout      : out   std_logic_vector (31 downto 0); 
          N2out     : out   std_logic_vector (31 downto 0); 
          offset    : out   std_logic; 
          oversized : out   std_logic_vector (31 downto 0); 
          Tout      : out   std_logic_vector (31 downto 0));
   attribute clock_signal : string ;
   attribute clock_signal of clk : signal is "yes";
end Hstack;

architecture BEHAVIORAL of Hstack is
   attribute BOX_TYPE   : string ;
   signal adr0         : std_logic_vector (3 downto 0);
   signal adr1         : std_logic_vector (3 downto 0);
   signal adr2         : std_logic_vector (3 downto 0);
   signal adr3         : std_logic_vector (3 downto 0);
   signal count        : std_logic_vector (7 downto 0);
   signal lastcycle    : std_logic;
   signal literal32    : std_logic_vector (31 downto 0);
   signal mux0S        : std_logic_vector (31 downto 0);
   signal mux1S        : std_logic_vector (31 downto 0);
   signal mux2S        : std_logic_vector (31 downto 0);
   signal mux3S        : std_logic_vector (31 downto 0);
   signal ram0S        : std_logic_vector (31 downto 0);
   signal ram1S        : std_logic_vector (31 downto 0);
   signal ram2S        : std_logic_vector (31 downto 0);
   signal ram3S        : std_logic_vector (31 downto 0);
   signal R0enable     : std_logic;
   signal R0in         : std_logic_vector (31 downto 0);
   signal R0out        : std_logic_vector (31 downto 0);
   signal R1enable     : std_logic;
   signal R1in         : std_logic_vector (31 downto 0);
   signal R1out        : std_logic_vector (31 downto 0);
   signal R2enable     : std_logic;
   signal R2in         : std_logic_vector (31 downto 0);
   signal R2out        : std_logic_vector (31 downto 0);
   signal R3enable     : std_logic;
   signal R3in         : std_logic_vector (31 downto 0);
   signal R3out        : std_logic_vector (31 downto 0);
   signal selin0       : std_logic_vector (1 downto 0);
   signal selin1       : std_logic_vector (1 downto 0);
   signal selin2       : std_logic_vector (1 downto 0);
   signal selin3       : std_logic_vector (1 downto 0);
   signal selNout      : std_logic_vector (1 downto 0);
   signal selN2out     : std_logic_vector (1 downto 0);
   signal selOversized : std_logic_vector (1 downto 0);
   signal selreg0      : std_logic_vector (1 downto 0);
   signal selreg1      : std_logic_vector (1 downto 0);
   signal selreg2      : std_logic_vector (1 downto 0);
   signal selreg3      : std_logic_vector (1 downto 0);
   signal selTout      : std_logic_vector (1 downto 0);
   signal we0          : std_logic;
   signal we1          : std_logic;
   signal we2          : std_logic;
   signal we3          : std_logic;
   signal Tout_DUMMY   : std_logic_vector (31 downto 0);
   component constant32
      port ( value   : in    std_logic_vector (11 downto 0); 
             value32 : out   std_logic_vector (31 downto 0));
   end component;
   
   component Mux4
      port ( X0  : in    std_logic_vector (31 downto 0); 
             X1  : in    std_logic_vector (31 downto 0); 
             X2  : in    std_logic_vector (31 downto 0); 
             X3  : in    std_logic_vector (31 downto 0); 
             sel : in    std_logic_vector (1 downto 0); 
             Y   : out   std_logic_vector (31 downto 0));
   end component;
   
   component Mux2
      port ( sel : in    std_logic; 
             X0  : in    std_logic_vector (31 downto 0); 
             X1  : in    std_logic_vector (31 downto 0); 
             Y   : out   std_logic_vector (31 downto 0));
   end component;
   
   component predicat
      port ( tin      : in    std_logic_vector (31 downto 0); 
             predicat : out   std_logic);
   end component;
   
   component Ram8
      port ( clk     : in    std_logic; 
             we      : in    std_logic; 
             addr    : in    std_logic_vector (3 downto 0); 
             datain  : in    std_logic_vector (31 downto 0); 
             dataout : out   std_logic_vector (31 downto 0));
   end component;
   
   component QDE
      port ( E   : in    std_logic; 
             clk : in    std_logic; 
             d   : in    std_logic_vector (31 downto 0); 
             q   : out   std_logic_vector (31 downto 0));
   end component;
   
   component select_in
      port ( Lastcycle : in    std_logic; 
             litload   : in    std_logic; 
             count     : in    std_logic_vector (7 downto 0); 
             X         : in    std_logic_vector (1 downto 0); 
             Y         : in    std_logic_vector (1 downto 0); 
             we0       : out   std_logic; 
             we1       : out   std_logic; 
             we2       : out   std_logic; 
             we3       : out   std_logic; 
             adr0      : out   std_logic_vector (3 downto 0); 
             adr1      : out   std_logic_vector (3 downto 0); 
             adr2      : out   std_logic_vector (3 downto 0); 
             adr3      : out   std_logic_vector (3 downto 0); 
             selin0    : out   std_logic_vector (1 downto 0); 
             selin1    : out   std_logic_vector (1 downto 0); 
             selin2    : out   std_logic_vector (1 downto 0); 
             selin3    : out   std_logic_vector (1 downto 0); 
             selreg0   : out   std_logic_vector (1 downto 0); 
             selreg1   : out   std_logic_vector (1 downto 0); 
             selreg2   : out   std_logic_vector (1 downto 0); 
             selreg3   : out   std_logic_vector (1 downto 0));
   end component;
   
   component select_out
      port ( count    : in    std_logic_vector (1 downto 0); 
             selTout  : out   std_logic_vector (1 downto 0); 
             selNout  : out   std_logic_vector (1 downto 0); 
             selN2out : out   std_logic_vector (1 downto 0); 
             seloverS : out   std_logic_vector (1 downto 0));
   end component;
   
   component next_count
      port ( lastcycle : in    std_logic; 
             clk       : in    std_logic; 
             count_in  : in    std_logic_vector (7 downto 0); 
             X         : in    std_logic_vector (1 downto 0); 
             Y         : in    std_logic_vector (1 downto 0); 
             count_out : out   std_logic_vector (7 downto 0); 
             reset     : in    std_logic);
   end component;
   
   
begin
   Tout(31 downto 0) <= Tout_DUMMY(31 downto 0);
   constlit : constant32
      port map (value(11 downto 0)=>Lit(11 downto 0),
                value32(31 downto 0)=>literal32(31 downto 0));
   
   muxi0 : Mux4
      port map (sel(1 downto 0)=>selin0(1 downto 0),
                X0(31 downto 0)=>Tin(31 downto 0),
                X1(31 downto 0)=>Nin(31 downto 0),
                X2(31 downto 0)=>N2in(31 downto 0),
                X3(31 downto 0)=>literal32(31 downto 0),
                Y(31 downto 0)=>mux0S(31 downto 0));
   
   muxi1 : Mux4
      port map (sel(1 downto 0)=>selin1(1 downto 0),
                X0(31 downto 0)=>Tin(31 downto 0),
                X1(31 downto 0)=>Nin(31 downto 0),
                X2(31 downto 0)=>N2in(31 downto 0),
                X3(31 downto 0)=>literal32(31 downto 0),
                Y(31 downto 0)=>mux1S(31 downto 0));
   
   muxi2 : Mux4
      port map (sel(1 downto 0)=>selin2(1 downto 0),
                X0(31 downto 0)=>Tin(31 downto 0),
                X1(31 downto 0)=>Nin(31 downto 0),
                X2(31 downto 0)=>N2in(31 downto 0),
                X3(31 downto 0)=>literal32(31 downto 0),
                Y(31 downto 0)=>mux2S(31 downto 0));
   
   muxi3 : Mux4
      port map (sel(1 downto 0)=>selin3(1 downto 0),
                X0(31 downto 0)=>Tin(31 downto 0),
                X1(31 downto 0)=>Nin(31 downto 0),
                X2(31 downto 0)=>N2in(31 downto 0),
                X3(31 downto 0)=>literal32(31 downto 0),
                Y(31 downto 0)=>mux3S(31 downto 0));
   
   muxoutN : Mux4
      port map (sel(1 downto 0)=>selNout(1 downto 0),
                X0(31 downto 0)=>R0out(31 downto 0),
                X1(31 downto 0)=>R1out(31 downto 0),
                X2(31 downto 0)=>R2out(31 downto 0),
                X3(31 downto 0)=>R3out(31 downto 0),
                Y(31 downto 0)=>Nout(31 downto 0));
   
   muxoutN2 : Mux4
      port map (sel(1 downto 0)=>selN2out(1 downto 0),
                X0(31 downto 0)=>R0out(31 downto 0),
                X1(31 downto 0)=>R1out(31 downto 0),
                X2(31 downto 0)=>R2out(31 downto 0),
                X3(31 downto 0)=>R3out(31 downto 0),
                Y(31 downto 0)=>N2out(31 downto 0));
   
   muxOutOversized : Mux4
      port map (sel(1 downto 0)=>selOversized(1 downto 0),
                X0(31 downto 0)=>R0out(31 downto 0),
                X1(31 downto 0)=>R1out(31 downto 0),
                X2(31 downto 0)=>R2out(31 downto 0),
                X3(31 downto 0)=>R3out(31 downto 0),
                Y(31 downto 0)=>oversized(31 downto 0));
   
   muxoutT : Mux4
      port map (sel(1 downto 0)=>selTout(1 downto 0),
                X0(31 downto 0)=>R0out(31 downto 0),
                X1(31 downto 0)=>R1out(31 downto 0),
                X2(31 downto 0)=>R2out(31 downto 0),
                X3(31 downto 0)=>R3out(31 downto 0),
                Y(31 downto 0)=>Tout_DUMMY(31 downto 0));
   
   muxR0 : Mux2
      port map (sel=>selreg0(1),
                X0(31 downto 0)=>mux0S(31 downto 0),
                X1(31 downto 0)=>ram0S(31 downto 0),
                Y(31 downto 0)=>R0in(31 downto 0));
   
   muxR1 : Mux2
      port map (sel=>selreg1(1),
                X0(31 downto 0)=>mux1S(31 downto 0),
                X1(31 downto 0)=>ram1S(31 downto 0),
                Y(31 downto 0)=>R1in(31 downto 0));
   
   muxR2 : Mux2
      port map (sel=>selreg2(1),
                X0(31 downto 0)=>mux2S(31 downto 0),
                X1(31 downto 0)=>ram2S(31 downto 0),
                Y(31 downto 0)=>R2in(31 downto 0));
   
   muxR3 : Mux2
      port map (sel=>selreg3(1),
                X0(31 downto 0)=>mux3S(31 downto 0),
                X1(31 downto 0)=>ram3S(31 downto 0),
                Y(31 downto 0)=>R3in(31 downto 0));
   
   pred : predicat
      port map (tin(31 downto 0)=>Tout_DUMMY(31 downto 0),
                predicat=>offset);
   
   ram0 : Ram8
      port map (addr(3 downto 0)=>adr0(3 downto 0),
                clk=>clk,
                datain(31 downto 0)=>mux0S(31 downto 0),
                we=>we0,
                dataout(31 downto 0)=>ram0S(31 downto 0));
   
   ram1 : Ram8
      port map (addr(3 downto 0)=>adr1(3 downto 0),
                clk=>clk,
                datain(31 downto 0)=>mux1S(31 downto 0),
                we=>we1,
                dataout(31 downto 0)=>ram1S(31 downto 0));
   
   ram2 : Ram8
      port map (addr(3 downto 0)=>adr2(3 downto 0),
                clk=>clk,
                datain(31 downto 0)=>mux2S(31 downto 0),
                we=>we2,
                dataout(31 downto 0)=>ram2S(31 downto 0));
   
   ram3 : Ram8
      port map (addr(3 downto 0)=>adr3(3 downto 0),
                clk=>clk,
                datain(31 downto 0)=>mux3S(31 downto 0),
                we=>we3,
                dataout(31 downto 0)=>ram3S(31 downto 0));
   
   R0 : QDE
      port map (clk=>clk,
                d(31 downto 0)=>R0in(31 downto 0),
                E=>R0enable,
                q(31 downto 0)=>R0out(31 downto 0));
   
   R1 : QDE
      port map (clk=>clk,
                d(31 downto 0)=>R1in(31 downto 0),
                E=>R1enable,
                q(31 downto 0)=>R1out(31 downto 0));
   
   R2 : QDE
      port map (clk=>clk,
                d(31 downto 0)=>R2in(31 downto 0),
                E=>R2enable,
                q(31 downto 0)=>R2out(31 downto 0));
   
   R3 : QDE
      port map (clk=>clk,
                d(31 downto 0)=>R3in(31 downto 0),
                E=>R3enable,
                q(31 downto 0)=>R3out(31 downto 0));
   
   sel_in : select_in
      port map (count(7 downto 0)=>count(7 downto 0),
                Lastcycle=>lastcycle,
                litload=>Litload,
                X(1 downto 0)=>X(1 downto 0),
                Y(1 downto 0)=>Y(1 downto 0),
                adr0(3 downto 0)=>adr0(3 downto 0),
                adr1(3 downto 0)=>adr1(3 downto 0),
                adr2(3 downto 0)=>adr2(3 downto 0),
                adr3(3 downto 0)=>adr3(3 downto 0),
                selin0(1 downto 0)=>selin0(1 downto 0),
                selin1(1 downto 0)=>selin1(1 downto 0),
                selin2(1 downto 0)=>selin2(1 downto 0),
                selin3(1 downto 0)=>selin3(1 downto 0),
                selreg0(1 downto 0)=>selreg0(1 downto 0),
                selreg1(1 downto 0)=>selreg1(1 downto 0),
                selreg2(1 downto 0)=>selreg2(1 downto 0),
                selreg3(1 downto 0)=>selreg3(1 downto 0),
                we0=>we0,
                we1=>we1,
                we2=>we2,
                we3=>we3);
   
   sel_out : select_out
      port map (count(1 downto 0)=>count(1 downto 0),
                selNout(1 downto 0)=>selNout(1 downto 0),
                selN2out(1 downto 0)=>selN2out(1 downto 0),
                seloverS(1 downto 0)=>selOversized(1 downto 0),
                selTout(1 downto 0)=>selTout(1 downto 0));
   
   update_counter : next_count
      port map (clk=>clk,
                count_in(7 downto 0)=>count(7 downto 0),
                lastcycle=>lastcycle,
                reset=>reset,
                X(1 downto 0)=>X(1 downto 0),
                Y(1 downto 0)=>Y(1 downto 0),
                count_out(7 downto 0)=>count(7 downto 0));
   
   lastcycle<= ipdone or shortIP or Litload;
   
   R0enable<=selreg0(1) or selreg0(0);
   
   R1enable<=selreg1(1) or selreg1(0);
   
   R2enable<=selreg2(1) or selreg2(0);
   
   R3enable<=selreg3(1) or selreg3(0);
   
end BEHAVIORAL;