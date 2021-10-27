#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.Serialize_tb.clock}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.reset}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.divider}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.data}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.count}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.dir}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.start}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.busy}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.sdata}]
gtkwave::addSignalsFromList [list {top.Serialize_tb.sclk}]

gtkwave::/Time/Zoom/Zoom_Full
