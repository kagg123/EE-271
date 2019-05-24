//generates a "press" which is true for exactly one clock cycle everytime a KEY is pressed
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
