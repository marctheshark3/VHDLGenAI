library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
    generic (
        N : positive := 8 -- Default width of the shift register (default is 8-bit)
    );
    port (
        clk : in std_logic; -- Clock signal
        rst : in std_logic; -- Reset signal
        dir : in std_logic; -- Shift direction (0 for left, 1 for right)
        data_in : in std_logic; -- Serial input data
        q : out std_logic_vector(N-1 downto 0) -- Output vector of the shift register's contents
    );
end entity ShiftRegister;

architecture Behavioral of ShiftRegister is
    signal sreg : std_logic_vector(N-1 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            sreg <= (others => '0'); -- Reset the shift register to all zeros
        elsif rising_edge(clk) then
            if dir = '0' then
                -- Shift left: MSB is lost, LSB comes from data_in
                sreg <= sreg(N-2 downto 0) & data_in;
            else
                -- Shift right: LSB is lost, MSB comes from data_in
                sreg <= data_in & sreg(N-1 downto 1);
            end if;
        end if;
    end process;

    -- Output the current state of the shift register
    q <= sreg;
end Behavioral;
