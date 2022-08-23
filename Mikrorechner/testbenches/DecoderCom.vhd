library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component decoder is
        port(   instruction                     : in  std_logic_vector(31 downto 0);
                opcode                          : out std_logic_vector(5 downto 0);
                registerX,registerY,registerZ   : out std_logic_vector(3 downto 0);
                immediate                       : out std_logic_vector(25 downto 0) );
    
    end component decoder;

    signal instruction                      :  std_logic_vector(31 downto 0);
    signal opcode                           :  std_logic_vector(5 downto 0);
    signal registerX, registerY, registerZ  :  std_logic_vector(3 downto 0);
    signal immediate                        :  std_logic_vector(25 downto 0);

    begin
        test : decoder port map(instruction, opcode, registerX, registerY, registerZ, immediate);

        process is
        begin 
            instruction <= "00000000000000000000000000000000";
            wait for 10 ns;
            
            instruction <= "11000100000011000000000000000000";
            wait for 10 ns;

        end process;

    end architecture simulation;