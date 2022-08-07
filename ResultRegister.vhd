library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ResultRegister is
    port(   clk : in std_logic;
            result : in std_logic_vector(31 downto 0);
            reset : in std_logic;

            resultReg : out std_logic_vector(31 downto 0));
end entity ResultRegister;

architecture verhalten of ResultRegister is
begin
    P1 : process(clk, reset) is
        begin
            if rising_edge(clk) then
                resultReg <= result;
            end if;
            if falling_edge(reset) then
                resultReg <= (others => '0'); 
            end if;
    end process;
end architecture;