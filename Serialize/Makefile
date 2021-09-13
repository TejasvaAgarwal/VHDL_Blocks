#
# build and run a GHDL simulation
#

# run GHDL
GHDLRUN = /usr/bin/ghdl
GTKWAVE = /usr/bin/gtkwave

GHDLOPT = --ieee=synopsys
GHDLA = $(GHDLRUN) -a $(GHDLOPT)
GHDLE = $(GHDLRUN) -e $(GHDLOPT)
GHDLR = $(GHDLRUN) -r $(GHDLOPT)

# list all VHDL source files here
VHDL =	serialize.vhd serialize_tb.vhd

all: serialize_tb.ghw

view: serialize_tb_view

serialize_tb.ghw: analyze.ready
	$(GHDLE) serialize_tb
# NOTE:  stop time after 1us
	$(GHDLR) serialize_tb --stop-time=1us --wave=serialize_tb.ghw

serialize_tb_view: serialize_tb.ghw serialize_tb.tcl
	$(GTKWAVE) serialize_tb.ghw -S serialize_tb.tcl

#---- don't touch ----
define analyze_VHDL
  $(GHDLA) $(1);
endef

analyze.ready: $(VHDL)
	rm -f work-obj93.cf
	$(foreach vf,$(VHDL), $(call analyze_VHDL, $(vf)))
	touch analyze.ready

clean:
	rm -f *~ *.cf *.vcd *.ghw *.db *.ready
