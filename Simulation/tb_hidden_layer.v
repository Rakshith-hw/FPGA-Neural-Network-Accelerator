`timescale 1ns / 1ps

module tb_hidden_layer();

    // 1. Generate local registers to act as physical stimulus pins
    reg clk;
    reg reset;
    reg start;
    reg signed [7:0] stream_pixel;
    reg stream_valid;
    
    // Wires to read the hardware responses
    wire ready;
    wire signed [15:0] neuron_out;

    // 2. Instantiate your hidden layer system directly into the test rig
    hidden_layer uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .stream_pixel(stream_pixel),
        .stream_valid(stream_valid),
        .ready(ready),
        .neuron_out(neuron_out)
    );

    // 3. Generate a continuous hardware clock cycle (50MHz / 20ns period)
    always #10 clk = ~clk;

    // 4. Stimulus block: Drive the input pins over time
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        start = 0;
        stream_pixel = 0;
        stream_valid = 0;
        
        #40;
        reset = 0; // Release system reset
        #20;
        
        // Pulse the START signal to clear the neuron accumulators
        start = 1;
        #20;
        start = 0;
        
        // Start streaming data pixels into the chip!
        stream_valid = 1;
        stream_pixel = 8'sd10; // Feed a constant pixel value of 10 for testing
        
        // Wait until the hardware layer asserts its internal READY flag
        @(posedge ready);
        
        #100;
        $display("Simulation successfully complete! Current Neuron Output Value: %d", neuron_out);
        $finish;
    end

endmodule
