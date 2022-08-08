library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity WriteEnableZRegister is
    port(   clk : in std_logic;
            WriteEnableZIn : in std_logic;
            reset : in std_logic;

            WriteEnableZOut : out std_logic );
end entity WriteEnableZRegister;

architecture verhalten of WriteEnableZRegister is
begin
    P1 : process(clk, reset) is
        begin
            if rising_edge(clk) then
                WriteEnableZOut <= WriteEnableZIn;
            end if;
            
            if falling_edge(reset) then
                WriteEnableZOut <= (others => '0'); 
            end if;
    end process;
end architecture;