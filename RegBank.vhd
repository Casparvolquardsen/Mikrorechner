library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegBank is
    port(   clk : in std_logic;
            x,y,z: in std_logic_vector(3 downto 0);
            C,PCIn : in std_logic_vector(31 downto 0);

            A,B : out std_logic_vector(31 downto 0);
            AShort : out std_logic_vector(15 downto 0));
             
end entity RegBank;

architecture verhalten of RegBank is
    type R is array(0 to 15) of std_logic_vector(31 downto 0);
    signal registers : R;
    begin
        P1 : process(clk) is
            begin
                If rising_edge(clk) then
                    A <= (others => 'U');
                    B <= (others => 'U');
                    if PCIn /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
                        registers(15) <= PCIn;
                    end if;
                    if x /= "UUUU" then
                        A <= registers(to_integer(unsigned(x)));
                        AShort <= registers(to_integer(unsigned(x)))(15 downto 0);
                    end if;
                    if y /= "UUUU" then
                        B <= registers(to_integer(unsigned(y)));
                    end if;
                    if z /= "UUUU" then
                        registers(to_integer(unsigned(z))) <= C; -- TODO: Was passiert wenn z undefined?
                    end if;
                end if;
        end process;
end architecture;