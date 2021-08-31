library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity serialize_tb is
--  Port ( );
end serialize_tb;

architecture Behavioral of serialize_tb is

  signal clock    : std_logic;          -- System clock.
  signal reset    : std_logic;          -- Active high reset.
  signal divider  : std_logic_vector(7 downto 0);   -- Clock Division Factor.
  signal data     : std_logic_vector(31 downto 0);  -- Parallel data.
  signal count    : std_logic_vector(4 downto 0);   -- Bit count 1-32.
  signal dir      : std_logic;          -- Shift direction.
  signal start    : std_logic;          -- Start serialization.
  signal busy     : std_logic;          -- High when busy.
  signal s_en     : std_logic;          -- Serial clock out.
  signal s_en_180 : std_logic;  -- Serial clock out, phase shifted 180 degrees.
  signal sdata    : std_logic;          -- Serial data out.

begin

  DUT : entity work. serialize
    port map (
      clock    => clock,
      reset    => reset,
      divider  => divider,
      data     => data,
      count    => count,
      dir      => dir,
      start    => start,
      busy     => busy,
      s_en     => s_en,
      s_en_180 => s_en_180,
      sdata    => sdata);
-- Initialisation

  start <= '1', '0' after 40 ns;
  count <= "11111";
  data  <= "10101010101010101010101010101010";
  divider <= "00001010";
  dir   <= '1';
  reset <= '1', '0' after 20ns;

  process
  begin

    clock <= '0';                       -- clock cycle is 10 ns
    wait for 5 ns;
    clock <= '1';
    wait for 5 ns;

  end process;

end Behavioral;
