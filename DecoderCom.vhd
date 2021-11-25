library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component decoder is
        port(   instruction : in  std_logic_vector(0 to 31);
                opcode      : out std_logic_vector(0 to 5);
                registerX   : out std_logic_vector(0 to 3);
                registerY   : out std_logic_vector(0 to 3);
                registerZ   : out std_logic_vector(0 to 3);
                immediate   : out std_logic_vector(0 to 25) );
    
    end component decoder;

    signal instruction                      :  std_logic_vector(0 to 31));
    signal opcode                           :  std_logic_vector(0 to 5);
    signal registerX, registerY, registerZ  :  std_logic_vector(0 to 3);
    signal immediate                        :  std_logic_vector(0 to 25);

    begin
        label : decoder port map(instruction, opcode, registerX, registerY, registerZ, immediate);

        process is
        begin 
            instruction <= "00000000000000000000000000";
            wait for 10 ns;
            
            instruction <= "00000000000000000000000000";
            wait for 10 ns;

        end process;

    end architecture simulation;