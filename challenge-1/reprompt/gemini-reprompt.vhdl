library ieee;
use ieee.std_logic_1164.all;

-- Definition of the full adder entity and architecture
entity full_adder is
  port (
    a      : in  std_logic;
    b      : in  std_logic;
    cin    : in  std_logic;
    sum    : out std_logic;
    cout   : out std_logic
  );
end entity full_adder;

architecture behavioral of full_adder is
begin
  sum    <= a xor b xor cin;
  cout   <= (a and b) or (a and cin) or (b and cin);
end architecture behavioral;

-- Definition of the four-bit adder entity and architecture
entity four_bit_adder is
  port (
    input_a : in  std_logic_vector(3 downto 0);
    input_b : in  std_logic_vector(3 downto 0);
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
        a      => input_a(i),
        b      => input_b(i),
        cin    => carry(i),
        sum    => sum(i),
        cout   => carry(i + 1)
      );
  end generate;

  -- Assign the final carry to the carry_out signal
  carry_out <= carry(3);
end architecture behavioral;
