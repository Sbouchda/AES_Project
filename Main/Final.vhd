library ieee;
use ieee.std_logic_1164.all;

entity Final is
    port(
        clk           : in  std_logic;
        start         : in  std_logic;
        busy          : out std_logic;
        plaintext     : in  std_logic_vector(127 downto 0);
        valid_o       : out std_logic;
        ciphertext_o  : out std_logic_vector(127 downto 0);
        key           : out std_logic_vector(127 downto 0)
    );
end entity;

architecture FinalArch of Final is

    signal ciphertext : std_logic_vector(127 downto 0) := (others => '0');

    type KeysArray_t is array(0 to 10) of std_logic_vector(127 downto 0);
    signal KeysArray : KeysArray_t := (
        x"2b7e151628aed2a6abf7158809cf4f3c",  -- Round 0
        x"a0fafe1788542cb123a339392a6c7605",  -- Round 1
        x"f2c295f27a96b9435935807a7359f67f",  -- Round 2
        x"3d80477d4716fe3e1e237e446d7a883b",  -- Round 3
        x"ef44a541a8525b7fb671253bdb0bad00",  -- Round 4
        x"d4d1c6f87c839d87caf2b8bc11f915bc",  -- Round 5
        x"6d88a37a110b3efddbf98641ca0093fd",  -- Round 6
        x"4e54f70e5f5fc9f384a64fb24ea6dc4f",  -- Round 7
        x"ead27321b58dbad2312bf5607f8d292f",  -- Round 8
        x"ac7766f319fadc2128d12941575c006e",  -- Round 9
        x"d014f9a8c9ee2589e13f0cc8b6630ca6"   -- Round 10
    );

    constant max_rounds : unsigned(3 downto 0) := x"A";
    signal round        : unsigned(3 downto 0) := (others => '0');
    signal roundReg     : unsigned(3 downto 0) := (others => '0');

    type state_t is (idle, round0, subByteLayer, shiftRowsLayer, mixColumnLayer, keyAddLayer, finish);
    signal current_state, next_state : state_t;

    signal i_Sbox, o_Sbox                   : std_logic_vector(127 downto 0);
    signal i_keyAddKey, i_dataAddKey        : std_logic_vector(127 downto 0);
    signal o_dataAddKey                     : std_logic_vector(127 downto 0);
    signal i_dataShiftRows, o_dataShiftRows : std_logic_vector(127 downto 0);
    signal i_dataMixColumn, o_dataMixColumn : std_logic_vector(127 downto 0);
    signal finished                         : std_logic := '0';

    component SubByte 
        port(
            INP  : in  std_logic_vector(7 downto 0);
            OUTP : out std_logic_vector(7 downto 0)
        );
    end component;

    component shiftRows
        port (
            INP  : in  std_logic_vector(127 downto 0);
            OUTP : out std_logic_vector(127 downto 0)
        );
    end component;

    component Mix_Columns
        port(
            INPP  : in  std_logic_vector(127 downto 0);
            OUTPP : out std_logic_vector(127 downto 0)
        );
    end component;

    component addKey
        port (
            round_Key : in  std_logic_vector(127 downto 0);
            INP       : in  std_logic_vector(127 downto 0);
            OUTP      : out std_logic_vector(127 downto 0)
        );
    end component;

begin

    -- SubByte Layer Instantiations
    subByteInst0  : SubByte port map (INP => i_sbox(7 downto 0),      OUTP => o_Sbox(7 downto 0));
    subByteInst1  : SubByte port map (INP => i_sbox(15 downto 8),     OUTP => o_Sbox(15 downto 8));
    subByteInst2  : SubByte port map (INP => i_sbox(23 downto 16),    OUTP => o_Sbox(23 downto 16));
    subByteInst3  : SubByte port map (INP => i_sbox(31 downto 24),    OUTP => o_Sbox(31 downto 24));
    subByteInst4  : SubByte port map (INP => i_sbox(39 downto 32),    OUTP => o_Sbox(39 downto 32));
    subByteInst5  : SubByte port map (INP => i_sbox(47 downto 40),    OUTP => o_Sbox(47 downto 40));
    subByteInst6  : SubByte port map (INP => i_sbox(55 downto 48),    OUTP => o_Sbox(55 downto 48));
    subByteInst7  : SubByte port map (INP => i_sbox(63 downto 56),    OUTP => o_Sbox(63 downto 56));
    subByteInst8  : SubByte port map (INP => i_sbox(71 downto 64),    OUTP => o_Sbox(71 downto 64));
    subByteInst9  : SubByte port map (INP => i_sbox(79 downto 72),    OUTP => o_Sbox(79 downto 72));
    subByteInst10 : SubByte port map (INP => i_sbox(87 downto 80),    OUTP => o_Sbox(87 downto 80));
    subByteInst11 : SubByte port map (INP => i_sbox(95 downto 88),    OUTP => o_Sbox(95 downto 88));
    subByteInst12 : SubByte port map (INP => i_sbox(103 downto 96),   OUTP => o_Sbox(103 downto 96));
    subByteInst13 : SubByte port map (INP => i_sbox(111 downto 104),  OUTP => o_Sbox(111 downto 104));
    subByteInst14 : SubByte port map (INP => i_sbox(119 downto 112),  OUTP => o_Sbox(119 downto 112));
    subByteInst15 : SubByte port map (INP => i_sbox(127 downto 120),  OUTP => o_Sbox(127 downto 120));

    -- ShiftRows Layer
    shiftRowInst : shiftRows port map (
        INP  => i_dataShiftRows,
        OUTP => o_dataShiftRows
    );

    -- MixColumn Layer
    mixColumnInst : Mix_Columns port map (
        INPP  => i_dataMixColumn,
        OUTPP => o_dataMixColumn
    );

    -- AddRoundKey Layer
    keyAddInst : addKey port map (
        round_Key => i_keyAddKey,
        INP       => i_dataAddKey,
        OUTP      => o_dataAddKey
    );

    -- Memory logic: update state on clock
    MEMORY_LOGIC : process(clk)
    begin
        if rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- FSM next state logic
    NEXT_STATE_LOGIC : process(current_state, start, round)
    begin
        case current_state is
            when idle =>
                if start = '1' then
                    next_state <= round0;
                else
                    next_state <= idle;
                end if;
            when round0 =>
                next_state <= subByteLayer;
            when subByteLayer =>
                next_state <= shiftRowsLayer;
            when shiftRowsLayer =>
                if round < max_rounds then
                    next_state <= mixColumnLayer;
                else
                    next_state <= keyAddLayer;
                end if;
            when mixColumnLayer =>
                next_state <= keyAddLayer;
            when keyAddLayer =>
                if round < max_rounds then
                    next_state <= subByteLayer;
                elsif round = max_rounds then
                    next_state <= finish;
                end if;
            when finish =>
                next_state <= idle;
            when others =>
                null;
        end case;
    end process;

    -- FSM output logic
    OUTPUT_LOGIC : process(current_state)
    begin
        finished <= '0';
        case current_state is
            when idle =>
                round    <= (others => '0');
                busy     <= '0';
                valid_o  <= '0';

            when round0 =>
                i_keyAddKey  <= KeysArray(0);
                i_dataAddKey <= plaintext;
                busy         <= '1';

            when subByteLayer =>
                if round < max_rounds then
                    round  <= roundReg + to_unsigned(1, 4);
                    i_sbox <= o_dataAddKey;
                end if;

            when shiftRowsLayer =>
                i_dataShiftRows <= o_sbox;

            when mixColumnLayer =>
                i_dataMixColumn <= o_dataShiftRows;

            when keyAddLayer =>
                i_keyAddKey <= KeysArray(to_integer(round));
                if round < max_rounds then
                    i_dataAddKey <= o_dataMixColumn;
                elsif round = max_rounds then
                    i_dataAddKey <= o_dataShiftRows;
                end if;

            when finish =>
                ciphertext <= o_dataAddKey;
                valid_o    <= '1';
                busy       <= '0';
                finished   <= '1';

            when others =>
                null;
        end case;
    end process;

    -- Output assignments
    ciphertext_o <= ciphertext;
    key          <= KeysArray(0);

    -- Register for round counter
    RoundRegister : process(clk)
    begin
        if rising_edge(clk) then
            roundReg <= round;
        end if;
    end process;

end architecture;
