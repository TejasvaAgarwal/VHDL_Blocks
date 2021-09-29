# CITIROC control serializer

This repo contains VHDL logic to control a CITIROC ASIC
[datasheet](http://gauss.bu.edu/svn/emphatic-doco/Docs/CITIROC1A%20-%20Datasheet%20V2.5.pdf).
It is controlled by several parameters supplied as `std_logic_vector` and provides as
output serial clock (`sclk`) and serial data (`sdata`).

    entity serialize is
    
      port (
        clock   : in  std_logic;                      -- System clock.
        reset   : in  std_logic;                      -- Active high reset.
        divider : in  std_logic_vector(7 downto 0);   -- Clock Division Factor.
        data    : in  std_logic_vector(31 downto 0);  -- Parallel data.
        count   : in  std_logic_vector(4 downto 0);   -- Bit count 1-32.
        dir     : in  std_logic;                      -- Shift direction.
        start   : in  std_logic;                      -- Start serialization.
        busy    : out std_logic;                      -- High when busy.
        sclk    : out std_logic;                      -- Output clock to CITIROC.
        sdata   : out std_logic);                     -- Serial data out.
    
    end entity serialize;

## Current status (2021-09-29):

More or less working but `sdata` needs to be asserted before first `sclk`.
See sim below... first bit should clock out as '1'.

![waveforms](/images/Screenshot_2021-09-29_10-48-17.png)
