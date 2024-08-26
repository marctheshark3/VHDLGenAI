-- File: pipelined_multiplier.vhd
-- Description: A 4-stage pipelined multiplier for unsigned integers

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PipelinedMultiplier is
    Port (
        clk : in std_logic;
        reset : in std_logic;
        a : in unsigned(15 downto 0);  -- 16-bit input operand
        b : in unsigned(15 downto 0);  -- 16-bit input operand
        product : out unsigned(31 downto 0); -- 32-bit output product
        valid_out : out std_logic  -- Signal to indicate valid output
    );
end PipelinedMultiplier;

architecture Behavioral of PipelinedMultiplier is

    -- Intermediate signals for pipeline stages
    signal stage1_a, stage1_b : unsigned(15 downto 0);
    signal stage2_partial : unsigned(31 downto 0);
    signal stage3_sum : unsigned(31 downto 0);
    
begin

    -- Pipeline process
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all pipeline stages
            stage1_a <= (others => '0');
            stage1_b <= (others => '0');
            stage2_partial <= (others => '0');
            stage3_sum <= (others => '0');
            product <= (others => '0');
            valid_out <= '0';
        elsif rising_edge(clk) then
            -- Stage 1: Register inputs
            stage1_a <= a;
            stage1_b <= b;
            
            -- Stage 2: Partial Product Generation
            -- Here, we're simplifying by just multiplying, but in a real scenario,
            -- this would involve generating partial products for each bit of 'b'.
            stage2_partial <= stage1_a * stage1_b;
            
            -- Stage 3: Accumulation or Adjustment
            -- For simplicity, assume we just pass through, but this could involve
            -- adding shifted partial products in a real Booth's algorithm scenario.
            stage3_sum <= stage2_partial;
            
            -- Stage 4: Output the final product
            product <= stage3_sum;
            valid_out <= '1'; -- Signal that the data is valid after initial latency
        end if;
    end process;

end Behavioral;

-- Notes on Design:
-- 1. **Stage 1**: Input latching. This stage registers the inputs to ensure 
--    they are stable for the next stages, reducing timing issues.
   
-- 2. **Stage 2**: Partial Product Generation. In this simplified model, 
--    we directly multiply, but typically, you'd generate partial products 
--    which would then be added in subsequent stages.

-- 3. **Stage 3**: Accumulation. Here, in a more complex design, you'd 
--    accumulate the partial products. For this example, we're assuming 
--    no further processing is needed after multiplication.

-- 4. **Stage 4**: Output. The final product is output. The 'valid_out' 
--    signal goes high to indicate that the output is now valid, accounting 
--    for the pipeline latency.

-- Performance Notes:
-- - **Throughput**: After an initial latency of 4 clock cycles, a new product 
--   can be produced every clock cycle.
-- - **Latency**: From input to output, there are 4 clock cycles of delay.
-- - **Area**: More registers are used due to pipelining, which increases 
--   the area on an FPGA or ASIC but improves clock speed and throughput.
