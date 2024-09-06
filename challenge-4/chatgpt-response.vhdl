-- VHDL Design of a 4-Stage Pipeline Multiplier
-- The pipeline multiplier divides the multiplication process into four stages to improve throughput.
-- Each stage performs part of the computation and passes data to the next stage.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Entity Declaration
-- Inputs:
-- - CLK: Clock signal to synchronize the pipeline stages.
-- - RESET: Reset signal to initialize the pipeline.
-- - A, B: 8-bit inputs to be multiplied.
-- Outputs:
-- - PRODUCT: 16-bit output product of A and B.
entity PipelineMultiplier is
    Port ( CLK     : in  STD_LOGIC;            -- Clock signal
           RESET   : in  STD_LOGIC;            -- Reset signal
           A, B    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit inputs
           PRODUCT : out STD_LOGIC_VECTOR(15 downto 0) -- 16-bit product
         );
end PipelineMultiplier;

-- Architecture Declaration
architecture Behavioral of PipelineMultiplier is

    -- Internal signals for the pipeline registers between stages.
    signal Stage1_A, Stage2_A, Stage3_A, Stage4_A : STD_LOGIC_VECTOR(7 downto 0);  -- Pipeline registers for input A
    signal Stage1_B, Stage2_B, Stage3_B, Stage4_B : STD_LOGIC_VECTOR(7 downto 0);  -- Pipeline registers for input B
    
    signal Stage2_Partial : STD_LOGIC_VECTOR(15 downto 0); -- Partial product from stage 2
    signal Stage3_Partial : STD_LOGIC_VECTOR(15 downto 0); -- Partial product from stage 3
    signal Stage4_Partial : STD_LOGIC_VECTOR(15 downto 0); -- Final product after stage 4

begin

    -- Process to handle the pipeline stages and data flow.
    Pipeline_Process : process(CLK, RESET)
    begin
        -- Asynchronous Reset: Initialize all pipeline stages and outputs on reset.
        if RESET = '1' then
            -- Reset the pipeline registers to zero.
            Stage1_A <= (others => '0');
            Stage1_B <= (others => '0');
            Stage2_A <= (others => '0');
            Stage2_B <= (others => '0');
            Stage2_Partial <= (others => '0');
            Stage3_A <= (others => '0');
            Stage3_B <= (others => '0');
            Stage3_Partial <= (others => '0');
            Stage4_A <= (others => '0');
            Stage4_B <= (others => '0');
            Stage4_Partial <= (others => '0');
            PRODUCT <= (others => '0');
            
        elsif rising_edge(CLK) then
            -- Pipeline Stage 1: Latch inputs A and B
            -- At this stage, the inputs A and B are latched and passed to Stage 2.
            Stage1_A <= A;  -- Latch input A into Stage 1
            Stage1_B <= B;  -- Latch input B into Stage 1
            
            -- Pipeline Stage 2: Perform partial multiplication and store intermediate result.
            -- This stage computes the partial product using the latched inputs from Stage 1.
            Stage2_A <= Stage1_A;  -- Propagate A to the next stage
            Stage2_B <= Stage1_B;  -- Propagate B to the next stage
            Stage2_Partial <= STD_LOGIC_VECTOR(unsigned(Stage1_A) * unsigned(Stage1_B)); -- Multiply A and B
            
            -- Pipeline Stage 3: Propagate the partial product to the next stage.
            -- In this stage, the partial product from Stage 2 is passed forward.
            Stage3_A <= Stage2_A;  -- Propagate A to the next stage
            Stage3_B <= Stage2_B;  -- Propagate B to the next stage
            Stage3_Partial <= Stage2_Partial;  -- Pass partial product to the next stage
            
            -- Pipeline Stage 4: Latch final product.
            -- This stage stores the final product, which is available at the output.
            Stage4_A <= Stage3_A;  -- Propagate A to the next stage
            Stage4_B <= Stage3_B;  -- Propagate B to the next stage
            Stage4_Partial <= Stage3_Partial;  -- Pass the partial product to the final stage
            
            -- Output the final product.
            PRODUCT <= Stage4_Partial;  -- Output the final result
        end if;
    end process Pipeline_Process;

end Behavioral;

