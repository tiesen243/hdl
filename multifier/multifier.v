module multifier(
	input [6:0] SW, // a = [6, 5, 4]; b = [2, 1, 0]
	output [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	// F1
	wire c1;
	wire [2:0] r1;
	mul f1(1'b0, SW[6] & SW[0], SW[5] & SW[0], 
			 SW[6] & SW[1], SW[5] & SW[1], SW[4] & SW[1],
			 r1, c1);
	// F2
	wire c2;
	wire [2:0] r2;
	mul f2(c1, r1[2], r1[1], 
			 SW[6] & SW[2], SW[5] & SW[2], SW[4] & SW[2],
			 r2, c2);
	
	wire [5:0] r;
	assign r[0] = SW[4] & SW[0];
	assign r[1] = r1[0];
	assign r[2] = r2[0];
	assign r[3] = r2[1];
	assign r[4] = r2[2];
	assign r[5] = c2;
	
	encode_bcd e7(4'h0, HEX7);
	encode_bcd e6(SW[6:4], HEX6);
	encode_bcd e5(4'h0, HEX5);
	encode_bcd e4(SW[2:0], HEX4);
	encode_bcd e3(4'h0, HEX3);
	encode_bcd e2(4'h0, HEX2);
	encode_6bit(r, HEX1, HEX0);
endmodule

module mul(
	input a2, a1, a0, b2, b1, b0,
	output [2:0] m,
	output c_out
);
	wire c1, c2;
	
	fa m0(a0, b0, 1'b0, m[0], c1);
	fa m1(a1, b1, c1  , m[1], c2);
	fa m2(a2, b2, c2  , m[2], c_out);
endmodule

module fa(
	input a, b, c_in,
	output s, c_out
);
	wire a_xor_b = a ^ b;
	assign s = a_xor_b ^ c_in;
	assign c_out = (a & b) | (a_xor_b & c_in);
endmodule

module encode_bcd(
	input  [3:0] code,
	output reg [7:0] HEX
);
	always @ (*) begin
		case (code)
			4'b0000: HEX = 8'hC0;
			4'b0001: HEX = 8'hF9;
			4'b0010: HEX = 8'hA4;
			4'b0011: HEX = 8'hB0;
			4'b0100: HEX = 8'h99;
			4'b0101: HEX = 8'h92;
			4'b0110: HEX = 8'h82;
			4'b0111: HEX = 8'hF8;
			4'b1000: HEX = 8'h80;
			4'b1001: HEX = 8'h90;
			default: HEX = 8'hFF;
		endcase
	end
endmodule

module encode_6bit(
	input [5:0] inp,
	output reg [7:0] seg1, seg0
);
	function [7:0] seg_map;
		input [3:0] digit;
		begin 
			case (digit)
				4'b0000: seg_map = 8'hC0;
				4'b0001: seg_map = 8'hF9;
				4'b0010: seg_map = 8'hA4;
				4'b0011: seg_map = 8'hB0;
				4'b0100: seg_map = 8'h99;
				4'b0101: seg_map = 8'h92;
				4'b0110: seg_map = 8'h82;
				4'b0111: seg_map = 8'hF8;
				4'b1000: seg_map = 8'h80;
				4'b1001: seg_map = 8'h90;
			endcase
		end
	endfunction
	
	always @ (*) begin
		seg1 = seg_map(inp / 10);
		seg0 = seg_map(inp % 10); 
	end
endmodule
