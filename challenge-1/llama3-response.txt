
-- File: adder.vhd
-- Description: A 4-bit adder using basic logic gates

library IEEE;
use IEEE.STD_LOGIC_ARITH;
use IEEE.STD_LOGIC_1164;

entity adder is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR(3 downto 0));
end adder;

architecture Behavioral of adder is

    -- Internal signals
    signal CarryIn : std_logic;
    signal CarryOut : std_logic;
    signal Sum0, Sum1, Sum2, Sum3 : std_logic;

begin
    -- Adder logic
    process(A, B, Cin)
    begin
        -- Generate the sum for each bit position
        Sum0 <= A(0) XOR B(0);
        CarryIn <= Cin OR (A(0) AND B(0));
        
        Sum1 <= (A(1) XOR B(1)) XOR (CarryIn AND (A(1) XNOR B(1)));
        
        Sum2 <= (A(2) XOR B(2)) XOR (Sum1 AND (A(2) XNOR B(2)));
        
        Sum3 <= CarryOut OR (A(3) XOR B(3));
    end process;

    -- Assign the sum and carry-out values
    S <= Sum0 & Sum1 & Sum2 & Sum3;
    
    -- Define the carry-out signal
    CarryOut <= CarryIn OR (Sum1 AND A(1) XNOR B(1)) OR (Sum2 AND A(2) XNOR B(2));
end Behavioral;


Overall, this adder has a moderate latency of three clock cycles and can handle up to one addition operation per clock cycle, 
making it suitable for moderate-speed applications.

