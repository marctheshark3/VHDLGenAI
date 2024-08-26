library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
    generic (
        N : positive := 8  -- Default width of 8 bits, can be overridden
    );
    port (
        clk      : in  std_logic;  -- Clock input
        reset    : in  std_logic;  -- Asynchronous reset
        enable   : in  std_logic;  -- Enable shifting
        dir      : in  std_logic;  -- Shift direction: '0' for right, '1' for left
        data_in  : in  std_logic;  -- Serial input data
        data_out : out std_logic_vector(N-1 downto 0)  -- Parallel output
    );
end shift_register;

architecture Behavioral of shift_register is
    signal shift_reg : std_logic_vector(N-1 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Asynchronous reset: clear the register
            shift_reg <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                -- Shifting is enabled
                if dir = '0' then
                    -- Shift right
                    shift_reg <= data_in & shift_reg(N-1 downto 1);
                else
                    -- Shift left
                    shift_reg <= shift_reg(N-2 downto 0) & data_in;
                end if;
            end if;
            -- Note: If enable is '0', the register retains its current value
        end if;
    end process;

    -- Connect internal shift register to output
    data_out <= shift_reg;

end Behavioral;
