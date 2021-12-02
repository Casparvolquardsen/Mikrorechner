library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegBank is
    port(   clk : in std_logic;
             
end entity RegBank;

architecture verhalten of RegBank is
begin
    type Reg_Array is array(0 to 15) of std_logic_vector(31 downto 0);
    variable registers : Reg_Array := (others => (others => U));

    P1 : process(clk, InstructionIn) is
        begin
            InstructionOut <= InstructionIn;
    end process;
end architecture;