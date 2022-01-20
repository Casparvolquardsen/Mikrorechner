library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component regbank is
    port(  
        clk : in std_logic;
        x,y,z: in std_logic_vector(3 downto 0);
        C,PCIn : in std_logic_vector(31 downto 0);
        A,B : out std_logic_vector(31 downto 0));
    end component regbank;

    signal clk                              :  std_logic;
    signal x,y,z                            :  std_logic_vector(3 downto 0);
    signal C,PCIn                           :  std_logic_vector(31 downto 0);
    signal A,B                              :  std_logic_vector(31 downto 0);

    begin
        test : regbank port map(clk,x,y,z,C,PCIn,A,B);

        process is
            begin 
                clk <= '0';
                wait for 5 ns;

                x <= "0001";
                y <= "0001";
                z <= "0000";
                C <= "00000000000000000000000000000000";
                PCIn <= (others => 'U');
                clk <= '1';
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;
                --erwartet A = "--------------------------------"  B = "--------------------------------"

                x <= "0000";
                y <= "1111";
                z <= "0010";
                C <=    "11111111111111111111111111111111";
                PCIn <= "10000000000000000000000000000111";
                clk <= '1';
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;
                --erwartet A = "00000000000000000000000000000000"  B = "--------------------------------"

                x <= "0010";
                y <= "1111";
                z <= "0001";
                C <= "00000000001100000000000000000111";
                PCIn <= (others => 'U');
                clk <= '1';
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;
                --erwartet A = "11111111111111111111111111111111"  B = "10000000000000000000000000000111"

                x <= "0010";
                y <= "0001";
                z <= "0000";
                C <= "00000000000000000000000000000000";
                PCIn <= (others => 'U');
                clk <= '1';
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;
                --erwartet A = "11111111111111111111111111111111"  B = "00000000001100000000000000000111"
        end process;
end architecture simulation;