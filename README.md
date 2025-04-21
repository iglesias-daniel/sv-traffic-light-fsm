# sv-traffic-light-fsm
A traffic light (european) controller implemented as a FSM using SystemVerilog.

## Installation (Ubuntu)

- You need iverilog and gtkwave installed to compile and view waveforms, respectively.

```bash
sudo apt update
sudo apt install iverilog gtkwave
git clone https://github.com/iglesias-daniel/sv-traffic-light-fsm
cd sv-configurable-updown-counter
```
## Usage

- The traffic light is implemented as a finite state machine (FSM) with four states:
    - `STOP`: Red light.
    - `WAIT`: Red and yellow lights (transition to green).
    - `GO`: Green light.
    - `CAUTION`: Yellow light (transition to red).
- Each state duration is parameterized via `CYCLE_RED`, `CYCLE_RED_YELLOW`, `CYCLE_GREEN`, and `CYCLE_YELLOW`.
- The `rst_n` signal performs a synchronous reset and forces the FSM back to the `STOP` state.
- The `en` signal enables the progression of time and state transitions.

## Test traffic_light.sv

- You can test the traffic light module with `traffic_light_tb` testbench using:

```makefile
make iverilog    # Compile generates .vvp file
make vpp         # Run simulation
make gtkwave     # View waveform in GTKWave
make clean       # Remove .vvp and .vcd files
make all         # Run both compilation and simulation
```
