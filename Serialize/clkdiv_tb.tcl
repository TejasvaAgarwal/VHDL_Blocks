#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.clkdiv_tb.clock}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.reset}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.divider}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.s_enable}]
gtkwave::addSignalsFromList [list {top.clkdiv_tb.s_enable_180}]

gtkwave::/Time/Zoom/Zoom_Full

