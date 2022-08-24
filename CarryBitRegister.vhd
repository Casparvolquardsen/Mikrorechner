library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CarryBitRegister is
    port(   clk : in std_logic;
            CarryIn : in std_logic;
            reset : in std_logic;

            CarryOut : out std_logic );
end entity CarryBitRegister;

architecture verhalten of CarryBitRegister is
begin
    P1 : process(clk, reset) is
        begin
            if reset = '0' then
                CarryOut <= '0'; 
            elsif rising_edge(clk) then
                CarryOut <= CarryIn;
            end if;
    end process;
end architecture;
