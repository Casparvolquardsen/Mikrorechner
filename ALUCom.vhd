library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
    component ALU is
        port(   opcode : in  std_logic_vector(5 downto 0);
        A,B : in std_logic_vector(31 downto 0);
        immediate : in std_logic_vector(25 downto 0);
        cin : in std_logic;

        cout : out std_logic;
        result : out std_logic_vector(31 downto 0) );
    
    end component ALU;

    signal opcode : std_logic_vector(5 downto 0);
    signal A,B :  std_logic_vector(31 downto 0);
    signal immediate : std_logic_vector(25 downto 0);
    signal cin : std_logic;
    signal cout : std_logic;
    signal result : std_logic_vector(31 downto 0);

    begin
        test : ALU port map(opcode, A, B, immediate, cin, cout, result);

        process is
        begin 
        
        -- Test für addc
            opcode <= "000010";
            A <= "00000000000000000000000000000001";
            B <= "00000000000000000000000000000010";
            immediate <= "00000000000000000000000100";
            cin <= '0';
            -- Erwartet: 00000000000000000000000000000011
            wait for 10 ns;

            -- Test für and
            opcode <= "000100";
            A <= "00000000000000000000000000000010";
            B <= "00000000000000000000000000000011";
            immediate <= "00000000000000000000000000";
            cin <= '0';
            -- Erwartet: 00000000000000000000000000000010
            wait for 10 ns;

            -- Test für max
            opcode <= "001011";
            A <= "00000000000000000000000000000110";
            B <= "00000000000000000000000000000011";
            immediate <= "00000000000000000000000000";
            cin <= '0';
            -- Erwartet: 00000000000000000000000000000110
            wait for 10 ns;

            -- Test für lsl4
            opcode <= "010010";
            A <= "00000000000000000000000000000110";
            B <= "00000000000000000000000000000000";
            immediate <= "00000000000000000000000000";
            cin <= '0';
            -- Erwartet: 00000000000000000000000001100000
            wait for 10 ns;

            -- Test für cmpe
            opcode <= "011000";
            A <= "00000000000000000000000000000110";
            B <= "00000000000000000000000000000110";
            immediate <= "00000000000000000000000000";
            cin <= '0';
            -- Erwartet: cout = "1"
            wait for 10 ns;

            -- Test für cmplt
            opcode <= "011011";
            A <= "00000000000000000000000000000100";
            B <= "00000000000000000000000000000110";
            immediate <= "00000000000000000000000000";
            cin <= '0';
            -- Erwartet: cout = "1"
            wait for 10 ns;

            -- Test für subi
            opcode <= "100010";
            A <= "00000000000000000000000000001100";
            B <= "00000000000000000000000000000000";
            immediate <= "00000000000000000000000100";
            cin <= '0';
            -- Erwartet: 00000000000000000000000000001000
            wait for 10 ns;

            -- Test für andi
            opcode <= "100011";
            A <= "00000000000000000000000000001100";
            B <= "00000000000000000000000000000000";
            immediate <= "00000000000000000000000111";
            cin <= '0';
            -- Erwartet: 00000000000000000000000000000100
            wait for 10 ns;

        end process;

    end architecture simulation;