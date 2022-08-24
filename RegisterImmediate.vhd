library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterImmediate is
    port(   clk : in std_logic;
            Immin : in std_logic_vector(25 downto 0);
            reset : in std_logic;

            Immout : out std_logic_vector(25 downto 0));
end entity RegisterImmediate;

architecture verhalten of RegisterImmediate is
begin
    P1 : process(clk, reset) is
        begin
            
            if reset = '0' then
                Immout <= (others => '0');
            elsif rising_edge(clk) then
                Immout <= Immin;
            end if;
    end process;
end architecture;
