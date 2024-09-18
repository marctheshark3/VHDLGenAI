library IEEE; 
use IEEE.STD_LOGIC; 
use IEEE.NUMERIC_STD.ALL;

entity multiplier_pipeline is
    Port ( A : in unsigned(15 downto 0); 
           B : in unsigned(15 downto 0); 
           clock : in std_logic;
           reset : in std_logic;
           result : out unsigned(31 downto 0));
end entity multiplier_pipeline;

architecture pipeline_arch of multiplier_pipeline is

    -- Stage 1: Sign-Extend and Operand Preparation
    signal a_extended, b_extended : unsigned(31 downto 0);

    -- Stage 2: Partial Product Generation
    signal partial_products : unsigned(63 downto 0);

    -- Stage 3: Accumulation
    signal accumulation : unsigned(63 downto 0);

    -- Stage 4: Result Output
    signal final_result : unsigned(31 downto 0);
    
    function sign_extend(x : unsigned) return unsigned is
    begin
        if x(15) = '1' then
            return (x & "11" & x(14 downto 0));
        else
            return x;
        end if;
    end function;

begin

    -- Stage 1: Sign-Extend and Operand Preparation
    process (clock, reset)
    begin
        if (reset = '1') then
            a_extended <= (others => '0');
            b_extended <= (others => '0');
        elsif (rising_edge(clock)) then
            a_extended <= sign_extend(A);
            b_extended <= sign_extend(B);
        end if;
    end process;

    -- Stage 2: Partial Product Generation
    process (clock, reset)
    begin
        if (reset = '1') then
            partial_products <= (others => '0');
        elsif (rising_edge(clock)) then
            partial_products <= a_extended * b_extended;
        end if;
    end process;

    -- Stage 3: Accumulation
    process (clock, reset)
    begin
        if (reset = '1') then
            accumulation <= (others => '0');
        elsif (rising_edge(clock)) then
            accumulation <= partial_products(31 downto 0) + partial_products(63 
downto 32);
        end if;
    end process;

    -- Stage 4: Result Output
    process (clock, reset)
    begin
        if (reset = '1') then
            final_result <= (others => '0');
        elsif (rising_edge(clock)) then
            result <= accumulation(31 downto 0);
        end if;
    end process;

end architecture pipeline_arch;
