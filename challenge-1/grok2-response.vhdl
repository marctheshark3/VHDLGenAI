-- File: four_bit_adder.vhd
-- Description: A 4-bit ripple carry adder implemented using basic logic gates

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FourBitAdder is
    Port (
        A    : in  std_logic_vector(3 downto 0); -- 4-bit input A
        B    : in  std_logic_vector(3 downto 0); -- 4-bit input B
        Cin  : in  std_logic;                    -- Carry in
        Sum  : out std_logic_vector(3 downto 0); -- Sum output
        Cout : out std_logic                     -- Carry out
    );
end FourBitAdder;

architecture Behavioral of FourBitAdder is
    -- Intermediate signals for carry between bits
    signal c1, c2, c3 : std_logic;
    
    -- Full adder component declaration
    component FullAdder is
        Port (
            x, y, cin : in  std_logic;
            sum, cout : out std_logic
        );
    end component;

begin

    -- Instantiate four full adders for each bit of the 4-bit adder
    FA0: FullAdder port map (A(0), B(0), Cin, Sum(0), c1);
    FA1: FullAdder port map (A(1), B(1), c1,  Sum(1), c2);
    FA2: FullAdder port map (A(2), B(2), c2,  Sum(2), c3);
    FA3: FullAdder port map (A(3), B(3), c3,  Sum(3), Cout);

end Behavioral;

-- Full adder implementation using basic logic gates
architecture GateLevel of FullAdder is
begin
    -- Sum = x XOR y XOR cin
    sum <= (x xor y) xor cin;
    
    -- Carry out = (x AND y) OR (cin AND (x XOR y))
    cout <= (x and y) or (cin and (x xor y));
end GateLevel;

-- Notes on Design:
-- 1. **Ripple Carry Adder**: This design uses a ripple carry approach where the carry 
--    from one full adder is used as the carry-in for the next. This leads to a simple 
--    design but increases propagation delay as the bit width grows.

-- 2. **Component Instantiation**: The design uses a component for a full adder, 
--    which is then instantiated four times, once for each bit.

-- 3. **Data Flow**: 
--   - Inputs A and B flow into each full adder along with the carry from the previous stage.
--   - The sum for each bit is calculated independently, but the carry flows from LSB to MSB.

-- 4. **Pipeline Stages**: 
--   - This design does not use explicit pipeline stages as it's a combinational circuit. 
--     However, in terms of logical flow, you could consider each full adder as a stage 
--     where the carry propagates through.

-- 5. **Performance**: 
--   - **Propagation Delay**: The main performance concern here is the carry propagation delay, 
--     which is linear with respect to the number of bits. For a 4-bit adder, this delay is 
--     relatively small, but it becomes significant for larger adders.
--   - **Area**: Uses minimal logic gates for each bit, making it area-efficient for small bit widths.

-- 6. **Scalability**: While this adder can be easily extended for more bits, for larger numbers, 
--    consider using carry look-ahead adders or other advanced adder architectures for better 
--    performance due to reduced carry propagation delay.

-- 7. **Usage**: Suitable for applications where speed is not critical or where the adder is 
--    part of a larger system where the ripple carry delay can be tolerated or mitigated through 
--    pipelining in the broader context.
