## Challenge 5: Parameterized Design Entity

In this challenge, you will create a generic n-bit shift register with configurable shift direction. The goal is to design a shift register that can be easily adapted to different bit widths and shift directions.

### Description

The shift register is a fundamental component in digital electronics and is used in a wide range of applications, from data processing to communication protocols. A shift register can be used to store and shift data in either direction (left or right) based on a control signal.

The goal of this challenge is to create a generic shift register that can be configured to work with different bit widths and shift directions. This is achieved by using a generic parameter in the entity declaration.

### Requirements

- The shift register should be able to handle different bit widths.
- The shift register should be able to perform both left and right shifts based on a control signal.
- The shift register should be able to load data in parallel or serial.

### Design

To create a generic shift register, you will need to define an entity with a generic parameter `N` that represents the bit width of the register. The entity should have the following ports:

- `clk`: The clock signal that controls the shift operation.
- `rst`: The reset signal that resets the shift register to all zeros.
- `dir`: The shift direction control signal.
- `data_in`: The input data that can be shifted into the register.
- `load`: The parallel load signal.
- `shift_in`: The serial input data.
- `data_out`: The output vector of the shift register's contents.

The architecture should be behavioral. You will need to define a process that is sensitive to the clock and reset signals. The process should handle the following cases:

- Reset: The shift register is reset to all zeros.
- Parallel Load: The contents of the shift register are loaded from the input data.
- Shift Operation: The shift register shifts its contents based on the shift direction.

### Example

Here's an example of how the entity and architecture could be defined:

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_shift_register is
    generic (
        N : positive := 8 -- Default width of the shift register (default is 8-bit)
    );
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        dir     : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        load    : in std_logic;
        shift_in: in std_logic;
        data_out: out std_logic_vector(N-1 downto 0)
    );
end entity generic_shift_register;

architecture behavioral of generic_shift_register is
    signal sreg : std_logic_vector(N-1 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            sreg <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                sreg <= data_in;
            elsif dir = '0' then
                sreg <= sreg(N-2 downto 0) & shift_in;
            else
                sreg <= shift_in & sreg(N-1 downto 1);
            end if;
        end if;
    end process;

    data_out <= sreg;
end behavioral;
```

### Evaluation

The shift register will be evaluated based on its correct functionality for different bit widths and shift directions.

### Tips and Considerations

- Use a professional tone, as you are an expert in the VHDL coding language. Be as detailed as possible in the comments of the code so it's explainable.
- Consider the performance and timing considerations for the shift register.
- Ensure that the shift register can handle different bit widths and shift directions.
