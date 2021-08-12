-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Shift_Register is

  port (
    sclk        : in std_logic;                         -- Serial clock.
    start       : in std_logic;                         -- Enables shifting.
    dir         : in std_logic;                         -- Specifies direction.
    count       : in std_logic_vector(4 downto 0);      -- Specifies no. of bits.
    data        : in std_logic_vector(31 downto 0);     -- Parallel data.
    sdata       : out std_logic);                       -- Serial data.

end Shift_Register;


architecture Shifting of Shift_Register is

  signal count_int : integer range 0 to 31;
  signal cycle     : integer range 0 to 31;
  
  
begin

  process(sclk)
  begin

    count_int <= to_integer(unsigned(count));

    if (falling_edge(sclk))then
      if (dir = '0')then
        if (start = '1')then
          cycle <= 0;
        elsif (cycle < count_int)then
          cycle <= cycle + 1;
        end if;
      elsif (dir = '1')then
        if (start = '1')then
          cycle <= count_int;
        elsif (cycle > 0)then
          cycle <= cycle - 1;
        end if;
      end if;
      sdata <= data(cycle);
    end if;

  end process;

end architecture;
