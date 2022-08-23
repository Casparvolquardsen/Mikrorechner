library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity MUX is
    port(   
            opcode      : in std_logic_vector(5 downto 0);
            result, load_data, PCSave   : in std_logic_vector(31 downto 0);

            C   : out std_logic_vector(31 downto 0) 
        );    
end entity MUX;

architecture verhalten of MUX is

begin
    P1: process (opcode, result, load_data, PCSave) is 
    begin
        -- ldw
        if opcode = "110000" then
            C <= load_data;
        -- jsr
        elsif opcode = "111001" then
            C <= PCSave;
        else
            C <= result;
        end if;
    end process;
end architecture verhalten;