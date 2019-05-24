//Keeps track of 10's place for score
//outputs increment for 100's place 
module scoreCountTens (HEX1, inc100, dec100, inc10, dec10, reset, clk);

	input logic   inc10, dec10, reset, clk;  
	output logic [6:0] HEX1;
	output logic inc100, dec100;
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} score_ps, score_ns;
	
	always_comb begin
		case (score_ps)
			zero: begin 
						HEX1 = 7'b1000000;       // 0
						if (inc10) begin
							score_ns = one; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = nine; inc100 = 0; dec100 = 1; end
						else begin
							score_ns = zero;	inc100 = 0; dec100 = 0; end
				end
			one: begin 
						HEX1 = 7'b1111001; // 1 
						if (inc10) begin
							score_ns = two; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = zero; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = one; inc100 = 0; dec100 = 0; end
				end
			two: begin 
						HEX1 = 7'b0100100; // 2 
						if (inc10) begin
							score_ns = three;inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = one; inc100 = 0; dec100 = 0; end
						
						else begin
							score_ns = two; inc100 = 0; dec100 = 0; end
				end
			three: begin	
						HEX1 = 7'b0110000; // 3
						if (inc10) begin
							score_ns = four; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = two; inc100 = 0; dec100 = 0; end
						else begin 
							score_ns = three; inc100 = 0; dec100 = 0; end
				end
			four: begin 
						HEX1 = 7'b0011001; // 4
						if (inc10) begin
							score_ns = five; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = three; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = four; inc100 = 0; dec100 = 0; end
				end
			five: begin	
						HEX1 = 7'b0010010; // 5
						if (inc10) begin
							score_ns = six; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = four; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = five; inc100 = 0; dec100 = 0; end
				end
			six: begin 
						HEX1 = 7'b0000010; // 6
						if (inc10) begin
							score_ns = seven; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = five; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = six;	inc100 = 0; dec100 = 0; end
				end
			seven: begin 
						HEX1 = 7'b1111000; // 7 
						if (inc10) begin
							score_ns = eight; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = six; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = seven; inc100 = 0; dec100 = 0; end
				end
			eight: begin 
						HEX1 = 7'b0000000; // 8
						if (inc10) begin
							score_ns = nine; inc100 = 0; dec100 = 0; end
						else if (dec10) begin
							score_ns = seven; inc100 = 0; dec100 = 0; end
						else begin
							score_ns = eight; inc100 = 0; dec100 = 0; end
				end
			nine: begin 
						HEX1 = 7'b0011000; // 9
						if (inc10) begin
							score_ns = zero; inc100 = 1; dec100 = 0; end
						else if (dec10) begin
							score_ns = eight; inc100 = 0; dec100 = 0; end	
						else begin
							score_ns = nine; inc100 = 0; dec100 = 0; end
				end
			

		endcase
	
	end

	always_ff @(posedge clk) begin
	if (reset) begin
		score_ps <= zero;
		end
	else begin
		score_ps <= score_ns;
		
		end
	end
	
endmodule
