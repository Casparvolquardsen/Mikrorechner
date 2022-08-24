library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FPGA is
        port(
                clk : in std_logic;
                key : in std_logic_vector(1 downto 0);
                dip : in std_logic_vector(3 downto 0);

                led : out std_logic_vector(7 downto 0) 
        );
end entity FPGA;

architecture verhalten of FPGA is
        signal AShortRegBank, PCShort               : std_logic_vector(10 downto 0);
        signal wren_a, wren_b                       : std_logic;
        signal instructionRAM, wordRAM, BRegBank    : std_logic_vector(31 downto 0);


    component Processor is
        port(   
                clock_50                        : in std_logic;
                wordRAM, instructionRAM         : in std_logic_vector(31 downto 0);   -- read
                key                             : in std_logic_vector(1 downto 0);
                dip                             : in std_logic_vector(3 downto 0);
                
                led                             : out std_logic_vector(7 downto 0);
                data_write                      : out std_logic_vector(31 downto 0);  -- write
                AShortRegBank, PCShort          : out std_logic_vector(10 downto 0);
                wren_a, wren_b                  : out std_logic
        );
    end component Processor;


    component RAM is
        port (
                address_a	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
                address_b	: IN STD_LOGIC_VECTOR (10 DOWNTO 0);
                clock	        : IN STD_LOGIC;
                data_a	        : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
                data_b	        : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- don't care, read only for us
                wren_a	        : IN STD_LOGIC  := '0';
                wren_b	        : IN STD_LOGIC  := '0'; -- don't care, read only for us
                q_a		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- write 
                q_b		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0) ); -- read/ instruction
    end component RAM;



    begin
        test : Processor port map(clk, wordRAM, instructionRAM, key, dip, led, BRegBank, AShortRegBank, PCShort, wren_a, wren_b);
        testram: RAM port map(AShortRegBank, PCShort, clk, BRegBank, BRegBank, wren_a, wren_b, wordRAM, instructionRAM);

        

end architecture verhalten;
