-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Shift_Register is

  port (
    clock    : in std_logic; -- System clock.
    reset    : in std_logic; -- Synchronous active high reset.
    s_en     : in std_logic; -- Serial enable.  
    s_en_180 : in std_logic; -- Phase shifted.
    start    : in std_logic; -- Enables shifting.
    dir      : in std_logic; -- Specifies direction.
    count    : in std_logic_vector(4 downto 0); -- Specifies no. of bits.
    data     : in std_logic_vector(31 downto 0); -- Parallel data.
    busy     : out std_logic; -- Signal to indicate serialization.
    sclk     : out std_logic; -- Serial clock
    sdata    : out std_logic); -- Serial data.

end Shift_Register;

architecture Shifting of Shift_Register is

  signal count_int       : integer range 1 to 32; -- Integer value of count vector.
  signal cycle           : integer range 1 to 32; -- Ascending or descending.                  
  signal registered_data : std_logic_vector(31 downto 0); -- Temporary data vector.
  signal registered_dir  : std_logic; -- To store the direction.

  signal del_start : std_logic; -- start delayed one clock
  signal s_busy    : std_logic; -- internal busy flag

begin

  process (clock, reset) is
    -- The problem right now is that the sdata is laging the behind the sclock
    -- Possible solution: Delay start till s_en. 
  begin -- process

    if (reset = '1') then -- always provide a reset for every signal
      -- reset all internal signals and outputs to a known state
      count_int       <= 1;
      cycle           <= 1;
      registered_data <= (others => '0');
      registered_dir  <= '0';
      busy            <= '0';

      sclk      <= '0';
      sdata     <= '0';
      del_start <= '0';
      s_busy    <= '0';

    elsif (rising_edge(clock)) then -- rising clock edge
        del_start <= start; -- delay start by one clock.
      -- initialization, capture all user inputs
      -- (don't actually do anything yet) 
      if (start = '1') then
        if (count = "00000") then
          count_int <= 32; -- 0 means 32
        else
          count_int <= to_integer(unsigned(count)); -- store the bit count
        end if;
        registered_dir  <= dir; -- only changes at reset or dir
        registered_data <= data; -- store the data
      end if;

      -- one clock after start, we actually begin the serialization
      if del_start = '1' then
        if (registered_dir = '0') then
          cycle <= 1; -- count up if dir = 0
        else
          cycle <= count_int; -- count down if dir = 1
        end if;
        s_busy <= '1';
      end if;

      -- we're running, and s_en is active so time to shift
      if s_busy = '1' and s_en = '1' then

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

      -- update the serial clock if running
      if s_busy = '1' then
        if s_en = '1' then
          sclk <= '0';
        end if;

        if s_en_180 = '1' then
          sclk <= '1';
        end if;
      end if;

    end if;

  end process;

end architecture;