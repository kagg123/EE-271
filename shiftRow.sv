//accepts a single column of red array and shifts each light down a row 
//turns off light if it is in the correct row and a point has been incremented
//turns off light if it has "falled off the board"and a point has been decremented
module shiftRow( red_arrayColumn, pos2, pos1, pos1_LastRow, minus2, pause, speed1, speed, reset, clk, lightOn);

	input logic speed, speed1, reset, clk, lightOn, pause, pos2, pos1, pos1_LastRow, minus2;
	// Note our red array column has 9 rows while our LED array only has 8 this is because the
	//"Zeroth" row is the imaginary row below the last row and is used to determine if the light has fallen off the board
	output logic [8:0] red_arrayColumn ;
	logic [19:0] count;
	 
	
	always_ff @(posedge clk) begin
		if (reset) begin 
			red_arrayColumn[8:0] <= 8'b000000000;
			count <= 20'b00000000000000000000;
		end 
		else if (~pause & ((speed1 & count == 20'b00111111111111111111) | ((speed | speed1) & count == 20'b01111111111111111111) | count == 20'b11111111111111111111)) begin
			red_arrayColumn[8] <= lightOn; //set the topmost row of this column to the randomly generated true/false value
			red_arrayColumn[7] <= red_arrayColumn[8]; 
			red_arrayColumn[6] <= red_arrayColumn[7];
			red_arrayColumn[5] <= red_arrayColumn[6];
			red_arrayColumn[4] <= red_arrayColumn[5];
			if (pos1) red_arrayColumn[3] <= 0;  //turns off light if a point was added for this row
			else red_arrayColumn[3] <= red_arrayColumn[4];
			if (pos2) red_arrayColumn[2] <= 0;   //turns off light if a point was added for this row
			else red_arrayColumn[2] <= red_arrayColumn[3];
			if (pos1_LastRow) red_arrayColumn[1] <= 0;  //turns off light if a point was added for this row
			else red_arrayColumn[1] <= red_arrayColumn[2];
			if (minus2) red_arrayColumn[0] <= 0; //"turn off" the zeroth row light if a point has already been decremented...  
			else red_arrayColumn[0] <= red_arrayColumn[1]; //...this is so it doesn't decrement millions of times every time a light falls
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

