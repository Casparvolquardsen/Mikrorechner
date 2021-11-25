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
            -- mov : R[z] = R[y]
            when "000000" => null;
                
            -- addu : R[z] = R[x] + R[y]
            when "000001" => 
                temp <= std_logic_vector(unsigned(A) + unsigned(B));
                result <= temp(31 downto 0);
                cout <=temp(32)

            -- addc : R[z] = R[x] + R[y] + c
            when "000010" => 
                temp <= std_logic_vector(unsigned(A) + unsigned(B) + unsigned(cin));
                result <= temp(31 downto 0);
                cout <=temp(32)

            -- subu : R[z] = R[x] - R[y]
            when "000011" =>
                result <= std_logic_vector(unsigned(A) - unsigned(B));
                cout <= unsigned(A) < unsigned(B) 


            -- and : R[z] = R[x] AND R[y]
            when "000100" => temp <= A and B

            -- or : R[z] = R[x] OR R[y]
            when "000101" => temp <= A or B

            -- xor : R[z] = R[x] XOR R[y]
            when "000110" => temp <= A xor B

            -- not : R[z] = NOT R[x]
            when "000111" => temp <= 

            -- nxor : R[z] = R[x] NXOR R[y]
            when "001000" =>

            -- max : R[z] = max(R[x],R[y])
            when "001001" =>

            -- min : R[z] = min(R[x],R[y])
            when "001010" =>

            when "001011" =>

            when "001100" =>

            when "001101" =>

            when "001110" =>

            when "001111" =>

            when "010000" =>

            when "010001" =>

            when "010010" =>

            when "010011" =>

            when "010100" =>

            when "010101" =>

            when "010110" =>

            when "010111" =>

            when "011000" =>
            
            when "100000" =>  

            when "100001" =>  

            when "100010" =>

            when "100011" =>

            when "100100" =>

            when "100101" =>

            when "100111" =>
            
            when "101000" =>

            when others => null;

        end case;
    end process;
end architecture;