module fsm7(
	input ck, rs,
	output reg [2:0] state,
	output reg [7:0] leds
);

always @(posedge ck or posedge rs) begin
	if (rs) state <= 3'b000;
	else state <= state + 1;
end

always @(posedge ck or posedge rs) begin
	if (rs) leds <= 8'b00000000;
	else begin
		case (state)
			3'b000: leds <= 8'b00000001; 
			3'b001: leds <= 8'b00000011; 
			3'b010: leds <= 8'b00000111; 
			3'b011: leds <= 8'b00001111; 
			3'b100: leds <= 8'b00011111;
			3'b101: leds <= 8'b00111111;
			3'b110: leds <= 8'b01111111;
			3'b111: leds <= 8'b11111111;
		endcase
	end
end

endmodule