library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned;

entity clkdiv is

    generic (divider : integer := 5e7); -- Clock time period /2
    port (
        clock : in std_logic;  -- The input 100MHZ clock.
        reset : in std_logic;  -- Synchronous active high reset.
        stdclk : out std_logic -- Standard Clock with 1 HZ frequency.
    );
end clkdiv;

architecture rtl of clkdiv is

    signal clk_count : integer range 0 to divider;  -- Clock Count to count till the input clock reaches the divider.
    signal temp : std_logic; -- Temporary variable to store the standard clock value.

begin
    
    process (clock, reset)
    begin
    
        if (rising_edge(clock)) then -- Everything is Synchronous.
            if (reset = '1') then 
                temp <= '0';            
                stdclk <= '0';
                clk_count <= 0 ;
                else          
                    clk_count <= clk_count + 1;
                    if (clk_count = divider) then 
                        temp <= not temp;
                    end if;   
            end if;
        end if;    
    stdclk <= temp;
    clk_count <= 0 ;
    end process;
    
end architecture;