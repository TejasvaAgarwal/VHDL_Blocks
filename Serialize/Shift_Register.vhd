-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.  

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Shift_Register is

  port (
    clock : in std_logic; -- System clock.
    reset : in std_logic; -- Synchronous active high reset.
    busy  : out std_logic; -- Signal to indicate shifting.  
    s_en  : in std_logic; -- Serial clock.
    start : in std_logic; -- Enables shifting.
    dir   : in std_logic; -- Specifies direction.
    count : in std_logic_vector(4 downto 0); -- Specifies no. of bits.
    data  : in std_logic_vector(31 downto 0); -- Parallel data.
    sdata : out std_logic); -- Serial data.

end Shift_Register;

architecture Shifting of Shift_Register is

  signal count_int       : integer range 1 to 32; -- Integer value of count vector.
  signal cycle           : integer range 1 to 32; -- Ascending or descending.                  
  signal registered_data : std_logic_vector(31 downto 0); -- Temporary data vector.
  signal registered_dir  : std_logic; -- To store the direction.

begin

  process (clock, reset) is
  begin -- process
    if (reset = '1') then -- always provide a reset for every signal
      if (count = "00000") then
        count_int <= 32; -- Anomaly Case (count_in can't be 0 (logic error))
      else
        count_int <= to_integer(unsigned(count)); -- store the bit count
      end if;
      registered_data <= (others => '0');
      busy            <= '0';
      registered_dir  <= dir; -- only changes at reset.

    elsif (rising_edge(clock)) then -- rising clock edge
      -- latch the output
      if (s_en = '1') then
        sdata <= data(cycle - 1);
      end if;

      -- initialization
      if (start = '1') then
        if (count = "00000") then
          count_int <= 32; -- Anomaly Case (count_in can't be 0 (logic error))
        else
          count_int <= to_integer(unsigned(count)); -- store the bit count
        end if;
        registered_data <= data; -- store the data
        if (registered_dir = '0') then
          cycle <= 1; -- count up if dir = 0
        else
          cycle <= count_int; -- count down if dir = 1
        end if;
      end if;

      -- shifting
      if (s_en = '1' and start = '0') then
        busy <= '1';
        if (registered_dir = '0' and (cycle < count_int)) then
          cycle <= cycle + 1; -- incrementing from 0 to count_int.
        elsif (registered_dir = '0' and (cycle = count_int)) then
          busy <= '0';
        end if;
        if (registered_dir = '1' and (cycle > 1)) then
          cycle <= cycle - 1; -- decrementing from count_int to 0.
        elsif (registered_dir = '1' and (cycle = 1)) then
          busy <= '0';
        end if;
      end if;
    end if;
  end process;

end architecture;