# Hardware Implementation of a Neural Network Accelerator on FPGA

## 🎯 Core Objective
This project implements a hardware-based neural network accelerator designed for high-performance, low-latency "Edge AI" inference on an Artix-7 FPGA chip fabric. By executing matrix computations directly at the silicon gate level rather than using traditional CPU software loops, the system achieves maximum compute parallelization and extreme power efficiency.

## 🏗️ Architecture Design
The accelerator consists of three hardware components working synchronously:
1. **`neuron.v` (Processing Element):** A signed Multiply-Accumulate (MAC) core that processes streaming pixels.
2. **`weight_rom.v` (Memory Management):** A self-contained read-only memory matrix holding 8-bit quantized layer parameters.
3. **`hidden_layer.v` (Floor Controller):** A Finite State Machine (FSM) tracking input index states from 0 up to 784, coordinating memory fetching, and asserting completion flags.

## 🛠️ Tools & Technologies Used
* **AI Training & Quantization:** Python, PyTorch (MNIST Dataset)
* **Hardware Description Language:** Verilog HDL
* **Development Environment:** AMD Xilinx Vivado Design Suite
* **Target Silicon:** Artix-7 FPGA
