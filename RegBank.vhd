library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegBank is
    port(   clk : in std_logic;
            x,y,z: in std_logic_vector(3 downto 0);
            Zwren: std_logic := '0'; -- write enable for Register Z
            C: in std_logic_vector(31 downto 0);
            reset : in std_logic;
            dips : in std_logic_vector(3 downto 0);
            

            led : out std_logic_vector(7 downto 0);
            X,Y : out std_logic_vector(31 downto 0);
            XShort : out std_logic_vector(15 downto 0));
             
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
                    X <= registers(to_integer(unsigned(x)));
                    XShort <= registers(to_integer(unsigned(x)))(15 downto 0);
                    
                    Y <= registers(to_integer(unsigned(y)));

                    if Zwren = '1' then
                        registers(to_integer(unsigned(z))) <= C;
                    end if;

                    -- Input of FPGA-Board is saved in Register 14
                    registers(14) <= (others => '0');
                    registers(14)(3 downto 0) <= dips;
                end if;

                if falling_edge(reset) then
                    X <= (others => '0');
                    XShort <= (others => '0');
                    Y <= (others => '0');
                    for I in 0 to 15 loop
                        registers(I) <= (others => '0');
                    end loop;
                end if;

                -- leds (Output of FPGA-Board)
                led <= registers(13)(7 downto 0);
        end process;
end architecture;