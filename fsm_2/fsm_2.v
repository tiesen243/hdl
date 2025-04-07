module fsm_2
(
	input	CLOCK_50,
	input [0:0] SW,
	output reg [7:0] HEX3, HEX2, HEX1, HEX0
);
	reg		 state;
	parameter S0 = 0, S1 = 1;

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
				HEX3 = 8'hFF;
				HEX2 = 8'hFF;
				HEX1 = 8'hFF;
				HEX0 = 8'hFF;
			end
			S1: begin
				HEX3 = 8'h83;
				HEX2 = 8'h88;
				HEX1 = 8'h83;
				HEX0 = ~8'h66;
			end
		endcase
	end

	always @ (posedge clk or posedge SW[0]) begin
		if (SW[0]) state <= S0;
		else
			case (state)
				S0: state <= S1;
				S1: state <= S0;
			endcase
	end
endmodule
