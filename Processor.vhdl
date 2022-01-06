library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is 
port( clock_50 : in std_logic

);
end Processor;
architecture verhalten of Processor is
    signal instructionRAM,instructionIReg,PCOut,ARegBank,PCSave,BRegBan,CMux, result, wordRAM : std_logic_vector(31 downto 0);
    signal opcodeDecoder, opcodeReg: std_logic_vector(5 downto 0);
    signal immediateDecoder, immediateReg : std_logic_vector(25 downto 0);
    signal carryAlu : std_logic;
    signal registerXDecoder,registerYDecoder,registerZDecoder,registerZReg : std_logic_vector(3 downto 0);


    component PC is
        port(
            clk         : in std_logic;
            opcode      : in  std_logic_vector(5 downto 0);
            PCIn, X     : in std_logic_vector(31 downto 0);
            immediate   : in std_logic_vector(25 downto 0);
            cin         : in std_logic;
    
            PCOut,PCSave : out std_logic_vector(31 downto 0));
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
            A,B : out std_logic_vector(31 downto 0));
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
        port(   opcode : in  std_logic_vector(5 downto 0);
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
        port(
            opcode : in std_logic_vector(5 downto 0);
            instructionAddress, adress, wordIn : in std_logic_vector(31 downto 0);

            instructionOut, wordOut : out std_logic_vector(31 downto 0));
    end component RAM;

    begin
        c0: PC port map(clock_50,opcodeDecoder,PCOut,ARegBank,immediateDecoder,carryAlu,PCOut,PCSave);
        c1: IRegister port map(clock_50, instructionRAM, instructionIReg);
        c2: decoder port map(instructionIReg,opcodeDecoder,registerXDecoder,registerYDecoder,registerZDecoder,immediateDecoder);
        c3: RegisterZ port map(clock_50, registerZDecoder, registerZReg);
        c4: regbank port map(clock_50,RegisterXDecoder,RegisterYDecoder,registerZReg,CMux,PCSave,ARegBank,BRegBank);
        c5: RegisterImmediate port map(clock_50, immediateDecoder, immediateReg);
        c6: RegisterOp port map(clock_50, opcodeDecoder, opcodeReg);
        c7: ALU port map(opcodeReg, ARegBank, BRegBank, immediateReg, carryAlu, carryAlu, result);
        c8: MUX port map(opcodeReg,result,wordRAM,CMux);
        c9: RAM port map(opcodeReg,PCOut,result,BRegBank,instructionRAM,wordRAM);
end architecture;