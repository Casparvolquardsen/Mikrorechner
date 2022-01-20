library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component Processor is
    port(   clock_50         : in std_logic);
    end component Processor;

    signal clock_50          : std_logic;

    begin
        test : Processor port map(clock_50);

        process is
        begin    
                clock_50 <= '0';
                wait for 5 ns;
                clock_50 <='1';
                wait for 5 ns;
        end process;

end architecture simulation;