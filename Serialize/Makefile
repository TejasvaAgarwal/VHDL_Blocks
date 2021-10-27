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
VHDL =	Serialize.vhd Serialize_tb.vhd

all: Serialize_tb.ghw

view: Serialize_tb_view

Serialize_tb.ghw: analyze.ready
	$(GHDLE) Serialize_tb
# NOTE:  stop time after 20us
	$(GHDLR) Serialize_tb --stop-time=20us --wave=Serialize_tb.ghw

Serialize_tb_view: Serialize_tb.ghw Serialize_tb.tcl analyze.ready
	$(GTKWAVE) Serialize_tb.ghw -S Serialize_tb.tcl

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
