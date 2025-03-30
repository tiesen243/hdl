module clock_2(
	input  CLOCK_50, 
	input  [0:0] SW,
	output [7:0] HEX1, HEX0
);
	wire [7:0] q;
	
	bcd_counter m1(CLOCK_50, SW[0], q);
	encode_bcd  m2(q[7:4], HEX1);
	encode_bcd  m3(q[3:0], HEX0);
endmodule

module bcd_counter(
	input  ck, rs,
	output reg [7:0] q
);
	reg temp_ck = 1'b0;
	integer temp_q;
	
	always @ (posedge ck) begin
		temp_q = temp_q + 1;
		
		if (temp_q == 7500000) begin
			temp_ck = ~temp_ck;
			temp_q = 0;
		end
	end
	
	always @ (posedge temp_ck) begin
		if (rs) q <= 8'h00;
		else begin
			q[3:0] <= q[3:0] + 1;	
			if (q[3:0] == 4'b1001) begin
				q[3:0] <= 4'b0000;
				q[7:4] <= q[7:4] + 1;
			end
			if (q == 8'h29) q <= 8'h00;
		end
	end
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

