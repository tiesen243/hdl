module fsm3(
	input ck, rs,
	output reg [7:0] seg
);

parameter s0 = 3'b000;
parameter s1 = 3'b001;
parameter s2 = 3'b010;
parameter s3 = 3'b011; 
parameter s4 = 3'b100; 
parameter s5 = 3'b101; 

reg [2:0] next_state, current_state;

always @ (*) begin
	case(current_state)
		s0: next_state = s1;
		s1: next_state = s2;
		s2: next_state = s3;
		s3: next_state = s4;
		s4: next_state = s5;
		s5: next_state = s0;
	endcase
end

always @ (posedge ck) begin
	if (rs) current_state <= s0;
	else current_state <= next_state;
end

always @ (*) begin
	case(current_state)
		s0: seg = 8'h88; // A
		s1: seg = 8'h83; // B
		s2: seg = 8'hc6; // C
		s3: seg = 8'ha1; // D
		s4: seg = 8'h86; // E
		s5: seg = 8'h8e; // F
	endcase
end

endmodule