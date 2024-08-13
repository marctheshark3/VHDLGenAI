-- IEEE library for standard logic types
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for D flip-flop with enable
entity d_ff_with_enable is
    Port ( 
        D     : in  STD_LOGIC;  -- Data input
        CLK   : in  STD_LOGIC;  -- Clock input
        EN    : in  STD_LOGIC;  -- Enable input
        RST   : in  STD_LOGIC;  -- Asynchronous reset
        Q     : out STD_LOGIC   -- Output
    );
end d_ff_with_enable;

-- Architecture definition
architecture Behavioral of d_ff_with_enable is
begin
    -- Process sensitive to clock and reset
    process(CLK, RST)
    begin
        -- Check for asynchronous reset
        if RST = '1' then
            -- If reset is active, set output to '0'
            Q <= '0';
        -- Check for rising edge of clock
        elsif rising_edge(CLK) then
            -- If enable is active
            if EN = '1' then
                -- On rising clock edge with enable, output takes input value
                Q <= D;
            end if;
            -- If enable is not active, output retains its previous value
        end if;
    end process;
end Behavioral;
