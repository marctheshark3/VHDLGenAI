-- Library declarations
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Full Adder Component
entity FullAdder is
    Port ( A : in STD_LOGIC;    -- First input bit
           B : in STD_LOGIC;    -- Second input bit
           Cin : in STD_LOGIC;  -- Carry input
           Sum : out STD_LOGIC; -- Sum output
           Cout : out STD_LOGIC); -- Carry output
end FullAdder;

architecture Behavioral of FullAdder is
begin
    -- Calculate sum using XOR gates
    Sum <= A xor B xor Cin;
    
    -- Calculate carry out using AND and OR gates
    Cout <= (A and B) or (Cin and (A xor B));
end Behavioral;

-- 4-Bit Adder
entity FourBitAdder is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input A
           B : in STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input B
           Cin : in STD_LOGIC;                    -- Carry input
           Sum : out STD_LOGIC_VECTOR (3 downto 0); -- 4-bit sum output
           Cout : out STD_LOGIC);                   -- Carry output
end FourBitAdder;

architecture Structural of FourBitAdder is
    -- Component declaration for FullAdder
    component FullAdder
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               Cin : in STD_LOGIC;
               Sum : out STD_LOGIC;
               Cout : out STD_LOGIC);
    end component;
    
    -- Internal carry signals
    signal C : STD_LOGIC_VECTOR (3 downto 1);
begin
    -- Instantiate four FullAdder components and connect them
    
    -- First FullAdder (least significant bit)
    FA0: FullAdder port map (A => A(0), B => B(0), Cin => Cin, Sum => Sum(0), Cout => C(1));
    
    -- Second FullAdder
    FA1: FullAdder port map (A => A(1), B => B(1), Cin => C(1), Sum => Sum(1), Cout => C(2));
    
    -- Third FullAdder
    FA2: FullAdder port map (A => A(2), B => B(2), Cin => C(2), Sum => Sum(2), Cout => C(3));
    
    -- Fourth FullAdder (most significant bit)
    FA3: FullAdder port map (A => A(3), B => B(3), Cin => C(3), Sum => Sum(3), Cout => Cout);
end Structural;