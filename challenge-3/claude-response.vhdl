-- Library declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration
entity traffic_light_controller is
    Port ( 
        clk : in STD_LOGIC;  -- Clock input
        reset : in STD_LOGIC;  -- Reset input
        red : out STD_LOGIC;  -- Red light output
        yellow : out STD_LOGIC;  -- Yellow light output
        green : out STD_LOGIC  -- Green light output
    );
end traffic_light_controller;

-- Architecture declaration
architecture Behavioral of traffic_light_controller is
    -- Define an enumerated type for the traffic light states
    type state_type is (S_RED, S_GREEN, S_YELLOW);
    
    -- Define signals for current state and next state
    signal current_state, next_state : state_type;
    
    -- Define a counter for timing
    signal counter : unsigned(3 downto 0) := (others => '0');
    
    -- Constants for timing (adjust these values as needed)
    constant RED_TIME : unsigned(3 downto 0) := to_unsigned(10, 4);  -- 10 clock cycles
    constant GREEN_TIME : unsigned(3 downto 0) := to_unsigned(8, 4);  -- 8 clock cycles
    constant YELLOW_TIME : unsigned(3 downto 0) := to_unsigned(3, 4);  -- 3 clock cycles

begin
    -- Process for state transitions and timing
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset the controller to the initial state (red)
            current_state <= S_RED;
            counter <= (others => '0');
        elsif rising_edge(clk) then
            -- Increment the counter
            counter <= counter + 1;
            
            -- Check if it's time to transition to the next state
            if (current_state = S_RED and counter = RED_TIME) or
               (current_state = S_GREEN and counter = GREEN_TIME) or
               (current_state = S_YELLOW and counter = YELLOW_TIME) then
                -- Transition to the next state and reset the counter
                current_state <= next_state;
                counter <= (others => '0');
            end if;
        end if;
    end process;

    -- Process for next state logic
    process(current_state)
    begin
        case current_state is
            when S_RED =>
                next_state <= S_GREEN;
            when S_GREEN =>
                next_state <= S_YELLOW;
            when S_YELLOW =>
                next_state <= S_RED;
        end case;
    end process;

    -- Process for output logic
    process(current_state)
    begin
        -- Set all outputs to '0' by default
        red <= '0';
        yellow <= '0';
        green <= '0';
        
        -- Set the appropriate output to '1' based on the current state
        case current_state is
            when S_RED =>
                red <= '1';
            when S_GREEN =>
                green <= '1';
            when S_YELLOW =>
                yellow <= '1';
        end case;
    end process;

end Behavioral;
