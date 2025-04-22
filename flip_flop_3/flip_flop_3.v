module flip_flop_3(
	input [2:0] KEY, // ck
	input [1:0] SW, // SW[0]: reset
	output reg [7:0] HEX0
);
	reg [4:0] q;
	always @ (posedge KEY[2] or  posedge SW[0]) begin
		if (SW[0] == 1) q <= 4'b0000;
		else begin
			q <= q + 1;
			if (q == 4'b1111) q <= 4'b0000;
		end
	end
	
	always @ (*) begin
		case (q)
			4'b0000: HEX0 = 8'hC0;
			4'b0001: HEX0 = 8'hF9;
			4'b0010: HEX0 = 8'hA4;
			4'b0011: HEX0 = 8'hB0;
			4'b0100: HEX0 = 8'h99;
			4'b0101: HEX0 = 8'h92;
			4'b0110: HEX0 = 8'h82;
			4'b0111: HEX0 = 8'hF8;
			4'b1000: HEX0 = 8'h80;
			4'b1001: HEX0 = 8'h90;
			4'b1010: HEX0 = 8'h88;
			4'b1011: HEX0 = 8'h83;
			4'b1100: HEX0 = 8'hC6;
			4'b1101: HEX0 = 8'hA1;
			4'b1110: HEX0 = 8'h86;
			4'b1111: HEX0 = 8'h8E;
			default: HEX0 = 8'hFF;
		endcase
	end
endmodule
