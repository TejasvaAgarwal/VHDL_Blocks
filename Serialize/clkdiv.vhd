library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned;

entity clkdiv is

  generic (divider : integer := 5);     -- Clock time period /2
  port (
    clock        : in  std_logic;       -- The input 100MHZ clock.
    reset        : in  std_logic;       -- Synchronous active high reset.
    s_enable     : out std_logic;       -- Enable signal with 1 HZ frequency.
    s_enable_180 : out std_logic  -- Phase shifted 180 degrees with s_enable.
    );
end clkdiv;

architecture rtl of clkdiv is

  signal clk_count : integer range 0 to divider;  -- Clock Count to count till the input clock reaches the divider.
  signal temp      : std_logic;  -- Temporary variable to store the serial enable value.
  signal temp_180  : std_logic;  -- Temporary variable to store the phase shifted.

begin

  process (clock)
  begin

    if (rising_edge(clock)) then        -- Everything is Synchronous.
      if (reset = '1') then             -- Initialization.
        temp         <= '0';
        s_enable     <= '0';
        temp_180     <= '0';
        s_enable_180 <= '0';
        clk_count    <= 0;
      else
        if (clk_count = divider-1 and temp = '0') then  -- Enable high condition.
          temp      <= '1';
          clk_count <= 0;
        elsif (temp = '1') then         -- Enable low condition.
          temp <= '0';
        else
          clk_count <= clk_count + 1;
        end if;
        s_enable <= temp;
      end if;
    end if;
  end process;

end architecture;
