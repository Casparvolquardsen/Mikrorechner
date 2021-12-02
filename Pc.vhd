library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(   clk : in std_logic;
            opcode : in  std_logic_vector(5 downto 0);
            PCIn,X : in std_logic_vector(31 downto 0);
            immediate : in std_logic_vector(25 downto 0);
            cin : in std_logic;

            PCOut : out std_logic_vector(31 downto 0);
            PCSave : out std_logic_vector(31 downto 0);
            result : out std_logic_vector(31 downto 0);

end entity PC;

architecture verhalten of decoder is
begin
    P1 : process (clk) is
    variable oneAdress <= 1;
        case opcode is
            -- br : PC = PC +1+{imm26}
            when "111000" =>    PCOut <= std_logic_vector(unsigned(PCIn)  + oneAdress + unsigned(immediate));

            -- jsr : R[15] = PC+1; PC = PC+1+{imm26} (call)
            when "111001" =>    
                PCOut   <= std_logic_vector(unsigned(PCIn)  + oneAdress + unsigned(immediate));
                PCSave  <= std_logic_vector(unsigned(PCIn)  + oneAdress));
            -- bt : (c=1) ? PC = PC+1+{imm26} : PC=PC+1
            when "111010" =>    

            -- bf : (c=0) ? PC = PC+2+{imm26} : PC=PC+2
            when "111011" =>

            --jmp : PC = R[x]
            when "111100" =>

            -- default
            when others => null;
        end case;
    end process;
end architecture;