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
    
    -- Intermediate signals for partial products
    signal partial_product : std_logic_vector(2*WIDTH-1 downto 0);

begin
    -- Main process for the pipelined multiplier
    process(clk, reset)
        variable temp_product : unsigned(2*WIDTH-1 downto 0);
    begin
        if reset = '1' then
            -- Reset all pipeline stages
            for i in 0 to 3 loop
                pipeline(i) <= (others => '0');
            end loop;
        elsif rising_edge(clk) then
            -- Stage 1: Input Registration and Partial Product Generation
            temp_product := unsigned(a) * unsigned(b);
            pipeline(0) <= std_logic_vector(temp_product);
            
            -- Stage 2: First level of addition (assuming carry-save addition)
            pipeline(1) <= pipeline(0);  -- In a real design, this would involve partial product reduction
            
            -- Stage 3: Second level of addition
            pipeline(2) <= pipeline(1);  -- In a real design, this would continue the reduction process
            
            -- Stage 4: Final addition and output registration
            pipeline(3) <= pipeline(2);  -- In a real design, this would be the final addition stage
            
            -- Output the final product
            product <= pipeline(3);
        end if;
    end process;

end Behavioral;
