-- Parallel In, Serial Out
--
-- Serializes up to 32 bits, providing an output serial clock and serial data.
-- Output data changes on falling edge of the Serial Clock.
--
-- CLKDIV	: Specifies the ratio of sclk and clk.
-- clk      : System clock (e.g. 25MHZ, 100MHZ etc).
-- reset 	: Asynchronous Active High Reset (sent to all blocks).
-- data 	: Parallel data input.
-- count 	: The number of bits to be clocked out (out of 32).
-- dir		: Direction. if 0, data[0] is sent first.
-- 			     if 1, data[count-1] is sent first.
-- start	: 1 clk wide pulse to enable/ start serialization.
-- busy`	: Output indicating that the serialization is going on.
-- sclk 	: Serial clock out.
-- sdata 	: Serial data output.

entity serialize is 
	
    generic (CLKDIV : integer := 5);                    -- Clock Division Factor.
    
    port (
        clk	: in std_logic;                         -- System clock.
        rst 	: in std_logic;                         -- Active high reset.
        data 	: in std_logic_vector(31 downto 0);     -- Parallel data.
        count   : in std_logic_vector(4 downto 0);      -- Bit count 1-32.
        dir     : in std_logic;                         -- Shift direction.
        start   : in std_logic;                         -- Start serialization.
        busy    : out std_logic;                        -- High when busy.
        sclk    : out std_logic;                        -- Serial clock out.
        sdata   : out std_logic);                       -- Serial data out.

end entity serialize;

architecture PISO of serialize is


  