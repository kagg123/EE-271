module counter (HEX, score);

	input logic  [2:0] score;  
	output logic [6:0] HEX;
	
	//enum { A, B, C, D, E, F, G, H} score_ps, score_ns;
	
	always_comb begin
		case (score)
			3'b000: begin 
						HEX = 7'b1000000; // 0 
				end
			3'b001: begin 
						HEX = 7'b1111001; // 1 
				end
			3'b010: begin 
						HEX = 7'b0100100; // 2 
				end
			3'b011: begin	
						HEX = 7'b0110000; // 3
				end
			3'b100: begin 
						HEX = 7'b0011001; // 4
				end
			3'b101: begin	
						HEX = 7'b0010010; // 5
				end
			3'b110: begin 
						HEX = 7'b0000010; // 6 
				end
			3'b111: begin 
						HEX = 7'b1111000; // 7 
				end

		endcase
	
	end

	endmodule
