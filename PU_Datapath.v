module PU_Datapath(clk, rst, clr, value, weight, bias, bias_sig, result); 
  input clk, rst, clr; 
  input bias_sig; 
  input [8*8 - 1:0] value, weight; 
  input [7:0] bias; 
  output [7:0] result; 
 
 
  wire [8*8 - 1:0] value_out, weight_out; 
  wire [7:0] bias_out;   
   

  wire [119:0] mult_out; 
  wire [14:0] bias_mult_out;
  wire [134:0] tree_in; 
  wire [20:0] acc_reg_out; 



  register #(64) value_reg(clk, rst, 1'b1, value, value_out);
  register #(64) weight_reg(clk, rst, 1'b1, weight, weight_out);
  register #(8) bias_reg(clk, rst, 1'b1, bias, bias_out);
 
     
    generate 
        genvar i; 
        for (i = 0; i < 8; i = i + 1) begin: calc_mult 
            SignMultiplier mult1(value_out[8*i+7:8*i], weight_out[8*i+7:8*i], mult_out[15*i+14:15*i]); 
        end 
    endgenerate 
         
  SignMultiplier bias_mult(bias_reged, 8'd127, bias_mult_out); 
   
   
 
  register #(135) mult_reg(clk, rst, 1'b1, {bias_mult_out, mult_out}, tree_in); 
 
 
  wire [14:0] tree_adder_bias = (bias_sig) ? tree_in[134:120] : 15'd0; 
  wire [20:0] tree_adders_out; 
  AddersTree adders_tree(tree_in[14:0], tree_in[29:15], tree_in[44:30], 
                          tree_in[59:45], tree_in[74:60], tree_in[89:75], 
                          tree_in[104:90], tree_in[119:105], tree_adder_bias, tree_adders_out); 
 
 
  Accumulator acc_reg(clk, rst, 1'b1, clr, tree_adders_out, acc_reg_out); 
  ActivationFunction Relu(acc_reg_out, result); 
  

endmodule