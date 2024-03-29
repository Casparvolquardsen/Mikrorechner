library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterZ is
    port(   clk : in std_logic;
            Zin : in std_logic_vector(3 downto 0);
            reset : in std_logic;

            Zout : out std_logic_vector(3 downto 0));
end entity RegisterZ;

architecture verhalten of RegisterZ is
begin
    P1 : process(clk, reset) is
        begin
            if reset = '0' then
                Zout <= (others => '0'); 
            elsif rising_edge(clk) then
                Zout <= Zin;
            end if;
    end process;
end architecture;
