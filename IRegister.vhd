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
    P1 : process(clk, InstructionIn) is
        begin
            InstructionOut <= InstructionIn;
    end process;
end architecture;