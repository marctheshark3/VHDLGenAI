-- VHDL Design of a 4-bit Adder using basic logic gates
-- The adder will compute the sum of two 4-bit inputs (A and B) and generate a carry-out signal (Cout).

-- Define the entity of the 4-bit adder
-- The entity includes two 4-bit inputs (A, B), a carry-in (Cin), 
-- and outputs for the 4-bit sum (Sum) and carry-out (Cout).
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FourBitAdder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input A
           B : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input B
           Cin : in STD_LOGIC;                     -- Carry-in
           Sum : out STD_LOGIC_VECTOR (3 downto 0);-- 4-bit sum output
           Cout : out STD_LOGIC);                  -- Carry-out signal
end FourBitAdder;

-- Architecture of the 4-bit adder, using full adder logic for each bit position.
architecture Behavioral of FourBitAdder is
    signal C : STD_LOGIC_VECTOR (4 downto 0);      -- Internal carry signal, C(0) to C(4)
begin
    -- Each full adder computes the sum of A(i), B(i), and carry from the previous stage.
    -- The carry-out of each full adder is passed to the next stage as the carry-in.
    
    -- Pipeline Stage 1: First bit addition (LSB)
    FullAdder0: process(A(0), B(0), Cin)
    begin
        Sum(0) <= A(0) XOR B(0) XOR Cin;           -- Sum of the LSB
        C(1) <= (A(0) AND B(0)) OR (Cin AND (A(0) XOR B(0)));  -- Carry out
    end process;
    
    -- Pipeline Stage 2: Second bit addition
    FullAdder1: process(A(1), B(1), C(1))
    begin
        Sum(1) <= A(1) XOR B(1) XOR C(1);          -- Sum of the second bit
        C(2) <= (A(1) AND B(1)) OR (C(1) AND (A(1) XOR B(1)));  -- Carry out
    end process;

    -- Pipeline Stage 3: Third bit addition
    FullAdder2: process(A(2), B(2), C(2))
    begin
        Sum(2) <= A(2) XOR B(2) XOR C(2);          -- Sum of the third bit
        C(3) <= (A(2) AND B(2)) OR (C(2) AND (A(2) XOR B(2)));  -- Carry out
    end process;

    -- Pipeline Stage 4: Fourth bit addition (MSB)
    FullAdder3: process(A(3), B(3), C(3))
    begin
        Sum(3) <= A(3) XOR B(3) XOR C(3);          -- Sum of the MSB
        C(4) <= (A(3) AND B(3)) OR (C(3) AND (A(3) XOR B(3)));  -- Final carry out
    end process;
    
    -- Final carry-out from the addition
    Cout <= C(4);                                  -- Carry-out for the 4-bit adder
    
end Behavioral;

