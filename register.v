module register #(parameter WIDTH = 8)(clk, rst, ld, d_in, d_out);
    input [WIDTH-1:0] d_in;
    input rst, ld, clk;
    output reg [WIDTH-1:0] d_out;
    
    always @(posedge clk, posedge rst)
    begin
        if (rst == 1'b1)
            d_out = {WIDTH{1'b0}};
        else if (ld)
            d_out = d_in;
    end
        
endmodule



