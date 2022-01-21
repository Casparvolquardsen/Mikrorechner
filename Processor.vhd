library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is 
    port(
        clock_50                    : in std_logic;
        wordRAM, instructionRAM    : in std_logic_vector(31 downto 0);   
        
        data_write                    : out std_logic_vector(31 downto 0);
        AShortRegBank, PCShort        : out std_logic_vector(15 downto 0);
        wren_a, wren_b              : out std_logic
    );
end Processor;

architecture verhalten of Processor is
    signal instructionIReg,PCOut,ARegBank, PCSave, BRegBank, CMux, result, resultReg : std_logic_vector(31 downto 0);
    signal opcodeDecoder, opcodeReg, opcode2Reg: std_logic_vector(5 downto 0);
    signal immediateDecoder, immediateReg : std_logic_vector(25 downto 0);
    signal carryAlu: std_logic;
    signal registerXDecoder,registerYDecoder,registerZDecoder,registerZReg, registerZ2Reg : std_logic_vector(3 downto 0);


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

    component ResultRegister is
        port(  
            clk : in  std_logic;
            result : in std_logic_vector(31 downto 0);
            resultReg : out std_logic_vector(31 downto 0) );
    end component ResultRegister;

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

    component RegisterImmediate is
        port(  
            clk : in  std_logic;
            Immin : in std_logic_vector(25 downto 0);
            Immout : out std_logic_vector(25 downto 0) );
    end component RegisterImmediate;

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
        c4: RegisterZ port map(clock_50, registerZReg, registerZ2Reg);
        c5: regbank port map(clock_50,RegisterXDecoder,RegisterYDecoder,registerZ2Reg,CMux,PCSave,ARegBank,BRegBank,AShortRegBank);
        c6: RegisterImmediate port map(clock_50, immediateDecoder, immediateReg);
        c7: RegisterOp port map(clock_50, opcodeDecoder, opcodeReg);
        c8: ALU port map(opcodeReg, ARegBank, BRegBank, immediateReg, carryAlu, carryAlu, result);
        c9: ResultRegister port map(clock_50, result, resultReg);
        c10: wren port map(opcodeReg, wren_a, wren_b);
        c11: RegisterOp port map(clock_50, opcodeReg, opcode2Reg);
        c12: MUX port map(opcode2Reg,resultReg,wordRAM,CMux);
        
        data_write <= BRegBank;
end architecture;