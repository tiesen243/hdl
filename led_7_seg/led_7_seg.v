module led_7_seg(
	input  [17:0] SW,
	output [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	
	wire [2:0] M;
	mux_5_1 MX(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], M);
	
	show(M, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
endmodule

module mux_5_1(
	input [2:0] S, A, B, C, D, E,
	output reg [2:0] M
);

	always @ (*) begin
		case (S)
			3'b000: M = A;
			3'b001: M = B;
			3'b010: M = C;
			3'b011: M = D;
			3'b100: M = E;
			default: M = 3'b000;
		endcase
	end

endmodule

module show(
	input [2:0] M,
	output reg [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	parameter H = 8'h89;
	parameter E = 8'h86;
	parameter L = 8'hC7;
	parameter O = 8'hC0;
	parameter V = 8'hFF;
	
	always @ (*) begin
		case (M)
			3'b000: begin
				HEX7 = V;
				HEX6 = V;
				HEX5 = V;
				HEX4 = H;
				HEX3 = E;
				HEX2 = L;
				HEX1 = L;
				HEX0 = O;
			end
			3'b001: begin
				HEX7 = V;
				HEX6 = V;
				HEX5 = H;
				HEX4 = E;
				HEX3 = L;
				HEX2 = L;
				HEX1 = O;
				HEX0 = V;
			end
			3'b010: begin
				HEX7 = V;
				HEX6 = H;
				HEX5 = E;
				HEX4 = L;
				HEX3 = L;
				HEX2 = O;
				HEX1 = V;
				HEX0 = V;
			end
			3'b011: begin
				HEX7 = H;
				HEX6 = E;
				HEX5 = L;
				HEX4 = L;
				HEX3 = O;
				HEX2 = V;
				HEX1 = V;
				HEX0 = V;
			end
			3'b100: begin
				HEX7 = E;
				HEX6 = L;
				HEX5 = L;
				HEX4 = O;
				HEX3 = V;
				HEX2 = V;
				HEX1 = V;
				HEX0 = H;
			end
			3'b101: begin
				HEX7 = L;
				HEX6 = L;
				HEX5 = O;
				HEX4 = V;
				HEX3 = V;
				HEX2 = V;
				HEX1 = H;
				HEX0 = E;
			end
			3'b110: begin
				HEX7 = L;
				HEX6 = O;
				HEX5 = V;
				HEX4 = V;
				HEX3 = V;
				HEX2 = H;
				HEX1 = E;
				HEX0 = L;
			end
			3'b111: begin
				HEX7 = O;
				HEX6 = V;
				HEX5 = V;
				HEX4 = V;
				HEX3 = H;
				HEX2 = E;
				HEX1 = L;
				HEX0 = L;
			end
		endcase
	end

endmodule
