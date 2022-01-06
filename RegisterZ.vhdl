library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterZ is
    port(   clk : in std_logic;
            Zin : in std_logic_vector(3 downto 0);

            Zout : out std_logic_vector(3 downto 0));
end entity RegisterZ;

architecture verhalten of RegisterZ is
begin
    P1 : process(clk) is
        begin
            if rising_edge(clk) then
                Zin <= Zout;
            end if;
    end process;
end architecture;