#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.clock}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.reset}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.busy}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.s_en}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.start}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.dir}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.count}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.data}]
gtkwave::addSignalsFromList [list {top.Shift_Register_tb.sdata}]

gtkwave::/Time/Zoom/Zoom_Full

