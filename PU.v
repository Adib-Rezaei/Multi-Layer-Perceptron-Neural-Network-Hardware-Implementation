module PU (input clk, rst, start, bias_sig, input [63:0] value, weight, input [7:0] bias, output [7:0] result, output ready);

    PU_Controller pu_controller (clk, rst, start, ready);
    PU_Datapath pu_datapath (clk, rst, clr, value, weight, bias, bias_sig, result);

endmodule
