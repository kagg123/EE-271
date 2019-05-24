module scoreCountOnes (HEX0, inc10, dec10, pos2, pos1, minus2, reset, clk);

	input logic   pos2, pos1, reset, clk, minus2;  
	output logic [6:0] HEX0;
	output logic inc10, dec10;
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} score_ps, score_ns;
	
	always_comb begin
		case (score_ps)
			zero: begin 
						HEX0 = 7'b1000000;       // 0
						if (pos2) begin
							score_ns = two; inc10 = 0; dec10 = 0; end
						else if (pos1) begin
							score_ns = one; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = eight; inc10 = 0; dec10 = 1; end
						else begin
							score_ns = zero; inc10 = 0; dec10 = 0; end	
				end
			one: begin 
						HEX0 = 7'b1111001; // 1 
						if (pos2) begin
							score_ns = three; inc10 = 0; dec10 = 0; end
						else if (pos1)  begin
							score_ns = two; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = nine; inc10 = 0; dec10 = 1; end
						else begin
							score_ns = one; inc10 = 0; dec10 = 0; end
				end
			two: begin 
						HEX0 = 7'b0100100; // 2 
						if (pos2) begin
							score_ns = four; inc10 = 0; dec10 = 0; end
						else if (pos1) begin
							score_ns = three; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = zero; inc10 = 0; dec10 = 0; end
						else  begin
							score_ns = two; inc10 = 0; dec10 = 0; end
				end
			three: begin	
						HEX0 = 7'b0110000; // 3
						if (pos2) begin
							score_ns = five;inc10 = 0; dec10 = 0; end 
						else if (pos1) begin
							score_ns = four; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = one; inc10 = 0; dec10 = 0; end
						else begin
							score_ns = three; inc10 = 0; dec10 = 0; end
				end
			four: begin 
						HEX0 = 7'b0011001; // 4
						if (pos2) begin
							score_ns = six; inc10 = 0; dec10 = 0; end
						else if (pos1) begin
							score_ns = five; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = two; inc10 = 0; dec10 = 0; end
						else  begin
							score_ns = four; inc10 = 0; dec10 = 0; end
				end
			five: begin	
						HEX0 = 7'b0010010; // 5
						if (pos2) begin
							score_ns = seven; inc10 = 0; dec10 = 0; end 
						else if (pos1) begin
							score_ns = six; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = three; inc10 = 0; dec10 = 0; end	
						else begin
							score_ns = five; inc10 = 0; dec10 = 0; end
				end
			six: begin 
						HEX0 = 7'b0000010; // 6
						if (pos2) begin
							score_ns = eight; inc10 = 0; dec10 = 0; end
						else if (pos1) begin
							score_ns = seven; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = four; inc10 = 0; dec10 = 0; end
						else begin
							score_ns = six; inc10 = 0; dec10 = 0; end	
				end
			seven: begin 
						HEX0 = 7'b1111000; // 7 
						if (pos2) begin
							score_ns = nine; inc10 = 0; dec10 = 0; end
						else if (pos1) begin
							score_ns = eight; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = five; inc10 = 0; dec10 = 0; end
						else begin
							score_ns = seven; inc10 = 0; dec10 = 0; end
				end
			eight: begin 
						HEX0 = 7'b0000000; // 8
						if (pos2) begin
							score_ns = zero; inc10 = 1; dec10 = 0;  end
						else if (pos1) begin
							score_ns = nine; inc10 = 0; dec10 = 0; end
						else if (minus2) begin
							score_ns = six; inc10 = 0; dec10 = 0; end
						else begin
							score_ns = eight; inc10 = 0; dec10 = 0; end
				end
			nine: begin 
						HEX0 = 7'b0011000; // 9
						if (pos2) begin
							score_ns = one; inc10 = 1; dec10 = 0; end
						else if (pos1) begin
							score_ns = zero; inc10 = 1; dec10 = 0; end
						else if (minus2) begin
							score_ns = seven; inc10 = 0; dec10 = 0; end
						else begin
							score_ns = nine; inc10 = 0; dec10 = 0; end
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
	
//testbench
//module counter_testbench();
//
//	logic [2:0] score;  
//	logic [6:0] HEX;
//	
//	counter counterdut(.HEX, .score);
//
// initial begin
//	 for(i = 0; i <8; i++) begin
//		score[2:0] = i; #10;
//	 end
// end
//endmodule
