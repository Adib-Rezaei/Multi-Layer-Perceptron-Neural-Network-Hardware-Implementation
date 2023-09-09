module PU_Controller (input clk, rst, start, output reg ready); 
 
    reg [1:0] ps, ns; 
    parameter [1:0] Idle = 2'b00, Mult = 2'b01, Add = 2'b10, Accu = 2'b11; 
      
    always @(*) begin 
        case (ps) 
            Idle: ns = (start == 1) ? Mult : Idle; 
            Mult: ns = Add; 
            Add: ns = Accu; 
            Accu: ns = Idle; 
        endcase 
    end 
 
    always @(*) begin 
        {ready} = 1'b0;
        case (ps) 
            // Idle: clr = 1'b1; 
            // Multi: {c_up, ld} = 2'b11; 
            // Add: {mult_done, ld} = 2'b11; 
            Accu: ready = 1'b1; 
        endcase 
    end 
 
    always @(posedge clk, posedge rst) begin 
        if(rst) 
            ps <= 2'b0; 
        else 
            ps <= ns; 
    end 
endmodule