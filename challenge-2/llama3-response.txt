-- File: d_flip_flop.vhd
-- Description: A synchronous D flip-flop with an enable input
library IEEE;
use IEEE.STD_LOGIC_ARITH;
use IEEE.STD_LOGIC_1164;

entity d_flip_flop is
    Port ( D : in STD_LOGIC;
           E : in STD_LOGIC;  -- Enable input
           Clock : in STD_LOGIC;
           Q : out STD_LOGIC;
           Q_not : out STD_LOGIC);
end d_flip_flop;

architecture Behavioral of d_flip_flop is

    -- Internal signals
    signal Reg_D, Next_State : std_logic;
begin
    -- Flip-flop logic
    process(Clock)
    begin
        if rising_edge(Clock) then  -- Synchronous clock edge
            if E = '1' then  -- Enable the flip-flop when E is high
                Reg_D <= D;  -- Store the new value in the register
            end if;
        end if;
    end process;

    -- Assign output values
    Q <= Reg_D;
    Q_not <= not Reg_D;
end Behavioral;

