library ieee;
use ieee.std_logic_1164.all;

entity polyMultBy3_TB is
end entity;

architecture polyMultBy3_TB_Arch of polyMultBy3 is

constant CLK_PERIOD : time := 10 ns; -- Clock period (10 ns)

signal INP_TB  : std_logic_vector(7 downto 0);
signal OUTP_exp  : std_logic_vector(7 downto 0);                   -- Expected output data
signal OUTP_TB : std_logic_vector(7 downto 0);

component  polyMultBy3 is 
port(
     INP  : in std_logic_vector(7 downto 0); --input data in GF(2^8)
     OUTP : out std_logic_vector(7 downto 0)-- output data in GF(2^8)
);
end component;

begin 
DUT : polyMultBy3  port map(INP=>INP_TB ; OUTP=>OUTP_TB);

stimulus_proc : process
begin
    -- Test cases
    INP <= x"00";  -- Test case 1: Input is 0x00
    wait for CLK_PERIOD;
    OUTP_exp <= x"00"; -- Expected output is 0x00
    assert(OUTP  = OUTP_exp) report "Test case 1 failed" severity error;

    INP <= x"13";  -- Test case 2: Input is 0x13
    wait for CLK_PERIOD;
    OUTP_exp <= x"35"; -- Expected output is 0x35
    assert(OUTP = OUTP_exp) report "Test case 2 failed" severity error;
    INP <= x"8C";  -- Test case 2: Input is 0x13
    wait for CLK_PERIOD;
    OUTP_exp <= x"8F"; -- Expected output is 0x35
    assert(OUTP = OUTP_exp) report "Test case 2 failed" severity error;
    -- Add more test cases as needed

    wait;
end process stimulus_proc;


end architecture;