module scoreCountHundreds (HEX2, inc100, dec100, reset, clk);

	input logic   inc100, dec100, reset, clk;  
	output logic [6:0] HEX2;
	
	enum {zero, one, two, three, four, five, six, seven, eight, nine} score_ps, score_ns;
	
	always_comb begin
		case (score_ps)
			zero: begin 
						HEX2 = 7'b1000000;       // 0
						if (inc100) 
							score_ns = one;
						else if (dec100)
							score_ns = nine;
						else 
							score_ns = zero;	
				end
			one: begin 
						HEX2 = 7'b1111001; // 1 
						if (inc100) 
							score_ns = two;
						else if (dec100)
							score_ns = zero;	
						else 
							score_ns = one; 
				end
			two: begin 
						HEX2 = 7'b0100100; // 2 
						if (inc100) 
							score_ns = three;
						else if (dec100)
							score_ns = one;
						else 
							score_ns = two; 
				end
			three: begin	
						HEX2 = 7'b0110000; // 3
						if (inc100) 
							score_ns = four;
						else if (dec100)
							score_ns = two;
						else  
							score_ns = three; 
				end
			four: begin 
						HEX2 = 7'b0011001; // 4
						if (inc100) 
							score_ns = five;
						else if (dec100)
							score_ns = three;	
						else 
							score_ns = four; 
				end
			five: begin	
						HEX2 = 7'b0010010; // 5
						if (inc100) 
							score_ns = six;
						else if (dec100)
							score_ns = four;	
						else 
							score_ns = five; 
				end
			six: begin 
						HEX2 = 7'b0000010; // 6
						if (inc100) 
							score_ns = seven;
						else if (dec100)
							score_ns = five;
						else 
							score_ns = six;
				end
			seven: begin 
						HEX2 = 7'b1111000; // 7 
						if (inc100) 
							score_ns = eight;
						else if (dec100)
							score_ns = six;
						else 
							score_ns = seven;
				end
			eight: begin 
						HEX2 = 7'b0000000; // 8
						if (inc100) 
							score_ns = nine;
						else if (dec100)
							score_ns = seven;
						else 
							score_ns = eight;
				end
			nine: begin 
						HEX2 = 7'b0011000; // 9
						if (inc100) 
							score_ns = zero;
						else if (dec100)
							score_ns = eight;
						else 
							score_ns = nine; 
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