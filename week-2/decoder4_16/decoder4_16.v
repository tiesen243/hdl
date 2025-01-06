module decoder4_16(
	input  [4:0]  SW,
	output reg [16:1] LEDR
);
		// Bai 1
		always @ (SW) begin
			case (SW)
				5'b10000: LEDR = 16'b1111111111111110;
				5'b10001: LEDR = 16'b1111111111111101;
				5'b10010: LEDR = 16'b1111111111111011;
				5'b10011: LEDR = 16'b1111111111110111;
				5'b10100: LEDR = 16'b1111111111101111;
				5'b10101: LEDR = 16'b1111111111011111;
				5'b10110: LEDR = 16'b1111111110111111;
				5'b10111: LEDR = 16'b1111111101111111;
				5'b11000: LEDR = 16'b1111111011111111;
				5'b11001: LEDR = 16'b1111110111111111;
				5'b11010: LEDR = 16'b1111101111111111;
				5'b11011: LEDR = 16'b1111011111111111;
				5'b11100: LEDR = 16'b1110111111111111;
				5'b11101: LEDR = 16'b1101111111111111;
				5'b11110: LEDR = 16'b1011111111111111;
				5'b11111: LEDR = 16'b0111111111111111;
				default:  LEDR = 16'b1111111111111111;
			endcase
		end
	
	// Bai 2
	//	wire E1, E2, ns4, nw3;
	//
	//	not N1(ns4, SW[4]);
	//	not N2(ns3, SW[3]);
	//	and A1(E1, ns4,   ns3);
	//	and A2(E2, ns4, SW[3]);
	//
	//	decoder3_8 D1(E1, SW[2:0], LEDR[8 :1]);
	//	decoder3_8 D2(E2, SW[2:0], LEDR[16:9]);
endmodule

module decoder3_8(
	input  e,
	input  [2:0] in,
	output [7:0] out
);
	wire ni2, ni1, ni0;
	wire [7:0] o;
	
	not Na(ni0, in[0]);
	not Nb(ni1, in[1]);
	not Nc(ni2, in[2]);
	
	and A0(o[0], e,   ni2,   ni1,   ni0);
	and A1(o[1], e,   ni2,   ni1, in[0]);
	and A2(o[2], e,   ni2, in[1],   ni0);
	and A3(o[3], e,   ni2, in[1], in[0]);
	and A4(o[4], e, in[2],   ni1,   ni0);
	and A5(o[5], e, in[2],   ni1, in[0]);
	and A6(o[6], e, in[2], in[1],   ni0);
	and A7(o[7], e, in[2], in[1], in[0]);
	
	not N0(out[0], o[0]);
	not N1(out[1], o[1]);
	not N2(out[2], o[2]);
	not N3(out[3], o[3]);
	not N4(out[4], o[4]);
	not N5(out[5], o[5]);
	not N6(out[6], o[6]);
	not N7(out[7], o[7]);
endmodule

















