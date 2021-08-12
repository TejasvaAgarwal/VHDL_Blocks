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
VHDL =	clkdiv.vhd clkdiv_tb.vhd

all: clkdiv_tb.ghw

view: clkdiv_tb_view

clkdiv_tb.ghw: analyze.ready
	$(GHDLE) clkdiv_tb
# NOTE:  stop time after 1us
	$(GHDLR) clkdiv_tb --stop-time=1us --wave=clkdiv_tb.ghw

clkdiv_tb_view: clkdiv_tb.ghw clkdiv_tb.tcl
	$(GTKWAVE) clkdiv_tb.ghw -S clkdiv_tb.tcl

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
