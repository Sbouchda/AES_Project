library ieee;
use ieee.std_logic_1164.all;

entity Mix_Columns is
    port(
        INPP  : in  std_logic_vector(127 downto 0);
        OUTPP : out std_logic_vector(127 downto 0)
    );
end entity;

architecture Mix_ColumnsArch of Mix_Columns is
    signal B0,  B1,  B2,  B3,  B4,  B5,  B6,  B7,
           B8,  B9,  B10, B11, B12, B13, B14, B15 : std_logic_vector(7 downto 0);

    signal C0,  C1,  C2,  C3,  C4,  C5,  C6,  C7,
           C8,  C9,  C10, C11, C12, C13, C14, C15 : std_logic_vector(7 downto 0);

    signal o_mult_by2_0,  o_mult_by2_1,  o_mult_by2_2,  o_mult_by2_3,
           o_mult_by2_4,  o_mult_by2_5,  o_mult_by2_6,  o_mult_by2_7,
           o_mult_by2_8,  o_mult_by2_9,  o_mult_by2_10, o_mult_by2_11,
           o_mult_by2_12, o_mult_by2_13, o_mult_by2_14, o_mult_by2_15 : std_logic_vector(7 downto 0);

    signal o_mult_by3_0,  o_mult_by3_1,  o_mult_by3_2,  o_mult_by3_3,
           o_mult_by3_4,  o_mult_by3_5,  o_mult_by3_6,  o_mult_by3_7,
           o_mult_by3_8,  o_mult_by3_9,  o_mult_by3_10, o_mult_by3_11,
           o_mult_by3_12, o_mult_by3_13, o_mult_by3_14, o_mult_by3_15 : std_logic_vector(7 downto 0);

    component polyMultBy2
        port(
            INP  : in  std_logic_vector(7 downto 0);
            OUTP : out std_logic_vector(7 downto 0)
        );
    end component;

    component polyMultBy3
        port(
            INP  : in  std_logic_vector(7 downto 0);
            OUTP : out std_logic_vector(7 downto 0)
        );
    end component;

begin

    B0  <= INPP(7 downto 0);
    B1  <= INPP(15 downto 8);
    B2  <= INPP(23 downto 16);
    B3  <= INPP(31 downto 24);
    B4  <= INPP(39 downto 32);
    B5  <= INPP(47 downto 40);
    B6  <= INPP(55 downto 48);
    B7  <= INPP(63 downto 56);
    B8  <= INPP(71 downto 64);
    B9  <= INPP(79 downto 72);
    B10 <= INPP(87 downto 80);
    B11 <= INPP(95 downto 88);
    B12 <= INPP(103 downto 96);
    B13 <= INPP(111 downto 104);
    B14 <= INPP(119 downto 112);
    B15 <= INPP(127 downto 120);

    multBy2_0 : polyMultBy2 port map(
        INP  => B0,
        OUTP => o_mult_by2_0
    );
    multBy3_0 : polyMultBy3 port map(
        INP  => B3,
        OUTP => o_mult_by3_0
    );
    C0 <= o_mult_by2_0 xor o_mult_by3_0 xor B2 xor B1;

    multBy2_1 : polyMultBy2 port map(
        INP  => B1,
        OUTP => o_mult_by2_1
    );
    multBy3_1 : polyMultBy3 port map(
        INP  => B0,
        OUTP => o_mult_by3_1
    );
    C1 <= o_mult_by2_1 xor o_mult_by3_1 xor B2 xor B3;

    multBy2_2 : polyMultBy2 port map(
        INP  => B2,
        OUTP => o_mult_by2_2
    );
    multBy3_2 : polyMultBy3 port map(
        INP  => B1,
        OUTP => o_mult_by3_2
    );
    C2 <= o_mult_by2_2 xor o_mult_by3_2 xor B0 xor B3;

    multBy2_3 : polyMultBy2 port map(
        INP  => B3,
        OUTP => o_mult_by2_3
    );
    multBy3_3 : polyMultBy3 port map(
        INP  => B2,
        OUTP => o_mult_by3_3
    );
    C3 <= o_mult_by2_3 xor o_mult_by3_3 xor B0 xor B1;

    multBy2_4 : polyMultBy2 port map(
        INP  => B4,
        OUTP => o_mult_by2_4
    );
    multBy3_4 : polyMultBy3 port map(
        INP  => B7,
        OUTP => o_mult_by3_4
    );
    C4 <= o_mult_by2_4 xor o_mult_by3_4 xor B5 xor B6;

    multBy2_5 : polyMultBy2 port map(
        INP  => B5,
        OUTP => o_mult_by2_5
    );
    multBy3_5 : polyMultBy3 port map(
        INP  => B4,
        OUTP => o_mult_by3_5
    );
    C5 <= o_mult_by2_5 xor o_mult_by3_5 xor B6 xor B7;

    multBy2_6 : polyMultBy2 port map(
        INP  => B6,
        OUTP => o_mult_by2_6
    );
    multBy3_6 : polyMultBy3 port map(
        INP  => B5,
        OUTP => o_mult_by3_6
    );
    C6 <= o_mult_by2_6 xor o_mult_by3_6 xor B4 xor B7;

    multBy2_7 : polyMultBy2 port map(
        INP  => B7,
        OUTP => o_mult_by2_7
    );
    multBy3_7 : polyMultBy3 port map(
        INP  => B6,
        OUTP => o_mult_by3_7
    );
    C7 <= o_mult_by2_7 xor o_mult_by3_7 xor B4 xor B5;

    multBy2_8 : polyMultBy2 port map(
        INP  => B8,
        OUTP => o_mult_by2_8
    );
    multBy3_8 : polyMultBy3 port map(
        INP  => B11,
        OUTP => o_mult_by3_8
    );
    C8 <= o_mult_by2_8 xor o_mult_by3_8 xor B10 xor B9;

    multBy2_9 : polyMultBy2 port map(
        INP  => B9,
        OUTP => o_mult_by2_9
    );
    multBy3_9 : polyMultBy3 port map(
        INP  => B8,
        OUTP => o_mult_by3_9
    );
    C9 <= o_mult_by2_9 xor o_mult_by3_9 xor B10 xor B11;

    multBy2_10 : polyMultBy2 port map(
        INP  => B10,
        OUTP => o_mult_by2_10
    );
    multBy3_10 : polyMultBy3 port map(
        INP  => B9,
        OUTP => o_mult_by3_10
    );
    C10 <= o_mult_by2_10 xor o_mult_by3_10 xor B8 xor B11;

    multBy2_11 : polyMultBy2 port map(
        INP  => B11,
        OUTP => o_mult_by2_11
    );
    multBy3_11 : polyMultBy3 port map(
        INP  => B10,
        OUTP => o_mult_by3_11
    );
    C11 <= o_mult_by2_11 xor o_mult_by3_11 xor B8 xor B9;

    multBy2_12 : polyMultBy2 port map(
        INP  => B12,
        OUTP => o_mult_by2_12
    );
    multBy3_12 : polyMultBy3 port map(
        INP  => B15,
        OUTP => o_mult_by3_12
    );
    C12 <= o_mult_by2_12 xor o_mult_by3_12 xor B14 xor B13;

    multBy2_13 : polyMultBy2 port map(
        INP  => B13,
        OUTP => o_mult_by2_13
    );
    multBy3_13 : polyMultBy3 port map(
        INP  => B12,
        OUTP => o_mult_by3_13
    );
    C13 <= o_mult_by2_13 xor o_mult_by3_13 xor B14 xor B15;

    multBy2_14 : polyMultBy2 port map(
        INP  => B14,
        OUTP => o_mult_by2_14
    );
    multBy3_14 : polyMultBy3 port map(
        INP  => B13,
        OUTP => o_mult_by3_14
    );
    C14 <= B12 xor B15 xor o_mult_by2_14 xor o_mult_by3_14;

    multBy2_15 : polyMultBy2 port map(
        INP  => B15,
        OUTP => o_mult_by2_15
    );
    multBy3_15 : polyMultBy3 port map(
        INP  => B14,
        OUTP => o_mult_by3_15
    );
    C15 <= o_mult_by2_15 xor B13 xor B12 xor o_mult_by3_15;

    OUTPP <= C15 & C14 & C13 & C12 & C11 & C10 & C9 & C8 &
             C7  & C6  & C5  & C4  & C3  & C2  & C1 & C0;

end architecture;
   



        //Le principe c'est qu'on multiplier la ligne Bx par la matrice