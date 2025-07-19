library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity polyMultBy2 is
    port(
        INP  : in  std_logic_vector(7 downto 0);
        OUTP : out std_logic_vector(7 downto 0)
    );
end entity;

architecture polyMultBy2Arch of polyMultBy2 is
    signal shifted : std_logic_vector(7 downto 0);
begin
    shifted <= INP(6 downto 0) & '0';  -- Décalage à gauche
    
    OUTP <= shifted xor X"1B" when INP(7) = '1' else 
             shifted;
end architecture;