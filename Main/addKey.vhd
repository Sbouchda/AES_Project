library ieee;
use ieee.std_logic_1164.all;

entity addKey is
    port (
        round_key : in  std_logic_vector(127 downto 0);
        INP       : in  std_logic_vector(127 downto 0);
        OUTP      : out std_logic_vector(127 downto 0)
    );
end entity;

architecture addKeyArch of addKey is
begin
    OUTP <= INP xor round_key;
end architecture; 