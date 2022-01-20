library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterImmediate is
    port(   clk : in std_logic;
            Immin : in std_logic_vector(25 downto 0);

            Immout : out std_logic_vector(25 downto 0));
end entity RegisterImmediate;

architecture verhalten of RegisterImmediate is
begin
    P1 : process(clk) is
        begin
            if rising_edge(clk) then
                Immout <= Immin;
            end if;
    end process;
end architecture;