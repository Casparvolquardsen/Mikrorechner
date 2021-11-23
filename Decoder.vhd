 library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port(   clk         : in  std_logic;
            instruction : in  std_logic_vector(0 to 31));
            opcode      : out std_logic_vector(0 to 5);
            registerX   : out std_logic_vector(0 to 3);
            registerY   : out std_logic_vector(0 to 3);
            registerZ   : out std_logic_vector(0 to 3);
            immediate   : out std_logic_vector(0 to 25) );
    
end entity decoder;

architecture verhalten of decoder is

begin
    

    opcode <= instruction(0 to 5);
    immediate(0 to 25) <= '00000000000000000000000000';
    case instruction(0) is 
        when '0' => 
            registerX(0 to 3) <= instruction(6 to 9);
            registerY(0 to 3) <= instruction(10 to 13);
            registerZ(0 to 3) <= instruction(14 to 17);
        when '1' =>
            case instruction(1) is
                when '0' =>
                    registerZ(0 to 3) <= instruction(6 to 9);
                    immediate(4 to 25) <= instruction(10 to 31);
                when '1' =>
                    case instruction(2) is
                        when '0' =>
                            registerX(0 to 3) <= instruction(6 to 9);
                            registerZ(0 to 3) <= instruction(10 to 13);
                            immediate(8 to 25) <= instruction(14 to 31);
                        when '1' =>
                            case instruction(3) is
                                when '0' => 
                                    immediate(0 to 25) <= instruction(6 to 31);
                                when '1' => 
                                    registerX(0 to 3) <= instruction(6 to 9);
                            end case;
                    end case;
            end case;        
    end case;
        


end architecture verhalten;