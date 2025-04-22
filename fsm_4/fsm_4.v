module fsm_4(
	input	CLOCK_50,
	input [2:0] SW,
	output [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output [7:0] LEDG,
	output [17:0] LEDR
);
	wire ck2hz, ck4hz, ck100ms;
	
	div2hz D1(CLOCK_50, ck2hz);
	div4hz D2(CLOCK_50, ck4hz);
	div100ms D3(CLOCK_50, ck100ms);
	
	goodbye M1(ck2hz, SW[0], HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	blink M2(ck4hz, SW[1], LEDG);
	wave M3(ck100ms, SW[2], LEDR);
endmodule

module goodbye(
	input ck, rs,
	output reg [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	reg		 state;
	parameter S0 = 0, S1 = 1;
	
	always @ (state) begin
		case (state)
			S0: begin
				HEX7 = 8'hFF;
				HEX6 = 8'hFF;
				HEX5 = 8'hFF;
				HEX4 = 8'hFF;
				HEX3 = 8'hFF;
				HEX2 = 8'hFF;
				HEX1 = 8'hFF;
				HEX0 = 8'hFF;
			end
			S1: begin
				HEX7 = ~8'h6F;
				HEX6 = ~8'h5C;
				HEX5 = ~8'h5C;
				HEX4 = ~8'h5E;
				HEX3 = ~8'h7C;
				HEX2 = ~8'h66;
				HEX1 = ~8'h79;
				HEX0 = ~8'h30;
			end
		endcase
	end
	
	always @ (negedge ck) begin
		if (rs) state <= S0;
		else case (state)
			S0: state <= S1;
			S1: state <= S0;
		endcase
	end
endmodule

module blink(
	input ck, rs,
	output reg [7:0] LEDG
);
	reg		 state;
	parameter S0 = 0, S1 = 1;
	
	always @ (state) begin
		case (state)
			S0: LEDG = 8'h00;
			S1: LEDG = 8'hFF;
		endcase
	end
	
	always @ (negedge ck) begin
		if (rs) state <= S0;
		else case (state)
			S0: state <= S1;
			S1: state <= S0;
		endcase
	end
endmodule

module wave(
	input ck, rs,
	output reg [17:0] LEDR
);
	reg		 [4:0] count;
	reg 		 [2:0] curr_state, next_state;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4;
	
	always @ (curr_state) begin
		case (curr_state)
			S0: next_state <= S1;
			S1: next_state = (count == 17) ? S2 : S1;
			S2: next_state = S3;
			S3: next_state = (count == 0) ? S4 : S3;
			S4: next_state = S1;
			default: next_state = S0;
		endcase
	end
	
	always @ (negedge ck) begin
		if (rs) curr_state <= S0;
		else curr_state <= next_state;
	end
	
	always @ (negedge ck) begin
		case (curr_state)
			S0: begin
				LEDR <= 18'b000000000000000000;
				count <= 0;
			end
			S1: begin
				LEDR <= (count == 0) ? 18'b100000000000000000 : (LEDR >> 1) | 18'b100000000000000000;
				count <= count + 1;
			end
			S2: LEDR <= 18'b0;
			S3: begin
				LEDR <= (count == 17) ? 18'b000000000000000001 : (LEDR << 1'h1) | 1'b1;
				count <= count - 1;
			end
			S4: begin
				LEDR <= 18'b000000000000000000;
				count <= 0;
			end
		endcase
	end
endmodule

module div2hz(
	input ck_in,
	output reg ck_out
);
	integer q;
	always @ (posedge ck_in) begin
		q = q + 1;
		
		if (q == 12500000) begin
			ck_out = ~ck_out;
			q = 0;
		end
	end
endmodule

module div4hz(
	input ck_in,
	output reg ck_out
);
	integer q;
	always @ (posedge ck_in) begin
		q = q + 1;
		
		if (q == 6250000) begin
			ck_out = ~ck_out;
			q = 0;
		end
	end
endmodule

module div100ms(
	input ck_in,
	output reg ck_out
);
	integer q;
	always @ (posedge ck_in) begin
		q = q + 1;
		
		if (q == 2500000) begin
			ck_out = ~ck_out;
			q = 0;
		end
	end
endmodule
