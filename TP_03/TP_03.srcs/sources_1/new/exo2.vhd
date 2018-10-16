library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY compte_1 IS 
PORT (
    e : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s : OUT INTEGER RANGE 0 TO 2
);
END compte_1; 

ARCHITECTURE combinatoire OF compte_1 IS 
BEGIN 
    PROCESS(e)
    VARIABLE nombre_1 : INTEGER;
    BEGIN
    
    for I in 0 to 2 loop 
        IF e(I) = '1' THEN 
            nombre_1 := nombre_1 +1;
        END IF;
    end loop; 
    
    s <= nombre_1;
    END PROCESS;
END combinatoire ;