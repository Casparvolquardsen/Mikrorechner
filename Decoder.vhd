library ieee;
use ieee.std_logic_1164.all;
use  ieee.numeric_std.all;

entity decoder is
    port(   instruction : in  std_logic_vector(31 downto 0) := "11111100000000000000000000000000";

            opcode      : out std_logic_vector(5 downto 0);
            registerX   : out std_logic_vector(3 downto 0);
            registerY   : out std_logic_vector(3 downto 0);
            registerZ   : out std_logic_vector(3 downto 0);
            Zwren       : out std_logic;
            immediate   : out std_logic_vector(25 downto 0) );
    
end entity decoder;

architecture verhalten of decoder is

begin
    P1: process (instruction) is 
    begin
        opcode <= instruction(31 downto 26);
        immediate <= (others => '0');
        registerX <= (others => '0');
        registerY <= (others => '0');
        registerZ <= (others => '0');
        Zwren <= '0'; -- write enable register Z is default false

        case opcode is
            -- ALU-Commands --
            -- mov : R[z] = R[x]
            when "000000" => 
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';
            -- addu : R[z] = R[x] + R[y]
            when "000001" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- addc : R[z] = R[x] + R[y] + c
            when "000010" =>
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- subu : R[z] = R[x] - R[y]
            when "000011" =>
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- and : R[z] = R[x] AND R[y]
            when "000100" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- or : R[z] = R[x] OR R[y]
            when "000101" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- xor : R[z] = R[x] XOR R[y]
            when "000110" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- not : R[z] = NOT R[x]
            when "000111" => 
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            --  nand : R[z] = R[x] NAND R[y]
            when "001000" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- nor : R[z] = R[x] NOR R[y]
            when "001001" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';
                
            -- nxor : R[z] = R[x] NXOR R[y]
            when "001010" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';
                
            -- max : R[z] = max(R[x],R[y])
            when "001011" =>
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';
                
            -- min : R[z] = min(R[x],R[y])    
            when "001100" =>
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- Shift-Commands --
            -- lsl16 : R[z] = R[x] << 16
            when "001111" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- lsr16 : R[z] = R[x] >>> 16
            when "010000" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- asr16 : R[z] = R[x] >> 16
            when "010001" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- lsl4 : R[z] = R[x] << 4
            when "010010" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- lsr4 : R[z] = R[x] >>> 4
            when "010011" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';
            
            -- asr4 : R[z] = R[x] >> 4
            when "010100" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- lsl1 : R[z] = R[x] << 1
            when "010101" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- lsr1 : R[z] = R[x] >>> 1
            when "010110" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- asr1 : R[z] = R[x] >> 1
            when "010111" =>    
                registerX <= instruction(25 downto 22);
                registerZ <= instruction(17 downto 14);
                Zwren <= '1';

            -- Compare-Commands --
            -- cmpe : C = (R[x] == R[y])
            when "011000" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
            
            -- cmpne : C = (R[x] != R[y])
            when "011001" =>
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
                
            -- cmpgt : C = (R[x] > R[y])
            when "011010" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
            
            -- cmplt : C = (R[x] < R[y])
            when "011011" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
            

            -- cmpgte : C = (R[x] >= R[y])
            when "011100" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
            

            -- cmplte : C = (R[x] <= R[y])
            when "011101" => 
                registerX <= instruction(25 downto 22);
                registerY <= instruction(21 downto 18);
            
            -- Immediate-Commands --
            -- movi : R[z] = I
            when "100000" =>  
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- addi : R[z] = R[z] + I
            when "100001" =>  
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- subi : R[z] = R[z] - I
            when "100010" =>
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- andi : R[z] = R[z] AND I
            when "100011" =>    
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- lsli : R[z] = R[z] << I
            when "100100" =>    
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- lsri : R[z] = R[z] >>> I
            when "100101" =>    
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);

            -- bseti : R[z] = R[z]  |  (1 << I) (set bit)
            when "100111" =>    
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);
            
            -- bclri : R[z] = R[z]  & !(1 << I) (clear bit)
            when "101000" =>  
                -- X and Z are the same Register
                registerX <= instruction(25 downto 22); 
                registerZ <= instruction(25 downto 22);
                Zwren <= '1';
                -- Immediate value are the other 22-Bits
                immediate(21 downto 0) <= instruction(21 downto 0);  

            -- Memory-Commands
            -- ldw : R[z] = MEM(R[x])
            when "110000" =>
                registerX <= instruction(25 downto 22);
                -- the register to load to
                registerZ <= instruction(21 downto 18);
                Zwren <= '1';

            -- stw : MEM(R[x]) = R[y]
            when "110000" =>
                registerX <= instruction(25 downto 22);
                -- the Register to store
                registerY <= instruction(21 downto 18);
            
            -- Control-Commands
            -- br : PC = PC +1+{imm26}
            when "110000" =>
                immediate <= instruction(25 downto 0);
            
            -- jsr : R[15] = PC+1; PC = PC+1+{imm26} (call)
            when "110000" =>
                registerZ = '1111' -- register 15 is for jsr
                Zwren <= '1';
                immediate <= instruction(25 downto 0);
            
            -- bt : (c=1) ? PC = PC+1+{imm26} : PC=PC+1
            when "110000" =>
                immediate <= instruction(25 downto 0);
            
            -- bf : (c=0) ? PC = PC+1+{imm26} : PC=PC+1
            when "110000" =>
                immediate <= instruction(25 downto 0);
            
            -- jmp : PC = R[x]
            when "110000" =>
                registerX <= instruction(25 downto 22);
            
            -- halt : halt
            when "110000" => null;
            -- nop : 
            when "110000" => null;
            -- default
            when others => null;

        end case;

    end process;
end architecture verhalten;