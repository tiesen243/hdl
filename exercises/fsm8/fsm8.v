module fsm8(
	input ck, rs, x,
	output reg [3:0] state,
	output reg [9:0] leds
);

always @(posedge ck or posedge rs) begin
	if (rs) state <= 4'b0000; 
	else begin
		state <= state + 1;
		if (state == 4'b1010) state <= 4'b0000;
	end
end

always @(posedge ck or posedge rs) begin
	if (rs) leds <= 10'b0000000000;
	else if (x) begin
		case (state)
			4'b0000: leds <= 10'b0000000001;  
			4'b0001: leds <= 10'b0000000011;
			4'b0010: leds <= 10'b0000000111;
			4'b0011: leds <= 10'b0000001111;  
			4'b0100: leds <= 10'b0000011111;  
			4'b0101: leds <= 10'b0000111111;
			4'b0110: leds <= 10'b0001111111;
			4'b0111: leds <= 10'b0011111111;
			4'b1000: leds <= 10'b0111111111;
			4'b1001: leds <= 10'b1111111111;
			default: leds <= 10'b0000000000;
		endcase
	end else begin
		case (state)
			4'b0000: leds <= 10'b0000000001; 
			4'b0001: leds <= 10'b0000000010;
			4'b0010: leds <= 10'b0000000100;
			4'b0011: leds <= 10'b0000001000;
			4'b0100: leds <= 10'b0000010000;
			4'b0101: leds <= 10'b0000100000;
			4'b0110: leds <= 10'b0001000000;
			4'b0111: leds <= 10'b0010000000;
			4'b1000: leds <= 10'b0100000000;
			4'b1001: leds <= 10'b1000000000;
			default: leds <= 10'b0000000000;
		endcase
	end
end
endmodule
