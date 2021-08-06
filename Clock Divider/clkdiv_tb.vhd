library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.finish;

entity clkdiv_tb is
end clkdiv_tb;

architecture sim of clkdiv_tb is

    signal clock : std_logic := '0';
    signal reset : std_logic;
    --signal temp : std_logic;
    signal stdclk : std_logic;
    --signal clk_count : integer;

begin


    DUT : entity work.clkdiv
    port map (
        clock => clock,
        reset => reset,
        stdclk => stdclk
    );
    
        reset <= '1', '0' after 20ns;
        --clk_count <= 0;
        --temp <= '0';

    process	 
    begin      
        	
        clock <= '0';			-- clock cycle is 10 ns
	    wait for 5 ns;
	    clock <= '1';
        wait for 5 ns;

    end process;
    

end architecture;