
module memory_16x32 (
    input logic clk,
    input logic en,
    input logic rst,
    input logic [3:0] addr,
    input logic [31:0] data_in,
    output logic [31:0] data_out,
    output logic valid_out
);

// Declare a 2D array of 32-bit words with 16 rows
logic [31:0] mem [15:0];


// Initialize the memory with some values
initial begin

    mem[0] = 32'h12345678;
    mem[1] = 32'h9abcdef0;
    // ...
end

// Write data to memory when enabled and address is valid
always @(posedge clk) begin
    if (rst) begin
        mem <= '{default:'h0}; // Reset memory to zero
        data_out <= 'h0; // Reset output data to zero
        valid_out <= 'h0; // Reset output validity to zero
    end else if (en && (addr < 16)) begin // Check enable and address range
        mem[addr] <= data_in; // Assign memory location from input data 
        //data_out <= mem[addr]; // Assign output data from memory location 
        valid_out <= 'h0; // Set output validity to one 
    end else if((en === 1'b0) && (addr<16)) begin 
        data_out <= mem[addr]; // Assign output data from memory location 
        valid_out <= 'h1; // Clear output validity to zero otherwise 
    end
    else begin
        valid_out <= 'h0;
    end 
end

endmodule