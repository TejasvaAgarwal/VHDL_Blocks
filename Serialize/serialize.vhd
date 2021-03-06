-- Parallel In, Serial Out
--
-- Serializes up to 32 bits, providing an output serial clock and serial data.
-- Output data changes on falling edge of the Serial Clock.
--
-- clk    : System clock (e.g. 25MHZ, 100MHZ etc).
-- reset        : Asynchronous Active High Reset (sent to all blocks).
-- divider: Specifies the ratio of sclk and clk.
-- data         : Parallel data input.
-- count        : The number of bits to be clocked out (out of 32).
-- dir          : Direction. if 0, data[0] is sent first.
--                           if 1, data[count-1] is sent first.
-- start        : 1 clk wide pulse to enable/ start serialization.
-- busy         : Output indicating that the serialization is going on.
-- sclk         : Serial clock out.
-- sdata        : Serial data output.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity serialize is

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

end entity serialize;

architecture PISO of serialize is

  component clkdiv
    port (
      clock        : in std_logic; -- The input 100MHZ clock.
      reset        : in std_logic; -- Synchronous active high reset.
      divider      : in std_logic_vector(7 downto 0); -- Dividing Factor.
      s_enable     : out std_logic; -- Enable signal with 1 HZ frequency.
      s_enable_180 : out std_logic); -- Phase shifted 180 degrees with s_enable.

  end component;

  component Shift_Register is
    port (
      clock    : in std_logic;
      reset    : in std_logic;
      s_en     : in std_logic;
      s_en_180 : in std_logic;
      start    : in std_logic;
      dir      : in std_logic;
      count    : in std_logic_vector(4 downto 0);
      data     : in std_logic_vector(31 downto 0);
      busy     : out std_logic;
      sclk     : out std_logic;
      sdata    : out std_logic);
  end component Shift_Register;

  signal stored_s_en     : std_logic;
  signal stored_s_en_180 : std_logic;

begin
  -- Instantiating the Clock Divider.
  ClockDivision : clkdiv port map(
    clock        => clock,
    reset        => reset,
    divider      => divider,
    s_enable     => stored_s_en,
    s_enable_180 => stored_s_en_180);
  -- Instantiating the Shift Register.
  Shifting : Shift_Register port map(
    clock    => clock,
    reset    => reset,
    busy     => busy,
    s_en     => stored_s_en,
    s_en_180 => stored_s_en_180,
    start    => start,
    dir      => dir,
    count    => count,
    data     => data,
    sclk     => sclk,
    sdata    => sdata);

end architecture;