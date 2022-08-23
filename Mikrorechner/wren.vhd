library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity wren is
    port(   
        opcode  : in std_logic_vector(5 downto 0);
        wren_a  : out std_logic;
        wren_b  : out std_logic
    );
end entity wren;

architecture verhalten of wren is

begin
    P1: process (opcode) is 
    begin
        wren_b <= '0';
        if opcode = "110001" then
            wren_a <= '1';
        else 
            wren_a <= '0';
        end if;
    end process;
end architecture verhalten;