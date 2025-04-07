module fsm_3
(
	input	CLOCK_50,
	input [0:0] SW,
	output reg [7:0] HEX3, HEX2, HEX1, HEX0
);
	reg		 [2:0] state;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;

	reg clk = 1'b0;
	integer q;
	
	always @ (posedge CLOCK_50) begin
		q = q + 1;
		
		if (q == 50000000) begin
			clk = ~clk;
			q = 0;
		end
	end
	
	always @ (state) begin
		case (state)
			S0: begin
				HEX3 = ~8'h71;
				HEX2 = ~8'h73;
				HEX1 = ~8'h7D;
				HEX0 = ~8'h77;
			end
			S1: begin
				HEX2 = ~8'h71;
				HEX1 = ~8'h73;
				HEX0 = ~8'h7D;
				HEX3 = ~8'h00;
			end
			S2: begin
				HEX1 = ~8'h71;
				HEX0 = ~8'h73;
				HEX3 = ~8'h77;
				HEX2 = ~8'h00;
			end
			S3: begin
				HEX0 = ~8'h71;
				HEX3 = ~8'h7D;
				HEX2 = ~8'h77;
				HEX1 = ~8'h00;
			end
			S4: begin
				HEX3 = ~8'h73;
				HEX2 = ~8'h7D;
				HEX1 = ~8'h77;
				HEX0 = ~8'h00;
			end
			S5: begin
				HEX3 = ~8'h00;
				HEX2 = ~8'h00;
				HEX1 = ~8'h00;
				HEX0 = ~8'h00;
			end 
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
				S4: state <= S0;
				S5: state <= S0;
			endcase
	end
endmodule
