library ieee;
use std_logic_1164.all;

entity ShiftRowsTB is
end entity;

architecture ShiftRowsTB_Arch of ShiftRowsTB is

    signal INP_TB  : std_logic_vector(127 downto 0) := (others => '0');
    signal OUTP_TB : std_logic_vector(127 downto 0) := (others => '0');

    component ShiftRows is
        port(
            INP  : in  std_logic_vector(127 downto 0);
            OUTP : out std_logic_vector(127 downto 0)
        );
    end component;

begin

    DUT : ShiftRows
        port map(
            INP  => INP_TB,
            OUTP => OUTP_TB
        );

    STIMILUS : process
    begin
        report "test 1";
        INP_TB <= x"8ce170bae7e060cd51d0530904b7ca63";
        wait for 5 ns;

        assert OUTP_TB = x"e7d0caba51b770cd04e160098ce05363"
            report "test 1 failed"
            severity error;

        wait for 10 ns;
        wait;
    end process;

end architecture;
