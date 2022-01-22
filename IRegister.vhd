library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IRegister is
    port(   clk : in std_logic;
            InstructionIn : in std_logic_vector(31 downto 0);
            reset : in std_logic;

            InstructionOut : out std_logic_vector(31 downto 0));
end entity IRegister;

architecture verhalten of IRegister is
begin
    P1 : process(clk) is
        variable i : integer := 1;
        begin
            if rising_edge(clk)then
                if i = 0 then
                    InstructionOut <= InstructionIn;
                else
                    i := 0;
                end if;
            end if;
            if falling_edge(reset) then
                InstructionOut <= (others => 'U');
                i := 1;
            end if;
    end process;
end architecture;