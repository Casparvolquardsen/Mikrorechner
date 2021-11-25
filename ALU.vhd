library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port(   opcode : in  std_logic_vector(5 downto 0);
            A : in std_logic_vector(31 downto 0);
            B : in std_logic_vector(31 downto 0);
            cin : in std_logic;

            cout : out std_logic;
            result : out std_logic_vector(31 downto 0) );

end entity ALU;

architecture verhalten of decoder is
begin
    process (opcode, A, B, cin)
    begin


end architecture;