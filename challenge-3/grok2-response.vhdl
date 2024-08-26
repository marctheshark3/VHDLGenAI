-- File: traffic_light_controller.vhd
-- Description: A simple traffic light controller with three states: Red, Yellow, and Green

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController is
    Port (
        clk       : in std_logic; -- Clock signal for state transitions
        reset     : in std_logic; -- Reset to initialize the system
        red       : out std_logic; -- Red light indicator
        yellow    : out std_logic; -- Yellow light indicator
        green     : out std_logic; -- Green light indicator
        pedestrian : in std_logic  -- Input for pedestrian request (optional for this basic model)
    );
end TrafficLightController;

architecture Behavioral of TrafficLightController is
    -- Define the states of the traffic light
    type state_type is (RED_STATE, GREEN_STATE, YELLOW_STATE);
    signal current_state, next_state : state_type := RED_STATE;

    -- Counter for timing each state
    constant RED_TIME : integer := 5;    -- Time in clock cycles for red light
    constant GREEN_TIME : integer := 5;  -- Time for green light
    constant YELLOW_TIME : integer := 2; -- Time for yellow light
    signal count : integer range 0 to 5 := 0; -- Counter for state duration

begin

    -- State Transition Process
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= RED_STATE;
            count <= 0;
        elsif rising_edge(clk) then
            current_state <= next_state;
            if count = 0 then
                -- Reset counter when state changes or at end of count
                count <= RED_TIME when current_state = RED_STATE else
                         GREEN_TIME when current_state = GREEN_STATE else
                         YELLOW_TIME;
            else
                count <= count - 1;
            end if;
        end if;
    end process;

    -- Next State Logic
    process(current_state, count)
    begin
        case current_state is
            when RED_STATE =>
                if count = 0 then
                    next_state <= GREEN_STATE;
                else
                    next_state <= RED_STATE;
                end if;
            when GREEN_STATE =>
                if count = 0 then
                    next_state <= YELLOW_STATE;
                else
                    next_state <= GREEN_STATE;
                end if;
            when YELLOW_STATE =>
                if count = 0 then
                    next_state <= RED_STATE;
                else
                    next_state <= YELLOW_STATE;
                end if;
        end case;
    end process;

    -- Output Logic
    process(current_state)
    begin
        -- Default outputs: all lights off
        red    <= '0';
        yellow <= '0';
        green  <= '0';

        case current_state is
            when RED_STATE    => red    <= '1';
            when GREEN_STATE  => green  <= '1';
            when YELLOW_STATE => yellow <= '1';
        end case;
    end process;

end Behavioral;

-- Notes on Design:
-- 1. **State Machine**: The controller uses a simple state machine with three states. 
--    Each state represents one light condition.

-- 2. **Timing**: Each light's duration is controlled by a counter. The constants 
--    (RED_TIME, GREEN_TIME, YELLOW_TIME) define how many clock cycles each light 
--    should stay on, which can be adjusted for real-world timing.

-- 3. **Data Flow**: The state transitions are controlled by the clock and the count 
--    reaching zero, ensuring predictable and synchronous operation.

-- 4. **Pipeline Stages**: While not explicitly pipelined in the traditional sense, 
--    the design uses a two-process model for state machines in VHDL:
--    - One process for synchronous elements (state transitions and counter).
--    - Another for combinational logic (next state logic and output decoding).
--    This separation can be thought of as a form of pipelining for state machine design.

-- 5. **Performance**: 
--   - **Simplicity**: This design is straightforward, making it easy to understand 
--     and maintain, but might not account for complex scenarios like pedestrian 
--     crossings or emergency vehicle preemption without further modification.
--   - **Scalability**: The design can be easily modified to include more states or 
--     different timings by adjusting the state machine and constants.

-- 6. **Reset**: An asynchronous reset is included to ensure the system starts in a 
--    known state (RED_STATE).

-- 7. **Optional Pedestrian Input**: The 'pedestrian' signal is included for future 
--    expansion, where it could influence state transitions or timing, although 
--    it's not utilized in this basic version.
