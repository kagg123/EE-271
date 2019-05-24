module LFSR (Q, clk, reset, resetVal);
	output logic [9:0] Q;
	input logic clk, reset;
	input logic [9:0] resetVal;
	logic D;
	
	assign D = ~ ( Q[6] ^ Q[9] );
	
	always_ff @(posedge clk) begin
		if (reset) begin
			Q <= resetVal;
		end
		else begin
			Q[0] <= D;
			Q[1]<= Q[0];
			Q[2]<= Q[1];
			Q[3]<= Q[2];
			Q[4]<= Q[3];
			Q[5]<= Q[4];
			Q[6]<= Q[5];
			Q[7]<= Q[6];
			Q[8]<= Q[7];
			Q[9]<= Q[8];
			
		end
	
	end

endmodule
