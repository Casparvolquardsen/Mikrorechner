library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component FPGA is
        port(
                clk : in std_logic;
                key : in std_logic_vector(1 downto 0);
                dip : in std_logic_vector(3 downto 0);

                led : out std_logic_vector(7 downto 0) 
        );
    end component FPGA;

    signal clk : std_logic;
    signal key : std_logic_vector(1 downto 0);
    signal dip : std_logic_vector(3 downto 0);
    signal led : std_logic_vector(7 downto 0);

    begin
    C1: FPGA port map(clk,key,dip,led);
    
    process is 
    begin 
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    process is 
    begin 
        key <= "11";
        dip <= "0000";
        wait for 50 ns;
        dip <= "1010";
        wait for 1 ns;
        key <= "01";
        wait for 1 ns;
        key <= "11";
        wait for 200 ns;
        key <= "10";
        wait for 1 ns;
        key <= "11";
        wait for 100 ns;        
    end process;
end architecture simulation;