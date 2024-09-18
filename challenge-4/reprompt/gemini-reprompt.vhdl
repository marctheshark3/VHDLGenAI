library ieee;
use ieee.std_logic_1164.all;

entity pipeline_multiplier is
  port (
    clk      : in  std_logic;
    reset    : in  std_logic;
    a        : in  std_logic_vector(3 downto 0);
    b        : in  std_logic_vector(3 downto 0);
    product  : out std_logic_vector(7 downto 0)
  );
end entity pipeline_multiplier;

architecture pipeline of pipeline_multiplier is
  -- Declare signals for each stage
  signal stage1_a, stage1_b : std_logic_vector(3 downto 0);
  signal stage2_product : std_logic_vector(3 downto 0);
  signal stage3_product : std_logic_vector(6 downto 0);

begin
  -- Stage 1: Latch inputs
  process (clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        stage1_a <= (others => '0');
        stage1_b <= (others => '0');
      else
        stage1_a <= a;
        stage1_b <= b;
      end if;
    end if;
  end process;

  -- Stage 2: Partial product generation (shift-and-add)
  process (clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        stage2_product <= (others => '0');
      else
        -- Shift-and-add algorithm
        stage2_product <= (others => '0');
        for i in 0 to 3 loop
          if stage1_b(i) = '1' then
            stage2_product <= stage2_product + (stage1_a << i);
          end if;
        end loop;
      end if;
    end if;
  end process;

  -- Stage 3: Partial product accumulation (ripple-carry adder)
  process (clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        stage3_product <= (others => '0');
      else
        -- Ripple-carry adder
        stage3_product <= stage2_product;
        for i in 0 to 2 loop
          stage3_product(i + 1) <= stage3_product(i) + stage3_product(i + 1);
        end loop;
      end if;
    end if;
  end process;

  -- Stage 4: Final product output
  process (clk, reset)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        product <= (others => '0');
      else
        product <= stage3_product;
      end if;
    end if;
  end process;
end architecture pipeline;
