library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0);
           B : in STD_LOGIC_VECTOR(3 downto 0);
           Cin : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR(3 downto 0);
           CarryOut : out STD_LOGIC);
end adder;

architecture Behavioral of adder is

    signal CarryIn : std_logic;
    signal Sum0, Sum1, Sum2, Sum3 : std_logic;

begin
    process(A, B, Cin)
    begin
        -- Initialize the signals
        if A(3 downto 0) = "0000" and B(3 downto 0) = "0000" then
            CarryIn := Cin;
        else
            CarryIn := '0';
        end if;

        Sum0 <= A(0) XOR B(0);
        CarryIn <= Cin OR (A(0) AND B(0));

        Sum1 <= (A(1) XOR B(1)) XOR ((CarryIn AND (A(1) XNOR B(1))) OR (A(1) AND B(1)));
        
        Sum2 <= (A(2) XOR B(2)) XOR ((Sum1 AND (A(2) XNOR B(2))) OR (A(2) AND B(2)));

        Sum3 <= CarryOut OR (A(3) XOR B(3));
    end process;

    S <= Sum0 & Sum1 & Sum2 & Sum3;
    CarryOut <= CarryIn OR (Sum1 AND A(1) XNOR B(1)) OR (Sum2 AND A(2) XNOR B(2));
end Behavioral;
