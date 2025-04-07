module fsm_1
(
	input	CLOCK_50,
	input [0:0] SW,
	output reg [7:0] HEX0
);
	reg		[2:0]state = S0;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

	reg clk = 1'b0;
	integer q;
	
	always @ (posedge CLOCK_50) begin
		q = q + 1;
		
		if (q == 100000000) begin
			clk = ~clk;
			q = 0;
		end
	end
	
	always @ (state) begin
		case (state)
			S0: HEX0 = ~8'h76;
			S1: HEX0 = ~8'h79;
			S2: HEX0 = ~8'h38;
			S3: HEX0 = ~8'h38;
			S4: HEX0 = ~8'h3F;
			S5: HEX0 = 8'hFF;
			default: HEX0 = 8'hFF;
		endcase
	end

	always @ (posedge clk or posedge SW[0]) begin
		if (SW[0]) state <= S5;
		else
			case (state)
				S0: state <= S1;
				S1: state <= S2;
				S2: state <= S3;
				S3: state <= S4;
			   S4: state <= S5;
				S5: state <= S0;
			endcase
	end
endmodule
