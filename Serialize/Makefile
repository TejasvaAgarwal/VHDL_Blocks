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
VHDL =	Shift_Register.vhd Shift_Register_tb.vhd

all: Shift_Register_tb.ghw

view: Shift_Register_tb_view

Shift_Register_tb.ghw: analyze.ready
	$(GHDLE) Shift_Register_tb
# NOTE:  stop time after 1us
	$(GHDLR) Shift_Register_tb --stop-time=1us --wave=Shift_Register_tb.ghw

Shift_Register_tb_view: Shift_Register_tb.ghw Shift_Register_tb.tcl
	$(GTKWAVE) Shift_Register_tb.ghw -S Shift_Register_tb.tcl

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
