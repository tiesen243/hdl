# Verilog HDL Projects

This repository contains a collection of Verilog Hardware Description Language (HDL) projects designed to demonstrate various digital logic designs and concepts. The projects range from basic components like flip-flops and multiplexers to more complex systems such as finite state machines (FSMs) and digital clocks.

## Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

The projects within this repository are intended for educational purposes, providing practical examples of digital logic design using Verilog HDL. Each project is self-contained and focuses on a specific digital component or system, offering insights into design, simulation, and synthesis processes.

## Project Structure

The repository is organized as follows:

- `bcd_1/`, `bcd_2/`  
	Projects related to Binary-Coded Decimal (BCD) implementations.

- `c2b/`, `c3b/`, `c4b/`  
	Code converters between different binary representations.

- `clock_1/`, `clock_2/`  
	Digital clock designs with varying complexities.

- `decoder4_16/`, `demux1_16/`  
	Decoder and demultiplexer implementations.

- `flip_flop_1/`, `flip_flop_2/`, `flip_flop_3/`  
	Various flip-flop designs demonstrating different triggering mechanisms.

- `fsm_1/`, `fsm_2/`, `fsm_3/`  
	Finite State Machine designs showcasing different state transitions and outputs.

- `func_1/`, `func_2/`  
	Functional modules performing specific digital operations.

- `led_7_seg/`, `led_7_seg_2/`  
	Seven-segment LED display controllers.

- `multifier/`  
	Multiplier design for binary numbers.

- `exercises/`  
	Additional exercises and practice problems for reinforcing Verilog concepts.

- `DE2_pin_assignments.csv`  
	Pin assignment file for the DE2 development board.

## Getting Started

To get started with any of the projects:

1. Clone the repository:

	```bash
	git clone https://github.com/tiesen243/hdl.git
	```

2. Navigate to the project directory:

	```bash
	cd hdl
	```

3. Open the desired project folder to access its Verilog source files.

## Prerequisites

Ensure you have the following tools installed on your development environment:

- Verilog simulator (e.g., ModelSim)
- Synthesis tool (e.g., Intel Quartus)
- [Optional] DE2 development board for hardware implementation

## Usage

Each project folder contains Verilog source files (`.v`) that can be simulated and synthesized using the appropriate tools. Refer to the documentation within each folder for specific instructions on simulation and synthesis processes.

## Contributing

Contributions are welcome! If you have suggestions for improvements or new projects to add, feel free to fork the repository and submit a pull request.

## License

This repository is open-source and available under the [MIT License](LICENSE).
