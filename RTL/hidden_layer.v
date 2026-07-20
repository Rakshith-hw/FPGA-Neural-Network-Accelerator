`timescale 1ns / 1ps

module hidden_layer (
    input clk,                        // System clock
    input reset,                      // Global reset
    input start,                      // Signal to start processing a fresh 784-pixel image
    input signed [7:0] stream_pixel,  // One pixel streamed in per clock cycle
    input stream_valid,               // High when the incoming pixel is valid
    output reg ready,                 // High when layer completes all 784 steps
    output wire signed [15:0] neuron_out // Output reading from our baseline tracking neuron
);

    // Internal Counter to track streaming index (0 to 783)
    reg [9:0] pixel_counter;
    wire neuron_reset;
    
    // Clear accumulator when a brand new image begins
    assign neuron_reset = reset || (start);

    // Sequential Logic: Manage our streaming position and assign values
    always @(posedge clk) begin
        if (reset || start) begin
            pixel_counter <= 10'd0;
            ready         <= 1'b0;
        end else if (stream_valid && (pixel_counter < 10'd784)) begin
            pixel_counter <= pixel_counter + 1'b1;
            if (pixel_counter == 10'd783) begin
                ready <= 1'b1; // Completed all 784 steps!
            end
        end
    end

    // Wiring up your custom Block RAM memory module
    wire signed [7:0] current_weight;
    
    weight_rom neuron0_memory (
        .clk(clk),
        .addr(pixel_counter),      // Counter directly drives memory address selection!
        .weight_out(current_weight) // Fetched weight is driven out onto this internal wire
    );

    // Driving your custom neuron core with the live memory stream
    neuron baseline_neuron (
        .clk(clk),
        .reset(neuron_reset),
        .valid_in(stream_valid && !ready),
        .pixel(stream_pixel),
        .weight(current_weight),   
        .out(neuron_out)
    );

endmodule
