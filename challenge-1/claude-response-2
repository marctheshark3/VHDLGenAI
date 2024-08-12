-- Library declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity declaration for the 4-bit adder
entity adder_4bit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input A
           B : in  STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input B
           Cin : in  STD_LOGIC;                    -- Carry input
           Sum : out  STD_LOGIC_VECTOR (3 downto 0); -- 4-bit sum output
           Cout : out  STD_LOGIC);                  -- Carry output
end adder_4bit;

-- Architecture declaration
architecture Structural of adder_4bit is

    -- Component declaration for a full adder
    component full_adder
        Port ( A : in  STD_LOGIC;
               B : in  STD_LOGIC;
               Cin : in  STD_LOGIC;
               Sum : out  STD_LOGIC;
               Cout : out  STD_LOGIC);
    end component;

    -- Internal signals for carry between full adders
    signal C1, C2, C3 : STD_LOGIC;

begin
    -- Instantiate four full adders to create the 4-bit adder
    
    -- First full adder (least significant bit)
    FA0: full_adder port map (
        A => A(0),
        B => B(0),
        Cin => Cin,
        Sum => Sum(0),
        Cout => C1
    );

    -- Second full adder
    FA1: full_adder port map (
        A => A(1),
        B => B(1),
        Cin => C1,
        Sum => Sum(1),
        Cout => C2
    );

    -- Third full adder
    FA2: full_adder port map (
        A => A(2),
        B => B(2),
        Cin => C2,
        Sum => Sum(2),
        Cout => C3
    );

    -- Fourth full adder (most significant bit)
    FA3: full_adder port map (
        A => A(3),
        B => B(3),
        Cin => C3,
        Sum => Sum(3),
        Cout => Cout
    );

end Structural;

-- Full Adder component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC;
           Cout : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is
begin
    -- Sum is XOR of A, B, and Cin
    Sum <= A XOR B XOR Cin;
    
    -- Carry out is OR of (A AND B), (A AND Cin), and (B AND Cin)
    Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
end Behavioral;
