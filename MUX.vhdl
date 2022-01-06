library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity MUX is
    port(   
            opcode      : in std_logic_vector(5 downto 0);
            result, word   : in std_logic_vector(31 downto 0);
            C   : out std_logic_vector(31 downto 0) );
    
end entity MUX;

architecture verhalten of MUX is

begin
    P1: process (opcode, result, word) is 
    begin
        if opcode = "110000" then
            C <= word;
        else
            C <= result
        end if;
        
        
    end process;
end architecture verhalten;