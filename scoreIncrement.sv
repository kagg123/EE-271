module scoreIncrement(pos2, pos1, pos1_LastRow, minus2, red_arrayColumn_FinalRows, pressedKey);
	
	input logic [3:0] red_arrayColumn_FinalRows;
	input logic	pressedKey;
	output logic pos2, pos1, pos1_LastRow, minus2;
	
	always_comb begin
		if ( red_arrayColumn_FinalRows[0]) begin//decrease by 2 if it reaches the 0th row
			pos2 = 0; pos1 = 0; pos1_LastRow = 0; minus2 = 1; end 
		else if ( red_arrayColumn_FinalRows[1]  & pressedKey ) begin//incremement by 1 if pressed on row 1
			pos2 = 0; pos1 = 0; pos1_LastRow = 1; minus2 = 0; end
		else if (red_arrayColumn_FinalRows[2] & pressedKey ) begin//incremement by 2 if pressed on row 2
			pos2 = 1; pos1 = 0; pos1_LastRow = 0; minus2 = 0; end
		else if ( red_arrayColumn_FinalRows[3] & pressedKey ) begin//incremement by 1 if pressed on row 3
			pos2 = 0; pos1 = 1; pos1_LastRow = 0; minus2 = 0; end
		else begin
			pos2 = 0; pos1 = 0; pos1_LastRow = 0; minus2 = 0; //increment by 0
		end
	end

endmodule
