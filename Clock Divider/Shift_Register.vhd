-- This is the Parallel In, Serial Out Shift Register which is meant to take in
-- upto 32 bits as parallel input and shift them in a specified direction to a
-- serial output.

library IEEE;
use IEEE.std_logic_1164.all;

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


begin

  process(sclk)
    
