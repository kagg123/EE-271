//accepts 2 10 bit binaries and outputs true if A > B
module ten_bit_comparator (trueOutput, A, B );
	
	input logic [9:0] A, B;
	output logic trueOutput;
	
	always_comb begin
		if (A[9] > B[9]) trueOutput = 1;
		else if (B[9] > A[9]) trueOutput = 0;
		else if (A[8] > B[8]) trueOutput = 1;
		else if (B[8] > A[8]) trueOutput = 0;
		else if (A[7] > B[7]) trueOutput = 1;
		else if (B[7] > A[7]) trueOutput = 0;
		else if (A[6] > B[6]) trueOutput = 1;
		else if (B[6] > A[6]) trueOutput = 0;
		else if (A[5] > B[5]) trueOutput = 1;
		else if (B[5] > A[5]) trueOutput = 0;
		else if (A[4] > B[4]) trueOutput = 1;
		else if (B[4] > A[4]) trueOutput = 0;
		else if (A[3] > B[3]) trueOutput = 1;
		else if (B[3] > A[3]) trueOutput = 0;
		else if (A[2] > B[2]) trueOutput = 1;
		else if (B[2] > A[2]) trueOutput = 0;
		else if (A[1] > B[1]) trueOutput = 1;
		else if (B[1] > A[1]) trueOutput = 0;
		else if (A[0] > B[0]) trueOutput = 1;
		else if (B[0] > A[0]) trueOutput = 0;
		else trueOutput = 0;
	end
	
endmodule

