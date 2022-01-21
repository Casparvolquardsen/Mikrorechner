library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture simulation of testbench is
        signal clk                                  : std_logic;
        signal AShortRegBank, PCShort               : std_logic_vector(15 downto 0);
        signal wren_a, wren_b                       : std_logic;
        signal instructionRAM, wordRAM, BRegBank    : std_logic_vector(31 downto 0);


    component Processor is
        port(   
                clock_50                        : in std_logic;
                wordRAM, instructionRAM         : in std_logic_vector(31 downto 0);   -- read
                data_write                        : out std_logic_vector(31 downto 0);  -- write
                AShortRegBank, PCShort          : out std_logic_vector(15 downto 0);
                wren_a, wren_b                  : out std_logic
        );
    end component Processor;


    component RAM is
        port (
                address_a	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                address_b	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
                clock	: IN STD_LOGIC;
                data_a	: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                data_b	: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- don't care, read only for us
                wren_a	: IN STD_LOGIC  := '0';
                wren_b	: IN STD_LOGIC  := '0'; -- don't care, read only for us
                q_a		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- write 
                q_b		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) ); -- read/ instruction
    end component RAM;



    begin
        test : Processor port map(clk, wordRAM, instructionRAM, BRegBank, AShortRegBank, PCShort, wren_a, wren_b);
        testram: RAM port map(AShortRegBank, PCShort, clk, BRegBank, BRegBank, wren_a, wren_b, wordRAM, instructionRAM);

        process is
        begin    
                clk <= '0';
                wait for 5 ns;
                clk <='1';
                wait for 5 ns;
        end process;

end architecture simulation;