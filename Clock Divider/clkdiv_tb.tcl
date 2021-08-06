#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.clkdiv_tb.clock}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.reset}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.stdclk}]

gtkwave::/Time/Zoom/Zoom_Full

