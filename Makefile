###  -*-Makefile-*-
# Copyright (c) 2019 Bluespec, Inc. All Rights Reserved
# ================================================================

RTL_GEN_DIR = Verilog_RTL 
BUILD_DIR = build
INFO_DIR = info
XILINX_DIR = xil

help:
	@echo "make  compile    Compile the IP to Verilog (in $(RTL_GEN_DIR))"
	@echo "make  syn		Same as compile and also runs synthesys by yosys for Xilinx's Ultrascale Plus FPGA"
	@echo "make  all		same as syn"
	@echo "make  clean 		Restore to pristine state (pre-building anything)"

all: syn

# ================================================================
# Search path for bsc for .bsv files

BSC_PATH = src_Layer_2:src_Layer_1:src_Layer_0:BSV_Additional_Libs:+

# ----------------
# Top-level file and module

TOPFILE ?= src_Layer_0/AXI4_Accel.bsv

# ================================================================
# bsc compilation flags

BSC_COMPILATION_FLAGS += \
	-keep-fires -aggressive-conditions -no-warn-action-shadowing -no-show-timestamps -check-assert \
	+RTS -K128M -RTS  -show-range-conflict -remove-dollar

RTL_GEN_DIRS = -vdir $(RTL_GEN_DIR) -bdir $(BUILD_DIR) -info-dir $(INFO_DIR)
ALL_DIRS = $(RTL_GEN_DIR) $(BUILD_DIR) $(INFO_DIR) $(XILINX_DIR)

$(ALL_DIRS): 
	mkdir -p $@

compile:  $(ALL_DIRS)
	bsc -u -elab -verilog $(RTL_GEN_DIRS) -D FABRIC64 $(BSC_COMPILATION_FLAGS) -p $(BSC_PATH) $(TOPFILE)

syn: compile
	yosys -s ys

clean:
	rm -rf $(ALL_DIRS)
