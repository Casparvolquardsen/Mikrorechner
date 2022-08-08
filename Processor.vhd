library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is 
    port(
        clock_50                    : in std_logic;
        wordRAM, instructionRAM     : in std_logic_vector(31 downto 0);
        key                         : in std_logic_vector(1 downto 0);   
        dip                         : in std_logic_vector(3 downto 0);
        
        led                         : out std_logic_vector(7 downto 0);
        data_write                  : out std_logic_vector(31 downto 0);
        AShortRegBank, PCShort      : out std_logic_vector(15 downto 0);
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
            opcode      : in std_logic_vector(5 downto 0);
            PCIn, X     : in std_logic_vector(31 downto 0);
            immediate   : in std_logic_vector(25 downto 0);
            cin         : in std_logic;
            key         : in std_logic_vector(1 downto 0);
    
            PCOut,PCSave : out std_logic_vector(31 downto 0);
            PCShort : out std_logic_vector(15 downto 0));
    end component PC;

    component IRegister is
    port(  
        clk : in  std_logic;
        InstructionIn : in std_logic_vector(31 downto 0);
        reset       : in std_logic;
        InstructionOut : out std_logic_vector(31 downto 0) );
    end component IRegister;

    component ResultRegister is
        port(  
            clk : in  std_logic;
            result : in std_logic_vector(31 downto 0);
            reset       : in std_logic;
            resultReg : out std_logic_vector(31 downto 0) );
    end component ResultRegister;

    component decoder is
        port(   instruction                     : in  std_logic_vector(31 downto 0);
                opcode                          : out std_logic_vector(5 downto 0);
                registerX,registerY,registerZ   : out std_logic_vector(3 downto 0);
                Zwren                           : out std_logic;
                immediate                       : out std_logic_vector(25 downto 0) );
    end component decoder;

    component RegisterZ is
        port(  
            clk : in  std_logic;
            Zin : in std_logic_vector(3 downto 0);
            reset : in std_logic;
            Zout : out std_logic_vector(3 downto 0) );
    end component RegisterZ;

    component regbank is
        port(  
            clk : in std_logic;
            x,y,z : in std_logic_vector(3 downto 0);
            Zwren : in std_logic;
            C : in std_logic_vector(31 downto 0);
            reset : in std_logic;
            dips : in std_logic_vector(3 downto 0);
            led : out std_logic_vector(7 downto 0);
            X,Y : out std_logic_vector(31 downto 0);
            AShort : out std_logic_vector(15 downto 0));
    end component regbank;

    component RegisterImmediate is
        port(  
            clk : in  std_logic;
            Immin : in std_logic_vector(25 downto 0);
            reset       : in std_logic;
            Immout : out std_logic_vector(25 downto 0) );
    end component RegisterImmediate;

    component RegisterOp is
        port(  
            clk : in  std_logic;
            OPin : in std_logic_vector(5 downto 0);
            reset       : in std_logic;
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
            opcode : in std_logic_vector(5 downto 0);
            result, load_data, PCSave : in std_logic_vector(31 downto 0) ;
            C : out std_logic_vector(31 downto 0) );
    end component MUX;
    
    component wren is
        port (
            opcode : in std_logic_vector(5 downto 0);
            wren_a : out std_logic;
            wren_b : out std_logic );
    end component wren;

    component CarryBitRegister is 
        port(
            clk : in  std_logic;
            CarryIn : in std_logic;
            reset       : in std_logic;
            CarryOut : out std_logic
        );
    end component CarryBitRegister;

    component WriteEnableZRegister is
        port(   
            clk : in std_logic;
            WriteEnableZIn : in std_logic;
            reset : in std_logic;
    
            WriteEnableZOut : out std_logic 
        );
    end component WriteEnableZRegister;

    begin
        PC_component: PC port map(clock_50,opcodeReg,PCOut,ARegBank,immediateReg,carryReg,key,PCOut,PCSave,PCShort);
        InstructionReg_component: IRegister port map(clock_50, instructionRAM, key(0), instructionIReg);
        Decoder_component: decoder port map(instructionIReg,opcodeDecoder,registerXDecoder,registerYDecoder,registerZDecoder,ZwrenDecoder,immediateDecoder);
        ZReg1_component: RegisterZ port map(clock_50, registerZDecoder, key(0), registerZReg);
        ZReg2_component: RegisterZ port map(clock_50, registerZReg, key(0), registerZ2Reg);
        WrenZReg1_component: WriteEnableZRegister port map(clock_50, ZwrenDecoder, key(0), WrenZReg1);
        WrenZReg1_component: WriteEnableZRegister port map(clock_50, WrenZReg1, key(0), WrenZReg2);
        Regbank_component: regbank port map(clock_50,RegisterXDecoder,RegisterYDecoder,registerZ2Reg,WrenZReg2,CMux,key(0), dip, led, ARegBank,BRegBank, AShortRegBank);
        ImmReg_component: RegisterImmediate port map(clock_50, immediateDecoder, key(0), immediateReg);
        OpReg_component: RegisterOp port map(clock_50, opcodeDecoder, key(0), opcodeReg);
        ALU_component: ALU port map(opcodeReg, ARegBank, BRegBank, immediateReg, carryReg, carryAlu, result);
        CarryBitRegister_component: CarryBitRegister port map(clock_50, carryAlu, key(0), carryReg);
        ResultReg_component: ResultRegister port map(clock_50, result, key(0), resultReg);
        WREN_component: wren port map(opcodeReg, wren_a, wren_b);
        OpReg2_component: RegisterOp port map(clock_50, opcodeReg, key(0), opcode2Reg);
        MUXRamAlu_component: MUX port map(opcode2Reg,resultReg,wordRAM,PCSave,CMux);
        
        data_write <= BRegBank;
end architecture;