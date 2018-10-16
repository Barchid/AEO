library ieee; 
use ieee.std_logic_1164.all; 
entity test is 
 port ( A : in std_logic_vector(1 downto 0); 
        B, C, D, E : in std_logic; 
        F, G, H : out std_logic); 
end test;

architecture synthesizable of test is 
begin 
-- H est complet (spécifié sur les quatre cas)
-- F n'est pas complet, produit seulement dans quelques cas donc il est latché (il y a un latch)
--   donc le latch ne se positionnera que si (spécifié dans deux premiers cas)
-- G pareil que F (spécifié dans deux cas aussi)
-- C'est de la mauvaise programmation, go gérer tous les cas _
-- Latch, ça veut dire qu'il est obligé de stocker l'information
--       c'est un verrou qui retient la dernière information comme on en fait rien avec
-- Pourquoi il n'y a pas tous les cas ? parce que dans le code on n'a pas tout écrit
-- Dans les autres cas, ça latch
-- Si on veut mémoriser ancien état, on met dans un registre ou process clocké mais pas latch
 process (A, B, C, D, E) 
   begin 
     case A is 
       when "00" => F <= B; H <= B; 
       when "01" => F <= C; G <= B; H <= C; 
       when "10" => G <= B; H <= D; 
       when "11" => H <= E; 
       when others => null; 
     end case; 
 end process;
 
end synthesizable; 
