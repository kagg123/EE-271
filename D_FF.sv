module D_FF (o, clk1, clk2, i);

	output logic o;
	input logic clk1, clk2, i;
	logic m;
	
	always_ff @(posedge clk1) begin 
		m <= i;
	end
	
	always_ff @(posedge clk2) begin 
		o <= m;
	end
	
endmodule
