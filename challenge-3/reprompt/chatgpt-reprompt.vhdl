library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity Declaration
entity TrafficLightController is
    Port ( CLK    : in  STD_LOGIC;     -- Clock signal input
           RESET  : in  STD_LOGIC;     -- Reset signal input
           RED    : out STD_LOGIC;     -- Output for Red light
           GREEN  : out STD_LOGIC;     -- Output for Green light
           YELLOW : out STD_LOGIC);    -- Output for Yellow light
end TrafficLightController;

-- Architecture Declaration
architecture Behavioral of TrafficLightController is
    -- Define an enumerated type to represent the three traffic light states.
    type State_Type is (Red_State, Green_State, Yellow_State);
    signal Current_State, Next_State : State_Type;  -- Signals for current and next states
    
    -- Define a counter to manage the time spent in each state (acting as a timer).
    signal Counter : INTEGER := 0;
    
    -- Constants for the duration of each light state (in clock cycles).
    constant RED_TIME    : INTEGER := 50;   -- Duration for red light
    constant GREEN_TIME  : INTEGER := 50;   -- Duration for green light
    constant YELLOW_TIME : INTEGER := 20;   -- Duration for yellow light
    
begin

    -- Process to handle state transitions and state output logic
    TrafficLight_Process : process(CLK, RESET)
    begin
        -- Asynchronous Reset: Initialize the traffic light to red when RESET is active.
        if RESET = '1' then
            Current_State <= Red_State;  -- Set state to red on reset
            Counter <= 0;                 -- Reset counter
        elsif rising_edge(CLK) then      -- On the rising edge of the clock
            if Counter < RED_TIME and Current_State = Red_State then
                Counter <= Counter + 1;  -- Increment counter while in red state
            elsif Counter < GREEN_TIME and Current_State = Green_State then
                Counter <= Counter + 1;  -- Increment counter while in green state
            elsif Counter < YELLOW_TIME and Current_State = Yellow_State then
                Counter <= Counter + 1;  -- Increment counter while in yellow state
            else
                -- Time for state transition
                case Current_State is
                    when Red_State =>
                        Next_State <= Green_State; -- Move to green state
                        Counter <= 0;              -- Reset counter
                    when Green_State =>
                        Next_State <= Yellow_State; -- Move to yellow state
                        Counter <= 0;              -- Reset counter
                    when Yellow_State =>
                        Next_State <= Red_State; -- Move to red state
                        Counter <= 0;            -- Reset counter
                    when others =>
                        Next_State <= Red_State;  -- Default case (should not occur)
                end case;
            end if;
            
            Current_State <= Next_State; -- Move to the next state based on timer
        end if;
    end process TrafficLight_Process;

    -- Output logic to control the traffic light signals based on the current state
    OutputLogic_Process : process(Current_State)
    begin
        -- Default all lights to off
        RED <= '0';
        GREEN <= '0';
        YELLOW <= '0';
        
        -- Turn on the corresponding light for the current state
        case Current_State is
            when Red_State =>
                RED <= '1';  -- Red light is on
            when Green_State =>
                GREEN <= '1'; -- Green light is on
            when Yellow_State =>
                YELLOW <= '1'; -- Yellow light is on
            when others =>
                RED <= '1';   -- Default state is red
        end case;
    end process OutputLogic_Process;

end Behavioral;
