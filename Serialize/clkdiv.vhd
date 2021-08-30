-- This module is supposed to output serial enable signals. 
-- It takes the clock as input and outputs a signal s_enable which is a one clock wide active high signal at a given frequency.
-- The signal s_enable_180 is same as s_enable, just phase shifted to 180 degrees.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkdiv is

  --generic (divider : integer := 10); -- Clock time period /2
  port (
    clock        : in std_logic; -- The input 100MHZ clock.
    reset        : in std_logic; -- Synchronous active high reset.
    divider      : in std_logic_vector(7 downto 0); -- The frequency in terms of clock at which the enable signals will trigger.
    s_enable     : out std_logic; -- Enable signal with 1 HZ frequency.
    s_enable_180 : out std_logic); -- Phase shifted 180 degrees with s_enable.
end clkdiv;

architecture rtl of clkdiv is
  signal int_divider : integer range 0 to 255; -- To store the value of the divider in an integer form.
  signal clk_count   : integer range 0 to int_divider; -- Clock Count to count till the input clock reaches the divider.
  signal temp        : std_logic; -- Temporary variable to store the serial enable value.
  signal temp_180    : std_logic; -- Temporary variable to store the phase shifted.

begin

  process (clock)
  begin

    if (rising_edge(clock)) then -- Everything is Synchronous.
      if (reset = '1') then -- Initialization.
        temp         <= '0';
        s_enable     <= '0';
        temp_180     <= '0';
        s_enable_180 <= '0';
        clk_count    <= 0;
        int_divider  <= to_integer(unsigned(divider));
      else
        -- Serial Enable.
        if (clk_count = int_divider - 2 and temp = '0') then -- Enable high condition.
          temp      <= '1';
          clk_count <= 0;
        elsif (temp = '1') then -- Enable low condition.
          temp <= '0';
        else
          clk_count <= clk_count + 1;
        end if;
        s_enable <= temp;
        -- Phase Shifted Serial Enable.
        if (clk_count = int_divider / 2 - 2 and temp_180 = '0') then -- Enable high condition.
          temp_180 <= '1';
        elsif (temp_180 = '1') then -- Enable low condition.
          temp_180 <= '0';
        end if;
        s_enable_180 <= temp_180;
      end if;
    end if;

  end process;

end architecture;