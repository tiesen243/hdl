module fsm(
	input ck, rs, i,
	output reg y1 = 1'b0,
	output reg y2 = 1'b0
);

parameter start = 3'b000; 
parameter s1    = 3'b001;
parameter s0    = 3'b010;
parameter s10   = 3'b011;
parameter s01	 = 3'b100;
parameter s101  = 3'b101;
parameter s010  = 3'b110;
parameter s0100 = 3'b111;

reg [2:0] next_state, current_state;

always @ (*) begin
	case (current_state)
		start:
			if (i) next_state = s1;
			else next_state = s0;
		s1:	
			if (i) next_state = current_state;
			else next_state = s10;
		s0:
			if (i) next_state = s01;
			else next_state = current_state;
		s10:
			if (i) next_state = s101;
			else next_state = s0;
		s01:
			if (i) next_state = s1;
			else next_state = s010;
		s101:
			if (i) next_state = s1;
			else next_state = s010;
		s010: 
			if (i) next_state = s101;
			else next_state = s0100;
		s0100:
			if (i) next_state = s01;
			else next_state = s0;
		default next_state = start;
	endcase
end

always @ (negedge ck or negedge rs) begin
	if (!rs) current_state <= start;
	else current_state <= next_state;
end
	
always @ (*) begin
	if (current_state == s101) begin 
		y1 = 1'b1;
		y2 = 1'b0;
	end
	else if (current_state == s0100) begin
		y1 = 1'b0;
		y2 = 1'b1;
	end
	else begin
		y1 = 1'b0;
		y2 = 1'b0;
	end
end

endmodule