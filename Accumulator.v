module Accumulator (clk, rst, clr, ld, in, out);
	input clk, rst, clr, ld;
	input [20:0] in;
    output reg [20:0] out;
    wire [20:0] new_out;

    
    Adder adder(in, out, new_out);

    always @(posedge clk, posedge rst) begin
        if(rst) out <= 21'd0;
        else if(clr)  out <= 21'd0;
        else if(ld) out <= new_out;
    end
endmodule