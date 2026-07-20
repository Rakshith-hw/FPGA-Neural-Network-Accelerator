module neuron (
    input clk,                    // System clock
    input reset,                  // Clear the accumulator to zero
    input valid_in,               // High when a fresh pixel/weight pair arrives
    input signed [7:0] pixel,      // 8-bit signed input pixel
    input signed [7:0] weight,     // 8-bit signed weight
    output reg signed [15:0] out  // 16-bit accumulated output value
);

    // Internal wire to hold the instantaneous product
    wire signed [15:0] mul_result;
    
    // Explicit hardware multiplication mapping
    assign mul_result = pixel * weight;

    // Sequential flip-flop logic driven by the rising clock edge
    always @(posedge clk) begin
        if (reset) begin
            out <= 16'd0;         // Clear the accumulator back to zero
        end else if (valid_in) begin
            out <= out + mul_result; // Accumulate: out = out + (pixel * weight)
        end
    end

endmodule
