library ieee;
use ieee.std_logic_1164.all;

entity generic_shift_register is
    generic (
        n : natural := 8
    );
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        shift   : in std_logic; -- 0 for left shift, 1 for right shift
        data_in : in std_logic_vector(n-1 downto 0);
        data_out: out std_logic_vector(n-1 downto 0)
    );
end entity generic_shift_register;

architecture behavioral of generic_shift_register is
begin
    process (clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                data_out <= (others => '0');
            else
                if shift = '0' then -- Left shift
                    data_out <= data_in(n-2 downto 0) & data_in(n-1);
                else -- Right shift
                    data_out <= data_in(0) & data_in(n-1 downto 1);
                end if;
            end if;
        end if;
    end process;
end architecture behavioral;
