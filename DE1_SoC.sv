//Kanika Aggarwal
// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, GPIO_0, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 output logic [35:0] GPIO_0;
 input logic CLOCK_50;
 input logic [3:0] KEY;
 input logic [9:0] SW;
 
 logic [31:0] clk;
 logic pressZero, pressOne, pressTwo, pressThree, trueZero, trueOne, trueTwo, trueThree;
 logic [7:0][7:0] red_array, green_array;
 logic [9:0] A0, A1, A2, A3, B0, B1, B2, B3;
 logic pos1_0, pos1_1 , pos1_2 , pos1_3, pos2_0 , pos2_1 , pos2_2 , pos2_3, pos1_LastRow_0, pos1_LastRow_1, pos1_LastRow_2, pos1_LastRow_3, minus2_0, minus2_1, minus2_2, minus2_3;
 logic pos2, pos1, minus2;
 logic [8:0] col0, col1, col2, col3;
 logic inc10, inc100, dec10, dec100;
	
//assign unused HEX to display nothing
assign HEX3 = 7'b1111111;
assign HEX4 = 7'b1111111;
assign HEX5 = 7'b1111111;
 
 
//use a clock divider to create a slower clock (better speed for LED array)
parameter whichClock = 5;
clock_divider cdiv (.clock(CLOCK_50), .reset(SW[9]), .divided_clocks(clk)); 

	
//Determines which Key/s are pressed 
//Outputs true for exactly one clock cycle every time a key is pressed
singlePress press0(.press(pressZero), .clk(clk[whichClock]), .KEY(KEY[3]));
singlePress press1(.press(pressOne), .clk(clk[whichClock]), .KEY(KEY[2]));
singlePress press2(.press(pressTwo), .clk(clk[whichClock]), .KEY(KEY[1]));
singlePress press3(.press(pressThree), .clk(clk[whichClock]), .KEY(KEY[0]));


//Generates a random true/false which determines if the topmost row of a bank should be lit (true) or unlit (false)
	//initialiazes 10 bit binaries (B0-B3)
	assign B0[9:0] = 10'b1100000000; // a value I chose so A0>B0 will be true ~25% of the time
	assign B1[9:0] = 10'b1101100110; // a value I chose so A1>B1 will be true ~ 15% of the time
	assign B2[9:0] = 10'b1011001100; // a value I chose so A2>B2 will be true ~ 30% of the time
	assign B3[9:0] = 10'b1100110011; // a value I chose so A3>B3 will be true ~ 20% of the time
	
	//generates random 10 bit values (A0-A3) that change every clock cycle 
	//each has a different reset value I chose at random so all banks don't display the same pattern at the same time
	LFSR lfsr0 (.Q(A0[9:0]), .clk(clk[whichClock]), .reset(SW[9]), .resetVal(0111001101));
	LFSR lfsr1 (.Q(A1[9:0]), .clk(clk[whichClock]), .reset(SW[9]), .resetVal(0011001000));
	LFSR lfsr2 (.Q(A2[9:0]), .clk(clk[whichClock]), .reset(SW[9]), .resetVal(0111110100));
	LFSR lfsr3 (.Q(A3[9:0]), .clk(clk[whichClock]), .reset(SW[9]), .resetVal(0001011010));

	//sets truei ouput to 1 if Ai>Bi for each i = 0 to i = 3
	ten_bit_comparator comparesAB0( .trueOutput(trueZero), .A(A0[9:0]), .B(B0[9:0]) ) ;
	ten_bit_comparator comparesAB1( .trueOutput(trueOne), .A(A1[9:0]), .B(B1[9:0]) ) ;
	ten_bit_comparator comparesAB2( .trueOutput(trueTwo), .A(A2[9:0]), .B(B2[9:0]) ) ;
	ten_bit_comparator comparesAB3( .trueOutput(trueThree), .A(A3[9:0]), .B(B3[9:0]) ) ;

//recieves true/false input to create the topmost row of each bank
//shifts each row down every x seconds, x can be changed (faster or slower speed) with switches
//turns off lights once the corresponding key has been pressed on the correct row	
shiftRow bank0( .red_arrayColumn(col0), .pos2(pos2_0), .pos1(pos1_0), .pos1_LastRow(pos1_LastRow_0), .minus2(minus2_0), .pause(SW[8]), .speed1(SW[1]), .speed(SW[0]), .reset(SW[9]), .clk(clk[whichClock]), .lightOn(trueZero));
shiftRow bank1( .red_arrayColumn(col1), .pos2(pos2_1), .pos1(pos1_1), .pos1_LastRow(pos1_LastRow_1), .minus2(minus2_1), .pause(SW[7]), .speed1(SW[1]), .speed(SW[0]), .reset(SW[9]), .clk(clk[whichClock]), .lightOn(trueOne));
shiftRow bank2( .red_arrayColumn(col2), .pos2(pos2_2), .pos1(pos1_2), .pos1_LastRow(pos1_LastRow_2), .minus2(minus2_2), .pause(SW[6]), .speed1(SW[1]), .speed(SW[0]), .reset(SW[9]), .clk(clk[whichClock]), .lightOn(trueTwo));
shiftRow bank3( .red_arrayColumn(col3), .pos2(pos2_3), .pos1(pos1_3), .pos1_LastRow(pos1_LastRow_3), .minus2(minus2_3), .pause(SW[5]), .speed1(SW[1]), .speed(SW[0]), .reset(SW[9]), .clk(clk[whichClock]), .lightOn(trueThree));

//assign pattern = {4'b0000, trueZero, trueOne,trueTwo, trueThree};
//each red_array[i] represents the ith row on the LED Array
//the 4 rightmost columns will be unlit, the 4 left most columns will be the 4 banks
assign red_array[7] = {4'b0000, col0[8], col1[8], col2[8], col3[8]};
assign red_array[6] = {4'b0000, col0[7], col1[7], col2[7], col3[7]};
assign red_array[5] = {4'b0000, col0[6], col1[6], col2[6], col3[6]};
assign red_array[4] = {4'b0000, col0[5], col1[5], col2[5], col3[5]};
assign red_array[3] = {4'b0000, col0[4], col1[4], col2[4], col3[4]};
assign red_array[2] = {4'b0000, col0[3], col1[3], col2[3], col3[3]};
assign red_array[1] = {4'b0000, col0[2], col1[2], col2[2], col3[2]};
assign red_array[0] = {4'b0000, col0[1], col1[1], col2[1], col3[1]};


//assigns  green array rows
//only the row where the button must be pressed will be lit
assign green_array[0] = 8'b00000000;
assign green_array[1] = 8'b11111111;
assign green_array[2] = 8'b00000000;
assign green_array[3] = 8'b00000000;
assign green_array[4] = 8'b00000000;
assign green_array[5] = 8'b00000000;
assign green_array[6] = 8'b00000000;
assign green_array[7] = 8'b00000000;
	
//inputs red array green array and output the led driver 
//drives the led columns to display on the led Array
led_matrix_driver drive(.clock(clk[whichClock]), .red_array, .green_array, .red_driver(GPIO_0[35:28]), .green_driver(GPIO_0[27:20]), .row_sink(GPIO_0[19:12]));

//inputs red array and press to determine if point is made for each bank
scoreIncrement inc0(.pos2(pos2_0), .pos1(pos1_0), .pos1_LastRow(pos1_LastRow_0), .minus2(minus2_0), .red_arrayColumn_FinalRows(col0[3:0]), .pressedKey(pressZero));
scoreIncrement inc1(.pos2(pos2_1), .pos1(pos1_1), .pos1_LastRow(pos1_LastRow_1), .minus2(minus2_1), .red_arrayColumn_FinalRows(col1[3:0]), .pressedKey(pressOne));
scoreIncrement inc2(.pos2(pos2_2), .pos1(pos1_2), .pos1_LastRow(pos1_LastRow_2), .minus2(minus2_2), .red_arrayColumn_FinalRows(col2[3:0]), .pressedKey(pressTwo));
scoreIncrement inc3(.pos2(pos2_3), .pos1(pos1_3), .pos1_LastRow(pos1_LastRow_3), .minus2(minus2_3), .red_arrayColumn_FinalRows(col3[3:0]), .pressedKey(pressThree));

//determines whether to add 2, add1, or subtract 2 from the overall score
//NOTE: This model assumes it is impossible for 2 buttons to be pressed at exactly the same clock cycle.
//Since a clock cycle is a miniscule fraction of a second, this is a fair assumption to make.
	always_comb begin
		if (pos2_0 | pos2_1 | pos2_2 | pos2_3) begin
			pos2 = 1;
			pos1 = 0;
			minus2 = 0;
		end
		else if (pos1_0 | pos1_1 | pos1_2 | pos1_3 | pos1_LastRow_0 | pos1_LastRow_1 | pos1_LastRow_2 | pos1_LastRow_3)  begin
			pos2 = 0;
			pos1 = 1;
			minus2 = 0;
		end
		else if (minus2_0 | minus2_1 | minus2_2 | minus2_3) begin
			pos2 = 0;
			pos1 = 0;
			minus2 = 1;
		end
		else begin
			pos2 = 0;
			pos1 = 0;
			minus2 = 0;
		end
	end
	
//keeps track of score and sets HEX values accordingly
//min score: 0 max score:999
scoreCountOnes track1(.HEX0(HEX0[6:0]), .inc10, .dec10, .pos2, .pos1, .minus2, .reset(SW[9]), .clk(clk[whichClock]));
scoreCountTens track10(.HEX1(HEX1[6:0]), .inc100, .dec100, .inc10, .dec10, .reset(SW[9]), .clk(clk[whichClock]));
scoreCountHundreds track100(.HEX2(HEX2[6:0]), .inc100, .dec100, .reset(SW[9]), .clk(clk[whichClock]));


endmodule

