library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterOP is
    port(   clk : in std_logic;
            OPin : in std_logic_vector(5 downto 0);

            OPout : out std_logic_vector(5 downto 0));
end entity RegisterOP;

architecture verhalten of RegisterOP is
begin
    P1 : process(clk) is
        begin
            if rising_edge(clk) then
                OPout <= OPin;
            end if;
    end process;
end architecture;