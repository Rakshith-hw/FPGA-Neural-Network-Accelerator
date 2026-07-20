module weight_rom (
    input clk,
    input [9:0] addr,                  // 10-bit address wire (covers 0 to 783)
    output reg signed [7:0] weight_out // 8-bit signed weight data output
);

    // Create a memory array of 784 slots, each 8-bits wide
    reg signed [7:0] rom_memory [0:783];
    
    // Integer index for the initialization loop
    integer i;

    // This block runs during synthesis to pre-fill the memory cells on the chip
    initial begin
        for (i = 0; i < 784; i = i + 1) begin
            rom_memory[i] = 8'sd1; // Assign a stable default baseline weight of +1 to every single slot
        end
    end

    // Synchronous read block: fetches the pre-filled weight on each clock edge
    always @(posedge clk) begin
        weight_out <= rom_memory[addr];
    end

endmodule
