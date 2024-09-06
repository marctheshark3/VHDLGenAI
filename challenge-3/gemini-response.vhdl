library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_controller is
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        red_out : out std_logic;
        yellow_out : out std_logic;
        green_out : out std_logic
    );
end entity traffic_light_controller;

architecture behavioral of traffic_light_controller is
    -- Define the state type
    type state_type is (red, yellow, green);
    signal state : state_type;

begin
    process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= red;
            else
                case state is
                    when red =>
                        state <= yellow;
                    when yellow =>
                        state <= green;
                    when green =>
                        state <= red;
                end case;
            end if;
        end if;
    end process;

    -- Assign outputs based on the current state
    red_out <= '1' when state = red else '0';
    yellow_out <= '1' when state = yellow else '0';
    green_out <= '1' when state = green else '0';
end architecture behavioral;
