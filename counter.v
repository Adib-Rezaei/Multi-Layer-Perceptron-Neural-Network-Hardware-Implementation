module counter #(parameter WIDTH = 8) (clk, rst, cnt, out);
	input clk, rst, cnt;
    output reg [WIDTH - 1:0] out;

	always @(posedge clk, posedge rst) 
    begin
		if(rst == 1'b1) 
            out <= {WIDTH{1'b0}};
		else if(cnt) 
            out <= out + 1'b1;
	end
endmodule