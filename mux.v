module mux2to1 #(parameter WIDTH = 8) (i0, i1, sel, y);
    input [WIDTH-1:0] i0, i1;
    input sel;
    output [WIDTH-1:0] y;
    
    assign y = (sel == 1'b1) ? i1 : i0;
    
endmodule