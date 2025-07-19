library ieee;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity polyMultBy3 is
    port(
        INP  : in  std_logic_vector(7 downto 0);
        OUTP : out std_logic_vector(7 downto 0)
    );
end entity;

architecture polyMultBy3Arch of polyMultBy3 is
    signal mul2      : std_logic_vector(7 downto 0);
    signal mul2_red  : std_logic_vector(7 downto 0);
begin
    -- Multiplication par 2 avec réduction conditionnelle
    mul2     <= INP(6 downto 0) & '0';
    mul2_red <= mul2 when INP(7) = '0' else mul2 xor x"1B";
    
    -- Multiplication par 3 = (2x) ⊕ x
    OUTP <= mul2_red xor INP;
end architecture;