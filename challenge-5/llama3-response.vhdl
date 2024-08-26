library IEEE;
use IEEE.STD_LOGIC;
use IEEE.NUMERIC_STD.ALL;

entity shift_register is
    Generic (n : integer);
    Port ( clk : in std_logic;
           rst : in std_logic;
           dir  : in std_logic; -- 0: left shift, 1: right shift
           data_in : in std_logic_vector(n-1 downto 0);
           q     : out std_logic_vector(n-1 downto 0));
end entity shift_register;

architecture behavioral of shift_register is

    signal reg : unsigned(n-1 downto 0);

begin

    process (clk, rst)
    begin
        if rst = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if dir = '0' then -- Left shift
                reg <= (reg(n-2 downto 0) & data_in(0));
            else -- Right shift
                reg <= (data_in(0) & reg(n-1 downto 1));
            end if;
        end if;
    end process;

    q <= std_logic_vector(reg);

end architecture behavioral;
