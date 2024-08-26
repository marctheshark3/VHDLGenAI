-- File: generic_shift_register.vhd
-- Description: A generic n-bit shift register with configurable shift direction

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GenericShiftRegister is
    generic (
        N : positive := 8 -- Default width of the shift register
    );
    port (
        clk     : in std_logic; -- Clock signal
        reset   : in std_logic; -- Asynchronous reset
        enable  : in std_logic; -- Enable the shift operation
        dir     : in std_logic; -- Direction: '0' for left, '1' for right
        load    : in std_logic; -- Load signal to parallel load data
        data_in : in std_logic_vector(N-1 downto 0); -- Parallel input
        shift_in: in std_logic; -- Serial input for shifting
        data_out: out std_logic_vector(N-1 downto 0) -- Parallel output
    );
end GenericShiftRegister;

architecture Behavioral of GenericShiftRegister is
    signal sreg : std_logic_vector(N-1 downto 0);
begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset the shift register to all zeros
            sreg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                -- Parallel load operation
                sreg <= data_in;
            elsif enable = '1' then
                -- Shift operation enabled
                if dir = '0' then
                    -- Shift left: MSB is lost, LSB comes from shift_in
                    sreg <= sreg(N-2 downto 0) & shift_in;
                else
                    -- Shift right: LSB is lost, MSB comes from shift_in
                    sreg <= shift_in & sreg(N-1 downto 1);
                end if;
            end if; -- If neither load nor enable, sreg remains unchanged
        end if;
    end process;

    -- Output the current state of the shift register
    data_out <= sreg;

end Behavioral;

-- Notes on Design:
-- 1. **Generic Parameter**: The 'N' generic allows for configuring the bit width of 
--    the shift register at instantiation, making this design highly reusable.

-- 2. **Direction Control**: The 'dir' signal controls the direction of the shift. 
--    This flexibility is useful in various applications where both left and right 
--    shifts are necessary.

-- 3. **Load Capability**: The 'load' signal allows for parallel loading of data, 
--    which can be useful for initializing the register or for quick changes in state.

-- 4. **Enable**: The shift operation only occurs when 'enable' is high, allowing 
--    for control over when shifting happens.

-- 5. **Performance Considerations**:
--   - **Data Flow**: Data flows in based on the clock edge, with control signals 
--     determining whether data is loaded, shifted, or held.
--   - **Pipeline Stages**: While not explicitly pipelined in the traditional 
--     sense, each bit could be considered a stage for shifting operations. 
--     However, this design does not introduce additional latency beyond the 
--     clock cycle for operations due to its synchronous nature.

-- 6. **Scalability**: This design scales well with increasing 'N', though larger 
--    registers might require careful timing analysis to ensure they meet setup 
--    and hold times across all FPGA or ASIC technologies.

-- 7. **Usage**: This component can be used in serial communication protocols, 
--    data alignment, or as part of more complex digital systems like CPUs or 
--    cryptographic hardware where shift operations are frequent.
