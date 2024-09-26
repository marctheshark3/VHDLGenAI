library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TrafficLightController is
    Port ( CLK    : in  STD_LOGIC;
           RESET  : in  STD_LOGIC;
           RED    : out STD_LOGIC;
           GREEN  : out STD_LOGIC;
           YELLOW : out STD_LOGIC);
end TrafficLightController;

architecture Behavioral of TrafficLightController is
    -- Define the states: red, green, and yellow
    type State_Type is (RED_STATE, GREEN_STATE, YELLOW_STATE);
    signal Current_State, Next_State : State_Type := RED_STATE;

    -- Define the current state
    signal Counter : INTEGER := 0;

    -- Constants for the duration of each light state (in clock cycles)
    constant RED_TIME    : INTEGER := 50;   -- Duration for red light
    constant GREEN_TIME  : INTEGER := 50;   -- Duration for green light
    constant YELLOW_TIME : INTEGER := 20;   -- Duration for yellow light

begin
    -- Process to handle state transitions and state output logic
    TrafficLight_Process : process(CLK, RESET)
    begin
        if RESET = '1' then
            Current_State <= RED_STATE;
            Counter <= 0;
        elsif rising_edge(CLK) then
            if Counter = 0 then
                -- Reset counter when entering a new state or when count reaches zero
                case Current_State is
                    when RED_STATE =>
                        Counter <= RED_TIME;
                    when GREEN_STATE =>
                        Counter <= GREEN_TIME;
                    when YELLOW_STATE =>
                        Counter <= YELLOW_TIME;
                end case;
            else
                Counter <= Counter - 1;
            end if;

            -- Update the current state based on the current state and the counter
            if Counter = 0 then
                case Current_State is
                    when RED_STATE =>
                        Next_State <= GREEN_STATE;
                    when GREEN_STATE =>
                        Next_State <= YELLOW_STATE;
                    when YELLOW_STATE =>
                        Next_State <= RED_STATE;
                end case;
            end if;

            Current_State <= Next_State;
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
            when RED_STATE =>
                RED <= '1';
            when GREEN_STATE =>
                GREEN <= '1';
            when YELLOW_STATE =>
                YELLOW <= '1';
        end case;
    end process OutputLogic_Process;
end Behavioral;
