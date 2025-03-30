module clock_1(
	input  CLOCK_50, 
	input  [0:0] SW,
	output reg [4:0] LEDR
);
	reg temp_ck = 1'b0;
	integer temp_q;
	
	initial begin
		LEDR = 5'b10011;
	end
	
	always @ (posedge CLOCK_50) begin
		temp_q = temp_q + 1;
		
		if (temp_q == 10000000) begin
			temp_ck = ~temp_ck;
			temp_q = 0;
		end
	end
	
	always @ (posedge temp_ck) begin
		if (SW[0]) LEDR <= 5'b10011;
		else begin
			LEDR <= LEDR - 1;			
			if (LEDR == 5'b00000) LEDR <= 5'b10011;
		end
	end
endmodule
