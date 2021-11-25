library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity decoder is
    port(   instruction : in  std_logic_vector(31 downto 0);
            opcode      : out std_logic_vector(5 downto 0);
            registerX   : out std_logic_vector(3 downto 0);
            registerY   : out std_logic_vector(3 downto 0);
            registerZ   : out std_logic_vector(3 downto 0);
            immediate   : out std_logic_vector(25 downto 0) );
    
end entity decoder;

architecture verhalten of decoder is

begin
    P1: process (instruction) is 
    begin
        opcode <= instruction(31 downto 26);
        immediate <= (others => '0');
        registerX <= (others => '-');
        registerY <= (others => '-');
        registerZ <= (others => '-');
        
        if instruction(31) = '0' then
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
        else
            if instruction(30) = '0' then
                registerZ <= instruction(25 downto 22);
                immediate(21 downto 0) <= instruction(21 downto 0);
            else
                if instruction(29) = '0' then
                        registerX <= instruction(25 downto 22);
                        registerZ <= instruction(17 downto 14);
                        immediate(16 downto 0) <= instruction(17 downto 0);
                else
                    if instruction(28) = '0' then
                            immediate <= instruction(25 downto 0);
                    else 
                            registerX <= instruction(25 downto 22);
                    end if;
                end if;
            end if; 
        end if;
    end process;
end architecture verhalten;