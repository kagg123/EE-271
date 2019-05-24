module shiftRow( red_arrayColumn, pos2, pos1, pos1_LastRow, minus2, pause, speed1, speed, reset, clk, lightOn);

	input logic speed, speed1, reset, clk, lightOn, pause, pos2, pos1, pos1_LastRow, minus2;
	output logic [8:0] red_arrayColumn ;
	logic [19:0] count;
	 
	
	always_ff @(posedge clk) begin
		if (reset) begin 
			red_arrayColumn[8:0] <= 8'b000000000;
			count <= 20'b00000000000000000000;
		end 
		else if (~pause & ((speed1 & count == 20'b00111111111111111111) | ((speed | speed1) & count == 20'b01111111111111111111) | count == 20'b11111111111111111111)) begin
			red_arrayColumn[8] <= lightOn;
			red_arrayColumn[7] <= red_arrayColumn[8];
			red_arrayColumn[6] <= red_arrayColumn[7];
			red_arrayColumn[5] <= red_arrayColumn[6];
			red_arrayColumn[4] <= red_arrayColumn[5];
			if (pos1) red_arrayColumn[3] <= 0;
			else red_arrayColumn[3] <= red_arrayColumn[4];
			if (pos2) red_arrayColumn[2] <= 0;
			else red_arrayColumn[2] <= red_arrayColumn[3];
			if (pos1_LastRow) red_arrayColumn[1] <= 0;
			else red_arrayColumn[1] <= red_arrayColumn[2];
			if (minus2) red_arrayColumn[0] <= 0;
			else red_arrayColumn[0] <= red_arrayColumn[1];
			count <= count + 20'b00000000000000000001;
		end
		else begin 
			red_arrayColumn[8] <= red_arrayColumn[8];
			red_arrayColumn[7] <= red_arrayColumn[7];
			red_arrayColumn[6] <= red_arrayColumn[6];
			red_arrayColumn[5] <= red_arrayColumn[5];
			red_arrayColumn[4] <= red_arrayColumn[4];
			if (pos1) red_arrayColumn[3] <= 0;
			else red_arrayColumn[3] <= red_arrayColumn[3];
			if (pos2) red_arrayColumn[2] <= 0;
			else red_arrayColumn[2] <= red_arrayColumn[2];
			if (pos1_LastRow) red_arrayColumn[1] <=0;
			else red_arrayColumn[1] <= red_arrayColumn[1];
			if (minus2) red_arrayColumn[0] <= 0;
			else red_arrayColumn[0] <= red_arrayColumn[0];
			count <= count + 20'b00000000000000000001;
		end
		
	end
endmodule
//module shiftRow( red_arrayColumn, pattern, speed, reset, clk, lightOn);
//
//	input logic speed, reset, clk, lightOn;
//	input logic [7:0] pattern;
//	output logic [7:0][7:0] red_arrayColumn ;
//	logic [18:0] count;
//	
//	
//	always_ff @(posedge clk) begin
//		if (reset) begin 
//			red_arrayColumn[7:0] <= 8'b00000000;
//			count <= 19'b0000000000000000000;
//		end 
//		else if ((speed & count == 19'b0111111111111111111) | count == 19'b1111111111111111111) begin
//			red_arrayColumn[7] <= pattern;
//			red_arrayColumn[6] <= red_arrayColumn[7];
//			red_arrayColumn[5] <= red_arrayColumn[6];
//			red_arrayColumn[4] <= red_arrayColumn[5];
//			red_arrayColumn[3] <= red_arrayColumn[4];
//			red_arrayColumn[2] <= red_arrayColumn[3];
//			red_arrayColumn[1] <= red_arrayColumn[2];
//			red_arrayColumn[0] <= red_arrayColumn[1];
//			count <= count + 19'b0000000000000000001;
//		end
//		else begin 
//			red_arrayColumn[7] <= red_arrayColumn[7];
//			red_arrayColumn[6] <= red_arrayColumn[6];
//			red_arrayColumn[5] <= red_arrayColumn[5];
//			red_arrayColumn[4] <= red_arrayColumn[4];
//			red_arrayColumn[3] <= red_arrayColumn[3];
//			red_arrayColumn[2] <= red_arrayColumn[2];
//			red_arrayColumn[1] <= red_arrayColumn[1];
//			red_arrayColumn[0] <= red_arrayColumn[0];
//			count <= count + 19'b0000000000000000001;
//		end
//		
//	end
//endmodule
