library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clkdiv_tb is
end clkdiv_tb;

architecture sim of clkdiv_tb is

  signal clock        : std_logic;
  signal reset        : std_logic;
  signal divider      : std_logic_vector(7 downto 0);
  signal s_enable     : std_logic;
  signal s_enable_180 : std_logic;
  --signal sclk         : std_logic;

begin
  DUT : entity work.clkdiv
    port map(
      clock        => clock,
      reset        => reset,
      divider      => divider,
      s_enable     => s_enable,
      s_enable_180 => s_enable_180);
      --sclk => sclk);

  divider <= "00001010";
  reset   <= '1', '0' after 20 ns;

  process
  begin

    clock <= '0'; -- clock cycle is 10 ns
    wait for 5 ns;
    clock <= '1';
    wait for 5 ns;

  end process;
end architecture;