library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component iregister is
        port(  
                clk : in  std_logic;
                InstructionIn : in std_logic_vector(31 downto 0);
                InstructionOut : out std_logic_vector(31 downto 0) );
    
    end component iregister;

    signal clk                              :  std_logic;
    signal InstructionIn                    :  std_logic_vector(31 downto 0);
    signal InstructionOut                   :  std_logic_vector(31 downto 0);

    begin
        test : iregister port map(clk, InstructionIn, InstructionOut);

        process is
        begin 
            clk <= '0';
            wait for 5 ns;

            instructionIn <= "00000000000000000000000000000000";
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            
            instructionIn <= "00000100000001001000000000000000";
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;

        end process;

    end architecture simulation;