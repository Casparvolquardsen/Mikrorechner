library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is 
    port(clock_50 : in std_logic);
end Processor;

architecture verhalten of Processor is
    signal instructionRAM,instructionIReg,PCOut,ARegBank, PCSave, BRegBank,CMux, result, wordRAM : std_logic_vector(31 downto 0);
    signal AShortRegBank, PCShort: std_logic_vector(15 downto 0);
    signal opcodeDecoder, opcodeReg, opcodeReg2: std_logic_vector(5 downto 0);
    signal immediateDecoder, immediateReg : std_logic_vector(25 downto 0);
    signal carryAlu, wren_a, wren_b: std_logic;
    signal registerXDecoder,registerYDecoder,registerZDecoder,registerZReg : std_logic_vector(3 downto 0);


    component PC is
        port(
            clk         : in std_logic;
            opcode      : in  std_logic_vector(5 downto 0);
            PCIn, X     : in std_logic_vector(31 downto 0);
            immediate   : in std_logic_vector(25 downto 0);
            cin         : in std_logic;
    
            PCOut,PCSave : out std_logic_vector(31 downto 0);
            PCShort : out std_logic_vector(15 downto 0));
    end component PC;

    component IRegister is
    port(  
        clk : in  std_logic;
        InstructionIn : in std_logic_vector(31 downto 0);
        InstructionOut : out std_logic_vector(31 downto 0) );
    end component IRegister;

    component decoder is
        port(   instruction                     : in  std_logic_vector(31 downto 0);
                opcode                          : out std_logic_vector(5 downto 0);
                registerX,registerY,registerZ   : out std_logic_vector(3 downto 0);
                immediate                       : out std_logic_vector(25 downto 0) );
    
    end component decoder;

    component RegisterZ is
        port(  
            clk : in  std_logic;
            Zin : in std_logic_vector(3 downto 0);
            Zout : out std_logic_vector(3 downto 0) );
    end component RegisterZ;

    component regbank is
        port(  
            clk : in std_logic;
            x,y,z: in std_logic_vector(3 downto 0);
            C,PCIn : in std_logic_vector(31 downto 0);
            A,B : out std_logic_vector(31 downto 0);
            AShort : out std_logic_vector(15 downto 0));
    end component regbank;

    component RegisterImm is
        port(  
            clk : in  std_logic;
            Immin : in std_logic_vector(25 downto 0);
            Immout : out std_logic_vector(25 downto 0) );
    end component RegisterImm;

    component RegisterOp is
        port(  
            clk : in  std_logic;
            OPin : in std_logic_vector(5 downto 0);
            OPout : out std_logic_vector(5 downto 0) );
    end component RegisterOp;

    component ALU is
        port(   
            opcode : in  std_logic_vector(5 downto 0);
            A,B : in std_logic_vector(31 downto 0);
            immediate : in std_logic_vector(25 downto 0);
            cin : in std_logic;

            cout : out std_logic;
            result : out std_logic_vector(31 downto 0) );
    end component ALU;

    component MUX is
        port(   
            opcode      : in std_logic_vector(5 downto 0);
            result, word   : in std_logic_vector(31 downto 0) ;
            C   : out std_logic_vector(31 downto 0) );
    end component MUX;

    component RAM is
        port (
            address_a	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            address_b	: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            clock		: IN STD_LOGIC;
            data_a		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            data_b		: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- don't care, read only for us
            wren_a		: IN STD_LOGIC  := '0';
            wren_b		: IN STD_LOGIC  := '0'; -- don't care, read only for us
            q_a		    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            q_b		    : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) );
    end component RAM;

    component wren is
        port (
            opcode  : in std_logic_vector(5 downto 0);
            wren_a    : out std_logic;
            wren_b    : out std_logic );
        end component wren;

    begin
        c0: PC port map(clock_50,opcodeReg,PCOut,ARegBank,immediateReg,carryAlu,PCOut,PCSave,PCShort);
        c1: IRegister port map(clock_50, instructionRAM, instructionIReg);
        c2: decoder port map(instructionIReg,opcodeDecoder,registerXDecoder,registerYDecoder,registerZDecoder,immediateDecoder);
        c3: RegisterZ port map(clock_50, registerZDecoder, registerZReg);
        c4: regbank port map(clock_50,RegisterXDecoder,RegisterYDecoder,registerZReg,CMux,PCSave,ARegBank,BRegBank,AShortRegBank);
        c5: RegisterImm port map(clock_50, immediateDecoder, immediateReg);
        c6: RegisterOp port map(clock_50, opcodeDecoder, opcodeReg);
        c7: ALU port map(opcodeReg, ARegBank, BRegBank, immediateReg, carryAlu, carryAlu, result);
        c8: wren port map(opcodeReg, wren_a, wren_b);
        c9: RegisterOp port map(clock_50, opcodeReg, opcodeReg2);
        c10: MUX port map(opcodeReg2,result,wordRAM,CMux);
        c11: RAM port map(AShortRegBank, PCShort, clock_50, BRegBank, BRegBank, wren_a, wren_b, instructionRAM, wordRAM);
end architecture;