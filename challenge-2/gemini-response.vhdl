library ieee;
use ieee.std_logic_1164.all;

entity d_flip_flop_with_enable is
    port (
        d       : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        q       : out std_logic;
        q_bar   : out std_logic
    );
end entity d_flip_flop_with_enable;

architecture behavioral of d_flip_flop_with_enable is
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                q <= d;
            end if;
        end if;
    end process;

    -- Assign the complement of q
    q_bar <= not q;
end architecture behavioral;
