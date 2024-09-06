-- VHDL Design of a Synchronous D Flip-Flop with Enable Input
-- This flip-flop captures the input data (D) on the rising edge of the clock 
-- if the enable signal (EN) is high. If enable is low, the output (Q) remains unchanged.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Define the entity of the D Flip-Flop with enable.
-- The entity includes inputs for data (D), clock (CLK), and enable (EN), 
-- and outputs the stored value (Q) and its inverse (Qn).
entity DFlipFlopWithEnable is
    Port ( D   : in  STD_LOGIC;  -- Data input (D)
           CLK : in  STD_LOGIC;  -- Clock input (CLK)
           EN  : in  STD_LOGIC;  -- Enable input (EN)
           Q   : out STD_LOGIC;  -- Output (Q)
           Qn  : out STD_LOGIC); -- Inverted output (Qn)
end DFlipFlopWithEnable;

-- Architecture: Behavioral modeling of the D Flip-Flop.
architecture Behavioral of DFlipFlopWithEnable is
begin
    -- Process that triggers on the rising edge of the clock.
    -- This ensures synchronous behavior.
    FlipFlop_Process : process(CLK)
    begin
        -- Check for rising edge of the clock.
        if rising_edge(CLK) then
            -- Enable is checked to determine whether the flip-flop should update.
            if EN = '1' then
                -- When EN is high, capture the data on D and store it in Q.
                Q <= D;
            end if;
        end if;
        
        -- The inverted output Qn is continuously updated based on Q.
        Qn <= not Q;
    end process FlipFlop_Process;
    
end Behavioral;

