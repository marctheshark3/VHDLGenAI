library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_controller is
  port (
    clk        : in  std_logic;
    reset      : in  std_logic;
    red_out    : out std_logic;
    yellow_out : out std_logic;
    green_out  : out std_logic
  );
end entity traffic_light_controller;

architecture behavioral of traffic_light_controller is
  -- Define the state type and counter
  type state_type is (red, yellow, green);
  signal state : state_type;
  signal counter : integer range 0 to 100; -- Adjust the counter range as needed

begin
  process (clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        state <= red;
        counter <= 0;
      else
        case state is
          when red =>
            if counter = 100 then -- Adjust the counter value for red state duration
              state <= yellow;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
          when yellow =>
            if counter = 20 then -- Adjust the counter value for yellow state duration
              state <= green;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
          when green =>
            if counter = 100 then -- Adjust the counter value for green state duration
              state <= red;
              counter <= 0;
            else
              counter <= counter + 1;
            end if;
        end case;
      end if;
    end if;
  end process;

  -- Assign outputs based on the current state
  red_out    <= '1' when state = red else '0';
  yellow_out <= '1' when state = yellow else '0';
  green_out  <= '1' when state = green else '0';
end architecture behavioral;
