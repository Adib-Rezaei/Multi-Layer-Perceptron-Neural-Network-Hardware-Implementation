`define   S0      5'd0
`define   S1      5'd1
`define   S2      5'd2
`define   S3      5'd3
`define   S4      5'd4
`define   S5      5'd5
`define   S6      5'd6
`define   S7      5'd7
`define   S8      5'd8
`define   S9      5'd9
`define   S10     5'd10
`define   S11     5'd11
`define   S12     5'd12
`define   S13     5'd13
`define   S14     5'd14
`define   S15     5'd15
`define   S16     5'd16


module controller (input clk, eq_zero, nm_eq, empty, start, input[3:0] stack_out, output reg push, pop, top,
					output reg[1:0] s0, output reg s1, s2, ld_n, ld_m, done, rst, cnt, output reg[4:0] ps, ns);
    
    always @(posedge clk)
    begin
        if (start && ^ps === 1'bX)
            ps <= 5'd0;
        else
            ps <= ns;
    end
    
    always @(ps, eq_zero, nm_eq, empty, stack_out, start)
    begin
		top = 1'd1;
		s0 = 2'b00;
        {push, pop, ld_n, ld_m, ns, done, s1, s2, rst, cnt} = 10'd0;
         
		case (ps) 
            `S0: begin ns = (start) ? `S1 : `S0;                                 end
            `S1: begin rst = 1'b1; ns = `S2;                                     end
            `S2: begin ld_n = 1'b1; ld_m = 1'b1; s1 = 1'b1; s2 = 1'b1; ns = `S3; end
            `S3: begin push = 1'b1; s0 = 2'd0; ns = `S4;                         end
            `S4: begin push = 1'b1; s0 = 2'd2; ns = `S5;                         end
            `S5: begin ns = (eq_zero) ? `S13 : `S6;                              end
            `S6: begin pop = 1'b1; s2 = 1'b0; ld_m = 1'b1; ns = `S7;             end 
            `S7: begin pop = 1'b1; s1 = 1'b0; ld_n = 1'b1; ns = `S8;             end
            `S8: begin ns = (nm_eq) ? `S15 : `S9;                                end
            `S9: begin push = 1'b1; s0 = 2'd1; ns = `S10;                        end 
            `S10: begin push = 1'b1; s0 = 2'd2; ns = `S11;                       end
            `S11: begin push = 1'b1; s0 = 2'd1; ns = `S12;                       end 
            `S12: begin push = 1'b1; s0 = 2'd3; ns = `S5;                        end
            `S13: begin pop = 1'b1; ns = `S14;                                   end 
            `S14: begin pop = 1'b1; ns = `S15;                                   end 
            `S15: begin cnt = 1'b1; ns = (empty) ? `S16 : `S5;                   end 
            `S16: begin done = 1'b1; ns = `S0;                                   end
		endcase
    end
    
endmodule