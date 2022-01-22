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

architecture verhalten of ALU is
begin
    P1 : process (opcode, A, B, immediate, cin) is
    variable temp : std_logic_vector(32 downto 0);
    constant setBit : std_logic_vector(31 downto 0) := "00000000000000000000000000000001";
    constant zero31 : std_logic_vector(30 downto 0) := "0000000000000000000000000000000";
    cout <= '0';
    begin
        cout <= cin;
        result <= (others => 'U');
        case opcode is
            -- mov : R[z] = R[x]
            when "000000" => 
                result <= A;
                
            -- addu : R[z] = R[x] + R[y]
            when "000001" => 
                temp := std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
                result <= temp(31 downto 0);
                cout <= temp(32);

            -- addc : R[z] = R[x] + R[y] + c
            when "000010" =>
                temp := std_logic_vector(unsigned('0' & A) + unsigned('0' & B) + unsigned(zero31 & cin));
                result <= temp(31 downto 0);
                cout <=temp(32);

            -- subu : R[z] = R[x] - R[y]
            when "000011" =>
                result <= std_logic_vector(unsigned(A) - unsigned(B));
                if (unsigned(A) < unsigned(B)) then
                    cout <= '1';
                else
                    cout <= '0';
                end if; 


            -- and : R[z] = R[x] AND R[y]
            when "000100" => 
                result <= A AND B;

            -- or : R[z] = R[x] OR R[y]
            when "000101" => 
                result <= A OR B;

            -- xor : R[z] = R[x] XOR R[y]
            when "000110" => 
                result <= A XOR B;

            -- not : R[z] = NOT R[x]
            when "000111" => 
                result <= not A;

            --  nand : R[z] = R[x] NAND R[y]
            when "001000" => 
                result <= not (A AND B);

            -- nor : R[z] = R[x] NOR R[y]
            when "001001" => 
                result <= not (A OR B);
                
            -- nxor : R[z] = R[x] NXOR R[y]
            when "001010" => 
                result <= not (A XOR B);
                
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
            when "001111" =>    
                result <= std_logic_vector(shift_left(unsigned(A), 16));

            -- lsr16 : R[z] = R[x] >>> 16
            when "010000" =>    
                result <= std_logic_vector(shift_right(signed(A), 16));

            -- asr16 : R[z] = R[x] >> 16
            when "010001" =>    
                result <= std_logic_vector(shift_right(unsigned(A), 16));

            -- lsl4 : R[z] = R[x] << 4
            when "010010" =>    
                result <= std_logic_vector(shift_left(unsigned(A), 4));

            -- lsr4 : R[z] = R[x] >>> 4
            when "010011" =>    
                result <= std_logic_vector(shift_right(signed(A), 4));

            -- asr4 : R[z] = R[x] >> 4
            when "010100" =>    
                result <= std_logic_vector(shift_right(unsigned(A), 4));

            -- lsl1 : R[z] = R[x] << 1
            when "010101" =>    
                result <= std_logic_vector(shift_left(unsigned(A), 1));

            -- lsr1 : R[z] = R[x] >>> 1
            when "010110" =>    
                result <= std_logic_vector(shift_right(signed(A), 1));

            -- asr1 : R[z] = R[x] >> 1
            when "010111" =>    
                result <= std_logic_vector(shift_right(unsigned(A), 1));

            -- cmpe : C = (R[x] == R[y])
            when "011000" => 
                if unsigned(A) = unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;
            
            -- cmpne : C = (R[x] != R[y])
            when "011001" =>
                if unsigned(A) /= unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;

            -- cmpgt : C = (R[x] > R[y])
            when "011010" => 
                if unsigned(A) > unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;

            -- cmplt : C = (R[x] < R[y])
            when "011011" => 
                if unsigned(A) < unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;

            -- cmpgte : C = (R[x] >= R[y])
            when "011100" => 
                if unsigned(A) >= unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;

            -- cmplte : C = (R[x] <= R[y])
            when "011101" => 
                if unsigned(A) <= unsigned(B) then
                    cout <= '1';
                else
                    cout <= '0';
                end if ;
            
            -- movi : R[z] = c
            when "100000" =>  
                result <= (others => '0');
                result(25 downto 0) <= immediate;

            -- addi : R[z] = R[z] + c
            when "100001" =>  
                temp := std_logic_vector(unsigned('0' & A) + unsigned(immediate));
                result <= temp(31 downto 0);
                cout <=temp(32);

            -- subi : R[z] = R[z] - c
            when "100010" =>
                temp := std_logic_vector(unsigned('0' & A) - unsigned(immediate));
                result <= temp(31 downto 0);
                cout <=temp(32);

            -- andi : R[z] = R[z] AND c
            when "100011" =>    
                result <= A AND ("000000" & immediate);

            -- lsli : R[z] = R[z] << c
            when "100100" =>    
                result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(immediate))));

            -- lsri : R[z] = R[z] >>> c
            when "100101" =>    
                result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(immediate))));

            -- bseti : R[z] = R[z]  |  (1 << c) (set bit)
            when "100111" =>    
                result <= A OR std_logic_Vector(shift_left(unsigned(setBit), to_integer(unsigned(immediate))));
            
            -- bclri : R[z] = R[z]  & !(1 << c) (clear bit)
            when "101000" =>    
                result <= A AND std_logic_Vector(shift_left(unsigned(setBit), to_integer(unsigned(immediate))));

            -- default
            when others => null;

        end case;
    end process;
end architecture;