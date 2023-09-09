
module Read_inputs (output reg [3967:0] weight_first_h, weight_second_h, weight_third_h, weight_fourth_h,
		output reg [63:0] bias_first_h,	bias_second_h, bias_third_h, bias_fourth_h, output reg [1919:0] weight_out, weight_out2,
			output reg [63:0] bias_out, bias_out2);

	reg [7:0] bh_sm [0:31];
	reg [7:0] bo_sm [0:15];
	reg [7:0] wh_sm [0:1983];
	reg [7:0] wo_sm [0:479];
		
	integer i;
		
   	initial begin
		   
		$readmemh("b1_sm.dat", bh_sm);
        $readmemh("b2_sm.dat", bo_sm);
		$readmemh("w1_sm.dat", wh_sm);
		$readmemh("w2_sm.dat", wo_sm);
		  
		for (i = 0; i < 496; i = i+1) begin
			weight_first_h[8*i +: 8] = wh_sm[i];
			weight_second_h[8*i +: 8] = wh_sm[i+496];
			weight_third_h[8*i +: 8] = wh_sm[i+992];
			weight_fourth_h[8*i +: 8] = wh_sm[i+1488];
        end

		for (i = 0; i < 8; i = i+1) begin
			bias_first_h[8*i +: 8] = bh_sm[i];
			bias_second_h[8*i +: 8] = bh_sm[i+8];
			bias_third_h[8*i +: 8] = bh_sm[i+16];
			bias_fourth_h[8*i +: 8] = bh_sm[i+24];
		end
		
		for (i = 0; i < 240; i = i+1) begin
			weight_out[8*i +: 8] = wo_sm[i];
			weight_out2[8*i +: 8] = wo_sm[i + 240];
		end
		
		for (i = 0; i < 8; i = i+1) begin
			bias_out[8*i +: 8] = bo_sm[i];
			bias_out2[8*i +: 8] = bo_sm[i + 8];
		end
   end
	
endmodule