library IEEE;
use IEEE.STD_LOGIC;
use IEEE.NUMERIC_STD.ALL;

entity TrafficLightController is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end TrafficLightController;

architecture Behavioral of TrafficLightController is

    -- Define the states: red, green, and yellow
    type States is (RED, GREEN, YELLOW);

    -- Define the current state
    signal currentState : States := RED;

begin
    -- The clock signal will be used to control the traffic light's timing
    process(clk)
    begin
        if rising_edge(clk) then
            -- If reset is high, set the initial state back to red
            if reset = '1' then
                currentState <= RED;
            else
                case currentState is
                    when RED =>
                        -- Transition from red to yellow after a certain delay (e.g., 2 seconds)
                        if std_logic_vector( unsigned(currentState) + 1 ) = "110" then
                            currentState <= YELLOW;
                        end if;

                    when YELLOW =>
                        -- Transition from yellow back to green after another delay (e.g., 3 seconds)
                        if std_logic_vector( unsigned(currentState) + 1 ) = "111" then
                            currentState <= GREEN;
                        end if;

                    when GREEN =>
                        -- Transition from green back to red after a final delay (e.g., 4 seconds)
                        if std_logic_vector( unsigned(currentState) + 1 ) = "1000" then
                            currentState <= RED;
                        end if;
                end case;
            end if;
        end if;
    end process;

    -- Output the current state
    process(currentState)
    begin
        case currentState is
            when RED =>
                report "RED" severity note;
            when GREEN =>
                report "GREEN" severity note;
            when YELLOW =>
                report "YELLOW" severity note;
        end case;
    end process;

end Behavioral;