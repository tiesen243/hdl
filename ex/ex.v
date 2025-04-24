module ex(
	input  CLOCK_50,
	input  [0:0] SW,
	output [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output [17:0] LEDR,
	output [7:0] LEDG
);
	yc1 y1(CLOCK_50, SW[0], HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	yc2 y2(CLOCK_50, SW[0], LEDG);
	yc3 y3(CLOCK_50, SW[0], LEDR);
endmodule

module yc1(
	input CK, RS,
	output reg [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	reg ck1s;
	integer q;
	always @ (posedge CK) begin
		q = q + 1;
		
		if (q == 25000000) begin
			ck1s = ~ck1s;
			q = 0;
		end
	end
	
	reg state;
	always @ (negedge ck1s) begin
		if (RS) state <= 0;
		else state <= ~state;
	end
	
	always @ (*) begin
		case (state)
			0: begin
				HEX7 = 8'hFF;
				HEX6 = 8'hFF;
				HEX5 = 8'hFF;
				HEX4 = 8'hFF;
				HEX3 = 8'hFF;
				HEX2 = 8'hFF;
				HEX1 = 8'hFF;
				HEX0 = 8'hFF;
			end
			1: begin
				HEX7 = 8'hA4;
				HEX6 = 8'hA4;
				HEX5 = 8'h82;
				HEX4 = 8'h92;
				HEX3 = 8'hB0;
				HEX2 = 8'h90;
				HEX1 = 8'h90;
				HEX0 = 8'hF9;
			end
		endcase
	end
endmodule

module yc2(
	input CK, RS,
	output reg [7:0] LEDG
);
	reg ck200ms;
	integer q;
	always @ (posedge CK) begin
		q = q + 1;
		
		if (q == 5000000) begin
			ck200ms = ~ck200ms;
			q = 0;
		end
	end
	
	reg [3:0] state;
	always @ (negedge ck200ms) begin
		if (RS) state <= 0;
		else begin
			state <= state + 1;
			if (state > 15) state <= 0;
		end
	end
	
	always @ (*) begin
		case (state)
		  	0: LEDG = 8'b00000000;
	  		1: LEDG = 8'b10000000;
			2: LEDG = 8'b11000000;
			3: LEDG = 8'b11100000;
			4: LEDG = 8'b11110000;
			5: LEDG = 8'b11111100;
			6: LEDG = 8'b11111110;
			7: LEDG = 8'b00000000;
			8: LEDG = 8'b00000001;
			9: LEDG = 8'b00000011;
			10: LEDG = 8'b00000111;
			11: LEDG = 8'b00001111;
			12: LEDG = 8'b00011111;
			13: LEDG = 8'b00111111;
			14: LEDG = 8'b01111111;
			15: LEDG = 8'b11111111;
	endcase
	end
endmodule

module yc3(
	input CK, RS,
	output reg [17:0] LEDR
);
	reg ck2Hz;
	integer q;
	always @ (posedge CK) begin
		q = q + 1;
		
		if (q == 12500000) begin
			ck2Hz = ~ck2Hz;
			q = 0;
		end
	end
	
	reg state;
	always @ (negedge ck2Hz) begin
		if (RS) state <= 0;
		else state <= ~state;
	end
	
	always @ (*) begin
		case (state) 
			0: LEDR = 18'h00000;
			1: LEDR = 18'hFFFFF;
		endcase
	end
endmodule
