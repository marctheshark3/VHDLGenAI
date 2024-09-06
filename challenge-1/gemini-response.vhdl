library ieee;
use ieee.std_logic_1164.all;

entity four_bit_adder is
    port (
        input_a : in std_logic_vector(3 downto 0);
        input_b : in std_logic_vector(3 downto 0);
        sum     : out std_logic_vector(4 downto 0);
        carry_out: out std_logic
    );
end entity four_bit_adder;

architecture behavioral of four_bit_adder is
    -- Declare signals for intermediate values
    signal carry : std_logic_vector(3 downto 0);

begin
    -- Generate the sum and carry for each bit using full adders
    generate_sum_carry: for i in 0 to 3 generate
        full_adder: entity work.full_adder
            port map (
                a         => input_a(i),
                b         => input_b(i),
                cin       => carry(i),
                sum       => sum(i),
                cout      => carry(i + 1)
            );
    end generate;

    -- Assign the final carry to the carry_out signal
    carry_out <= carry(3);
end architecture behavioral;
