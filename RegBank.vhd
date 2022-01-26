library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegBank is
    port(   clk : in std_logic;
            x,y,z: in std_logic_vector(3 downto 0);
            C,PCIn : in std_logic_vector(31 downto 0);
            reset : in std_logic;
            dips : in std_logic_vector(3 downto 0);

            led : out std_logic_vector(7 downto 0);
            A,B : out std_logic_vector(31 downto 0);
            AShort : out std_logic_vector(15 downto 0));
             
end entity RegBank;

-- register 14 is reserved for input 
-- register 13 is reserved for output

architecture verhalten of RegBank is
    type R is array(0 to 15) of std_logic_vector(31 downto 0);
    signal registers : R;
    begin
        P1 : process(clk, reset) is
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
                    if z /= "UUUU" and C /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
                        registers(to_integer(unsigned(z))) <= C;
                    end if;
                    registers(14) <= (others => '0');
                    registers(14)(3 downto 0) <= dips;
                end if;
                if falling_edge(reset) then
                    A <= (others => 'U');
                    AShort <= (others => 'U');
                    B <= (others => 'U');
                    for I in 0 to 15 loop
                        registers(I) <= (others => 'U');
                    end loop;
                end if;

                -- leds 
                led <= registers(13)(7 downto 0);
        end process;
end architecture;