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

//module D_FF_testbench();
//	output logic o;
//	input logic clk1, clk2, i;
//	
//	D_FF dut(o, clk1, clk2, i);
//	
//	parameter CLOCK_PERIOD=100;
//		 initial begin
//				clk <= 0;
//				forever #(CLOCK_PERIOD/2) clk <= ~clk; 
//		  end
//	initial begin	
//		@(posedge clk);
//
//	end
//	endmodule
//	