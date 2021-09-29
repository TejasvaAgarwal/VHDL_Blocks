# CITIROC control serializer

This repo contains VHDL logic to control a CITIROC ASIC
[datasheet](http://gauss.bu.edu/svn/emphatic-doco/Docs/CITIROC1A%20-%20Datasheet%20V2.5.pdf).
It is controlled by several parameters supplied as `std_logic_vector` and provides as
output serial clock (`sclk`) and serial data (`sdata`).

