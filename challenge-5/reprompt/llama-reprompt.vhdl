library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_register is
    Generic (n : integer); -- Specify the number of bits in the register
    Port ( clk : in std_logic; -- Clock input
           rst : in std_logic; -- Reset input
           dir : in std_logic; -- Shift direction: 0 for left, 1 for right
           data_in : in std_logic; -- Serial data input
           q : out std_logic_vector(n-1 downto 0)); -- Output vector of the 
register's contents
end entity shift_register;

architecture behavioral of shift_register is

    signal reg : unsigned(n-1 downto 0); -- The internal register value

begin

    process (clk, rst)
    begin
        if rst = '1' then
            reg <= (others => '0'); -- Reset the register to all zeros
        elsif rising_edge(clk) then
            if dir = '0' then -- Left shift
                reg <= (reg(n-2 downto 0) & data_in);
            else -- Right shift
                reg <= (data_in & reg(n-1 downto 1));
            end if;
        end if;
    end process;

    q <= std_logic_vector(reg); -- Convert the internal register value to a 
std_logic_vector and assign it to the output port

end architecture behavioral;
