library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port(   opcode : in  std_logic_vector(5 downto 0);
            A,B : in std_logic_vector(31 downto 0);
            immediate : in std_logic_vector(25 downto 0);
            cin : in std_logic;

            cout : out std_logic;
            result : out std_logic_vector(31 downto 0) );

end entity ALU;

architecture verhalten of decoder is
begin
    P1 : process (opcode, A, B, immediate, cin) is
    variable temp : std_logic_vector(32 downto 0);
    begin
        case opcode is
            -- mov : R[z] = R[x]
            when "000000" => result <= A;
                
            -- addu : R[z] = R[x] + R[y]
            when "000001" => 
                temp <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
                result <= temp(31 downto 0);
                cout <=temp(32)

            -- addc : R[z] = R[x] + R[y] + c
            when "000010" => 
                temp <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B) + unsigned(cin));
                result <= temp(31 downto 0);
                cout <=temp(32)

            -- subu : R[z] = R[x] - R[y]
            when "000011" =>
                result <= std_logic_vector(unsigned(A) - unsigned(B));
                cout <= (unsigned(A) < unsigned(B))?1:0; 


            -- and : R[z] = R[x] AND R[y]
            when "000100" => result <= A AND B;

            -- or : R[z] = R[x] OR R[y]
            when "000101" => result <= A OR B;

            -- xor : R[z] = R[x] XOR R[y]
            when "000110" => result <= A XOR B;

            -- not : R[z] = NOT R[x]
            when "000111" => result <= not A;

            --  nand : R[z] = R[x] NAND R[y]
            when "001000" => result <= not (A AND B);

            -- nor : R[z] = R[x] NOR R[y]
            when "001001" => result <= not (A OR B);
                
            -- nxor : R[z] = R[x] NXOR R[y]
            when "001010" => result <= not (A XOR B);
                
            -- max : R[z] = max(R[x],R[y])
            when "001011" =>
                if unsigned(A) < unsigned(B) then
                    result <= B;
                else
                    result <= A;
                end if;
                
            -- min : R[z] = min(R[x],R[y])    
            when "001100" =>
            if unsigned(A) < unsigned(B) then
                result <= A;
            else
                result <= B;
            end if;

            --??
            when "001101" => null;

            --??
            when "001110" => null;

            -- lsl16 : R[z] = R[x] << 16
            when "001111" => result <= A sll 16

            -- lsr16 : R[z] = R[x] >>> 16
            when "010000" =>

            -- asr16 : R[z] = R[x] >> 16
            when "010001" =>

            -- lsl4 : R[z] = R[x] << 4
            when "010010" =>

            -- lsr4 : R[z] = R[x] >>> 4
            when "010011" =>

            -- asr4 : R[z] = R[x] >> 4
            when "010100" =>

            -- lsl1 : R[z] = R[x] << 1
            when "010101" =>

            -- lsr1 : R[z] = R[x] >>> 1
            when "010110" =>

            -- asr1 : R[z] = R[x] >> 1
            when "010111" =>

            -- cmpe : C = (R[x] == R[y])
            when "011000" => cout <= (unsigned(A) = unsigned(B));
            
            -- cmpne : C = (R[x] != R[y])
            when "011001" => cout <= (unsigned(A) /= unsigned(B));

            -- cmpgt : C = (R[x] > R[y])
            when "011010" => cout <= (unsigned(A) > unsigned(B));

            -- cmplt : C = (R[x] < R[y])
            when "011011" => cout <= (unsigned(A) < unsigned(B));

            -- cmpgte : C = (R[x] >= R[y])
            when "011100" => cout <= (unsigned(A) => unsigned(B));

            -- cmplte : C = (R[x] <= R[y])
            when "011101" => cout <= (unsigned(A) <= unsigned(B));
            
            --
            when "100000" =>  

            -- 
            when "100001" =>  

            -- 
            when "100010" =>

            -- 
            when "100011" =>

            -- 
            when "100100" =>

            -- 
            when "100101" =>

            -- 
            when "100111" =>
            
            -- 
            when "101000" =>

            -- default
            when others => null;

        end case;
    end process;
end architecture;