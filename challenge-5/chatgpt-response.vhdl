-- VHDL Design of a Generic n-bit Shift Register with Configurable Shift Direction
-- The shift register can shift its contents either left or right depending on the direction control signal.
-- The width of the shift register (n) is configurable using a generic parameter.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity Declaration
-- Inputs:
-- - CLK: Clock signal to drive the shift operation.
-- - RESET: Reset signal to initialize the register contents.
-- - SHIFT_EN: Enable signal to control when the register shifts.
-- - DIR: Shift direction control (0 = shift left, 1 = shift right).
-- - DATA_IN: Input data that can be shifted into the register.
-- Outputs:
-- - DATA_OUT: Output showing the current contents of the register.
entity ShiftRegister is
    generic ( N : integer := 8 ); -- Generic parameter for the width of the shift register (default 8-bit)
    Port ( CLK      : in  STD_LOGIC;                       -- Clock signal
           RESET    : in  STD_LOGIC;                       -- Reset signal
           SHIFT_EN : in  STD_LOGIC;                       -- Shift enable signal
           DIR      : in  STD_LOGIC;                       -- Shift direction (0 = left, 1 = right)
           DATA_IN  : in  STD_LOGIC;                       -- Serial input data
           DATA_OUT : out STD_LOGIC_VECTOR(N-1 downto 0)   -- Parallel output of the shift register
         );
end ShiftRegister;

-- Architecture Declaration
architecture Behavioral of ShiftRegister is
    -- Internal signal to store the contents of the shift register.
    signal Reg : STD_LOGIC_VECTOR(N-1 downto 0);
begin
    -- Process to handle the shifting and reset behavior.
    Shift_Process : process(CLK, RESET)
    begin
        -- Asynchronous Reset: Initialize the shift register to zero on reset.
        if RESET = '1' then
            Reg <= (others => '0');  -- Reset all register bits to 0
            
        -- Shift operation on the rising edge of the clock.
        elsif rising_edge(CLK) then
            -- Shift only when SHIFT_EN (Shift Enable) is high.
            if SHIFT_EN = '1' then
                -- Check the shift direction.
                if DIR = '0' then
                    -- Shift left (logical shift left): Shift all bits to the left and insert DATA_IN at LSB.
                    Reg <= Reg(N-2 downto 0) & DATA_IN; -- Concatenate shifted data with DATA_IN at LSB
                else
                    -- Shift right (logical shift right): Shift all bits to the right and insert DATA_IN at MSB.
                    Reg <= DATA_IN & Reg(N-1 downto 1); -- Concatenate DATA_IN at MSB with shifted data
                end if;
            end if;
        end if;
    end process Shift_Process;

    -- Assign the internal register value to the DATA_OUT output.
    DATA_OUT <= Reg;

end Behavioral;

