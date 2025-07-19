library ieee;
use ieee.std_logic_1164.all;

entity Mix_ColumnsTB is
end entity;

architecture Mix_ColumnsTB_Arch of Mix_Columns is
signal INPP_TB  : std_logic_vector(127 downto 0):= (others => '0');
signal OUTPP_TB : std_logic_vector(127 downto 0); 

component Mix_Columns is
        port(
            INPP: in std_logic_vector(127 downto 0);  
            OUTPP: out std_logic_vector(127 downto 0));
    
end component;
begin
DUT : Mix_Columns port map(INPP=>INPP_TB;OUTPP=>OUTPP_TB);

STIMULUS : process
begin
    INPP_TB <= x"618b611f45cac9d89b73ad97691abea7"; 
    wait for 10 ns;
    assert OUTPP_TB = x"09d03a77fa515164516ad831849687ff" report "Test 1 failed" severity error;
    wait for 10 ns;
    wait;
end process;

end architecture;