library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pipelined_multiplier is
    generic (
        WIDTH : integer := 8  -- Width of input operands
    );
    port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        a       : in  std_logic_vector(WIDTH-1 downto 0);
        b       : in  std_logic_vector(WIDTH-1 downto 0);
        product : out std_logic_vector(2*WIDTH-1 downto 0)
    );
end pipelined_multiplier;

architecture Behavioral of pipelined_multiplier is
    -- Define pipeline registers
    type pipeline_stage is array (0 to 3) of std_logic_vector(2*WIDTH-1 downto 0);
    signal pipeline : pipeline_stage;
    
    -- Partial products
    type partial_products_type is array (0 to WIDTH-1) of unsigned(2*WIDTH-1 downto 0);
    signal partial_products : partial_products_type;
    
    -- Intermediate sums
    signal sum_stage1, sum_stage2 : unsigned(2*WIDTH-1 downto 0);

begin
    -- Main process for the pipelined multiplier
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset all pipeline stages
            for i in 0 to 3 loop
                pipeline(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            -- Stage 1: Input Registration and Partial Product Generation
            for i in 0 to WIDTH-1 loop
                if b(i) = '1' then
                    partial_products(i) <= shift_left(resize(unsigned(a), 2*WIDTH), i);
                else
                    partial_products(i) <= (others => '0');
                end if;
            end loop;
            pipeline(0) <= std_logic_vector(partial_products(0));
            
            -- Stage 2: First level of addition (sum first half of partial products)
            sum_stage1 <= partial_products(0);
            for i in 1 to WIDTH/2-1 loop
                sum_stage1 <= sum_stage1 + partial_products(i);
            end loop;
            pipeline(1) <= std_logic_vector(sum_stage1);
            
            -- Stage 3: Second level of addition (sum second half of partial products)
            sum_stage2 <= unsigned(pipeline(1));
            for i in WIDTH/2 to WIDTH-1 loop
                sum_stage2 <= sum_stage2 + partial_products(i);
            end loop;
            pipeline(2) <= std_logic_vector(sum_stage2);
            
            -- Stage 4: Final addition and output registration
            pipeline(3) <= pipeline(2);
            
            -- Output the final product
            product <= pipeline(3);
        end if;
    end process;

end Behavioral;
