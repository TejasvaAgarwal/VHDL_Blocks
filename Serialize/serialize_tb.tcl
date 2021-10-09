#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.serialize_tb.clock}]
gtkwave::addSignalsFromList [list {top.serialize_tb.reset}]
gtkwave::addSignalsFromList [list {top.serialize_tb.divider}]
gtkwave::addSignalsFromList [list {top.serialize_tb.data}]
gtkwave::addSignalsFromList [list {top.serialize_tb.count}]
gtkwave::addSignalsFromList [list {top.serialize_tb.dir}]
gtkwave::addSignalsFromList [list {top.serialize_tb.start}]
gtkwave::addSignalsFromList [list {top.serialize_tb.busy}]
gtkwave::addSignalsFromList [list {top.serialize_tb.sdata}]
gtkwave::addSignalsFromList [list {top.serialize_tb.sclk}]
gtkwave::addSignalsFromList [list {top.serialize_tb.stored_s_en}]

gtkwave::/Time/Zoom/Zoom_Full
