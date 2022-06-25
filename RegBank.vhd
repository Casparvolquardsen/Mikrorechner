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
                    A <= (others => 'U');  -- TODO: remove undefined
                    B <= (others => 'U');  -- TODO: remove undefined
                    if PCIn /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then  -- TODO: remove undefined
                        registers(15) <= PCIn;
                    end if;
                    if x /= "UUUU" then  -- TODO: remove undefined
                        A <= registers(to_integer(unsigned(x)));
                        AShort <= registers(to_integer(unsigned(x)))(15 downto 0);
                    end if;
                    if y /= "UUUU" then  -- TODO: remove undefined
                        B <= registers(to_integer(unsigned(y)));
                    end if;
                    if z /= "UUUU" and C /= "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then  -- TODO: remove undefined
                        registers(to_integer(unsigned(z))) <= C;
                    end if;
                    registers(14) <= (others => '0');
                    registers(14)(3 downto 0) <= dips;
                end if;
                if falling_edge(reset) then
                    A <= (others => 'U');  -- TODO: remove undefined
                    AShort <= (others => 'U');  -- TODO: remove undefined
                    B <= (others => 'U');  -- TODO: remove undefined
                    for I in 0 to 15 loop
                        registers(I) <= (others => 'U');  -- TODO: remove undefined
                    end loop;
                end if;

                -- leds 
                led <= registers(13)(7 downto 0);
        end process;
end architecture;