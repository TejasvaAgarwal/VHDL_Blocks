-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Serialize is

  port (
    clock   : in std_logic; -- System clock.
    reset   : in std_logic; -- Active high reset.
    divider : in std_logic_vector(7 downto 0); -- Clock Division Factor.
    data    : in std_logic_vector(31 downto 0); -- Parallel data.
    count   : in std_logic_vector(4 downto 0); -- Bit count 1-32.
    dir     : in std_logic; -- Shift direction.
    start   : in std_logic; -- Start serialization.
    busy    : out std_logic; -- High when busy.
    sclk    : out std_logic; -- Output clock to CITIROC.
    sdata   : out std_logic); -- Serial data out.

end entity Serialize;

architecture Serialization of Serialize is

  signal count_int       : integer range 1 to 32; -- Integer value of count vector.
  signal cycle           : integer range 1 to 32; -- Ascending or descending.                  
  signal registered_data : std_logic_vector(31 downto 0); -- Temporary data vector.
  signal registered_dir  : std_logic; -- To store the direction.

  signal temp_start : std_logic; -- To record advent of start.
  signal del_start  : std_logic; -- Delayed till s_en.
  signal s_busy     : std_logic; -- internal busy flag

  signal int_divider   : integer range 0 to 255; -- To store the value of the divider in an integer form.
  signal clk_count     : integer range 0 to 255; -- Clock Count to count till the input clock reaches the divider.
  signal clk_count_180 : integer range 0 to 255; -- Clock Count to count till the input clock reaches the divider.
  signal s_en          : std_logic; -- Enable signal with 1 HZ frequency.
  signal s_en_180      : std_logic; -- Phase shifted 180 degrees with s_enable.
  signal temp          : std_logic; -- Temporary variable to store the serial enable value.
  signal temp_180      : std_logic; -- Temporary variable to store the phase shifted.

begin

  process (clock, reset) is
    -- The problem right now is that the sdata is laging the behind the sclock
    -- Possible solution: Delay start till s_en. 
    -- Del_start = s_en.
  begin -- process

    if (reset = '1') then -- always provide a reset for every signal
      -- reset all internal signals and outputs to a known state
      count_int       <= 1;
      cycle           <= 1;
      registered_data <= (others => '0');
      registered_dir  <= '0';
      busy            <= '0';
      sclk            <= '0';
      sdata           <= '0';
      del_start       <= '0';
      temp_start      <= '0';
      s_busy          <= '0';

      temp          <= '0';
      s_en          <= '0';
      temp_180      <= '0';
      s_en_180      <= '0';
      clk_count     <= 0;
      clk_count_180 <= 0;
      int_divider   <= to_integer(unsigned(divider));

    elsif (rising_edge(clock)) then -- rising clock edge
      --del_start <= start; -- delay start by one clock.
      -- initialization, capture all user inputs
      -- (don't actually do anything yet) 
      if start = '1' then
        if count = "00000" then
          count_int <= 32; -- 0 means 32
        else
          count_int <= to_integer(unsigned(count)); -- store the bit count
        end if;
        registered_dir  <= dir; -- only changes at reset or dir
        registered_data <= data; -- store the data
        temp_start      <= '1'; -- To record advent of start.
      end if;

      -- Need to actually start serializing at after s_en 
      -- regardless of position of input 'start'.
      if (temp = '1' and temp_start = '1') then
        del_start  <= '1';
        temp_start <= '0';
      end if;

      -- one clock after start, we actually begin the serialization
      if del_start = '1' then
        if registered_dir = '0' then
          cycle <= 1; -- count up if dir = 0
        else
          cycle <= count_int; -- count down if dir = 1
        end if;
        s_busy    <= '1';
        del_start <= '0';
      end if;

      -- we're running, and s_en is active so time to shift
      if (s_busy = '1' and s_en = '1') then
        if registered_dir = '0' then -- direction = INCREASING
          if cycle < count_int then
            cycle <= cycle + 1; -- incrementing from 1 to count_int.
          else
            s_busy <= '0';
          end if;
        else -- direction = DECREASING
          if cycle > 1 then
            cycle <= cycle - 1; -- decrementing from count_int to 1.
          else
            s_busy <= '0';
          end if;
        end if;
      end if;

      -- latch the output, only if running
      -- <FIXME> this doesn't work for the first bit
      if s_en = '1' then
        if s_busy = '1' then
          sdata <= data(cycle - 1);
        else
          sdata <= '0';
        end if;
      end if;

      busy <= s_busy;

      -- Serial Enable.
      ------------------------------------------------------------------------------------
      if (clk_count = int_divider - 2 and temp = '0') then -- Enable high condition.
        temp      <= '1';
        clk_count <= 0;
      elsif (temp = '1') then -- Enable low condition.
        temp <= '0';
      else
        clk_count <= clk_count + 1;
      end if;

      if (temp_180 = '0') then
        s_en <= temp;
      end if;

      -- Phase Shifted Serial Enable.
      if (clk_count_180 = int_divider * 2 - 2 and temp_180 = '0') then -- Enable high condition.
        temp_180      <= '1';
        clk_count_180 <= 0;
      elsif (temp_180 = '1') then -- Enable low condition.
        temp_180 <= '0';
      else
        clk_count_180 <= clk_count_180 + 1;
      end if;

      s_en_180 <= temp_180;
      ------------------------------------------------------------------------------------
      -- update the serial clock if running
      if s_busy = '1' then
        if s_en = '1' then
          sclk <= '0';
        end if;

        if s_en_180 = '1' then
          sclk <= '1';
        end if;
        ------------------------------------------------------------------------------------
      end if;

    end if;

  end process;

end architecture;