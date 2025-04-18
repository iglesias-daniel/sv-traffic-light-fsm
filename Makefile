
SRC_DIR = src
TB_DIR = tb
BUILD_DIR = build

all: iverilog vvp

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

iverilog: $(BUILD_DIR)
	iverilog -g2012 -o $(BUILD_DIR)/traffic_light_tb.vvp $(SRC_DIR)/traffic_light.sv $(TB_DIR)/traffic_light_tb.sv

vvp:
	vvp $(BUILD_DIR)/traffic_light_tb.vvp

gtkwave:
	gtkwave $(BUILD_DIR)/traffic_light_tb.vcd

clean:
	rm -rf $(BUILD_DIR)/*.vvp $(BUILD_DIR)/*.vcd