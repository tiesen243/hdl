module fsm2(
	input ck, rs,
	output reg [3:0]y = 4'b0000
);

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011;
parameter s4 = 3'b100;
parameter s5 = 3'b101;
parameter s6 = 3'b110;
parameter s7 = 3'b111;

reg [2:0] next_state, current_state;

always @ (*) begin
	case(current_state)
		s0: next_state = s1;
		s1: next_state = s2;
		s2: next_state = s3;
		s3: next_state = s4;
		s4: next_state = s5;
		s5: next_state = s6;
		s6: next_state = s7;
		s7: next_state = s0;
	endcase
end

always @ (posedge ck) begin
	if (rs) current_state <= s0;
	else current_state <= next_state;
end

always @ (*) begin
	case(current_state)
		s0: y = 4'b0000;
		s1: y = 4'b0001;
		s2: y = 4'b0010;
		s3: y = 4'b1000;
		s4: y = 4'b0000;
		s5: y = 4'b0000;
		s6: y = 4'b0011;
		s7: y = 4'b0111;
	endcase
end

endmodule