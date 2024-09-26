library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFlipFlopWithEnable is
    Port ( D   : in STD_LOGIC;
           CLK : in STD_LOGIC;
           EN  : in STD_LOGIC;
           Q   : out STD_LOGIC);
end DFlipFlopWithEnable;

architecture Behavioral of DFlipFlopWithEnable is
    signal Reg_D, Next_State : std_logic;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if EN = '1' then
                Reg_D <= D;
            end if;
        end if;
    end process;

    Q <= Reg_D;
end Behavioral;
