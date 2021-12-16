library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IRegister is
    port(   clk : in std_logic;
            InstructionIn : in std_logic_vector(31 downto 0);

            InstructionOut : out std_logic_vector(31 downto 0));
end entity IRegister;

architecture verhalten of IRegister is
begin
    P1 : process(clk) is
        begin
            if rising_edge(clk) then
                InstructionOut <= InstructionIn;
            end if;
    end process;
end architecture;