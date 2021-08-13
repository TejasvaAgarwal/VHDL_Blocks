-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Shift_Register is

  port (
    clock : in  std_logic;              -- System clock.
    reset : in  std_logic;              -- Synchronous active high reset.  
    s_en  : in  std_logic;              -- Serial clock.
    start : in  std_logic;              -- Enables shifting.
    dir   : in  std_logic;              -- Specifies direction.
    count : in  std_logic_vector(4 downto 0);   -- Specifies no. of bits.
    data  : in  std_logic_vector(31 downto 0);  -- Parallel data.
    sdata : out std_logic);             -- Serial data.

end Shift_Register;


architecture Shifting of Shift_Register is

  signal count_int       : integer range 0 to 31;  -- Integer value of count vector.
  signal cycle           : integer range 0 to 31;  -- Ascending or descending.                  
  signal registered_data : std_logic_vector(31 downto 0);  -- Temporary vector.

begin

  process(clock)
  begin

    if (falling_edge(clock))then
      if (dir = '0')then
        count_int <= to_integer(unsigned(count));
        if (start = '1')then
          registered_data <= data;
          cycle           <= 0;
        elsif (cycle < count_int)then
          cycle <= cycle + 1;
        end if;
      elsif (dir = '1')then
        count_int <= to_integer(unsigned(count));
        if (start = '1')then
          registered_data <= data;
          cycle           <= count_int;
        elsif (cycle > 0)then
          cycle <= cycle - 1;
        end if;
      end if;
    end if;

    if (falling_edge(s_en))then
      sdata <= data(cycle);
    end if;

  end process;

end architecture;
