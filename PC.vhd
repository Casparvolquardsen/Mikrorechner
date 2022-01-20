library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(   clk         : in std_logic;
            opcode      : in  std_logic_vector(5 downto 0);
            PCIn, X     : in std_logic_vector(31 downto 0);
            immediate   : in std_logic_vector(25 downto 0);
            cin         : in std_logic;

            PCOut,PCSave : out std_logic_vector(31 downto 0);
            PCShort : out std_logic_vector(15 downto 0));
end entity PC;

architecture verhalten of PC is
begin
    P1 : process(clk) is
    variable oneAdress : integer := 1;
    variable temp : std_logic_vector(31 downto 0);
    begin
        If rising_edge(clk) then
            PCOut <= (others => 'U');
            PCSave <= (others => 'U');
            case opcode is
                -- br : PC = PC +1+{imm26}
                when "111000" =>    
                    temp := std_logic_vector(unsigned(PCIn) - (2* oneAdress) + unsigned(immediate));

                -- jsr : R[15] = PC+1; PC = PC+1+{imm26} (call)
                when "111001" =>    
                    temp   := std_logic_vector(unsigned(PCIn) - (2* oneAdress) + unsigned(immediate));
                    PCSave  <= std_logic_vector(unsigned(PCIn) + oneAdress);

                -- bt : (c=1) ? PC = PC+1+{imm26} : PC=PC+1
                when "111010" => 
                    if cin = '1' then
                        temp   := std_logic_vector(unsigned(PCIn) - (2* oneAdress) + unsigned(immediate));
                    else
                        temp   := std_logic_vector(unsigned(PCIn) + oneAdress);
                    end if;

                -- bf : (c=0) ? PC = PC+2+{imm26} : PC=PC+2
                when "111011" => 
                    if cin = '0' then
                        temp   := std_logic_vector(unsigned(PCIn) - (2* oneAdress) + unsigned(immediate));
                    else
                        temp   := std_logic_vector(unsigned(PCIn) + oneAdress);
                    end if;

                --jmp : PC = R[x]
                when "111100" =>    
                    temp := X;

                -- default
                when others => 
                    temp := std_logic_vector(unsigned(PCIn) + oneAdress);
            end case;
            PCOut <= temp;
            PCShort <= temp(15 downto 0);
        end if;
    end process;
end architecture;
