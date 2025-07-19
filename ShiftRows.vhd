library ieee;
use ieee.std_logic_1164.all;

entity ShiftRows is
    port (
        INP  : in  std_logic_vector(127 downto 0);
        OUTP : out std_logic_vector(127 downto 0)
    );
end entity;

architecture ShiftRowsArch of ShiftRows is
    signal B0,  B1,  B2,  B3,  B4,  B5,  B6,  B7,
           B8,  B9,  B10, B11, B12, B13, B14, B15 : std_logic_vector(7 downto 0);

    signal C0,  C1,  C2,  C3,  C4,  C5,  C6,  C7,
           C8,  C9,  C10, C11, C12, C13, C14, C15 : std_logic_vector(7 downto 0);
begin

    B0  <= INP(7 downto 0);
    B1  <= INP(15 downto 8);
    B2  <= INP(23 downto 16);
    B3  <= INP(31 downto 24);
    B4  <= INP(39 downto 32);
    B5  <= INP(47 downto 40);
    B6  <= INP(55 downto 48);
    B7  <= INP(63 downto 56);
    B8  <= INP(71 downto 64);
    B9  <= INP(79 downto 72);
    B10 <= INP(87 downto 80);
    B11 <= INP(95 downto 88);
    B12 <= INP(103 downto 96);
    B13 <= INP(111 downto 104);
    B14 <= INP(119 downto 112);
    B15 <= INP(127 downto 120);

    C15 <= B15;
    C14 <= B10;
    C13 <= B5;
    C12 <= B0;
    C11 <= B11;
    C10 <= B6;
    C9  <= B1;
    C8  <= B12;
    C7  <= B7;
    C6  <= B2;
    C5  <= B13;
    C4  <= B8;
    C3  <= B3;
    C2  <= B14;
    C1  <= B9;
    C0  <= B4;

    OUTP <= C15 & C14 & C13 & C12 & C11 & C10 & C9 & C8 &
            C7 & C6 & C5 & C4 & C3 & C2 & C1 & C0;

end architecture;
