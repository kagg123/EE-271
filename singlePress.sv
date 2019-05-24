module singlePress(press, clk, KEY);

	input logic clk, KEY;
	output logic press;
	logic flop1, flop2, flop3;
	
	always_ff @(posedge clk) begin
		flop1 <= KEY;
		flop2 <= flop1;
		flop3 <= flop2;
	end 
	
	assign press = ~flop3 & flop2;
	
	
endmodule

//testbench
//module D_FF_testbench();
//	logic o;
//	logic clk, i;
//	
//	D_FF D_FFdut(.o , .clk, .i);
//	initial begin
//	i <= 0;  @(posedge clk); 
//				@(posedge clk); 
//	i <= 1;  @(posedge clk); 
//				@(posedge clk);
//			$stop; 	
//	end
//
//endmodule
