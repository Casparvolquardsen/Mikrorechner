library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component PC is
    port(   clk         : in std_logic;
            opcode      : in  std_logic_vector(5 downto 0);
            PCIn, X     : in std_logic_vector(31 downto 0);
            immediate   : in std_logic_vector(25 downto 0);
            cin         : in std_logic;

            PCOut,PCSave : out std_logic_vector(31 downto 0));
    end component PC;

    signal clk          : std_logic;
    signal opcode       : std_logic_vector(5 downto 0);
    signal PCIn, X      : std_logic_vector(31 downto 0);
    signal immediate    : std_logic_vector(25 downto 0);
    signal cin          : std_logic;
    signal PCOut, PCSave: std_logic_vector(31 downto 0);

    begin
        test : PC port map(clk, opcode, PCIn, X, immediate, cin, PCOut, PCSave);

        process is
        begin    
                clk <= '0';
                wait for 5 ns;
                -- br
                clk<='1';
                opcode <= "111000";
                PCIn <= "00000000000000000000000000000010";
                immediate <= "00000000000000000000010000";
                -- "00000000000000000000000000010011"
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;                

                -- jsr
                clk<='1';
                opcode <= "111001";
                PCIn <= "00000000000000000000000000000100";
                immediate <= "00000000000000000000001000";  
                -- "00000000000000000000000000001101"
                -- "00000000000000000000000000000101"              
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;

                -- bt
                clk<='1';
                opcode <= "111010";
                PCIn <= "00000000000000000000000000001000";
                immediate <= "00000000000000000000000100";
                cin <= '1';
                -- "00000000000000000000000000001101"
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;

                -- bf
                clk<='1';
                opcode <= "111011";
                PCIn <= "00000000000000000000000000010000";
                immediate <= "00000000000000000000000010";
                cin <= '1';
                -- "00000000000000000000000000010001"
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;

                -- jmp
                clk<='1';
                opcode <= "111100";
                X <= "00000000000000000000000000000010";
                --""00000000000000000000000000000010";
                wait for 5 ns;
                clk <= '0';
                wait for 5 ns;

        end process;

end architecture simulation;