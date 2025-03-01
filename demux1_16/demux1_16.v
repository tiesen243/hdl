module demux1_16(LEDR,SW);
	input [5:1] SW;
	output [16:1]LEDR;
	wire notS5;
	
	not(notS5, SW[5]);
	demux1_8 u1(LEDR[ 8:1], SW[5], SW[4:2], SW[1]); //sw4:cho phep , sw3:1 : select , sw 0 : D
	demux1_8 u2(LEDR[16:9], notS5, SW[4:2], SW[1]);
endmodule

module demux1_8(Y, E, S, D); //S:dau vao , D: ngo vao du lieu , E:cho phep, Y: ngo ra tin hieu
	input [2:0] S;
	input D;
	input E;
	output reg [7:0] Y;
	
	always @(*) begin
		if (E & (~S[2] & ~S[1] & ~S[0])) Y = {7'b0000000,D};
		else if (E & (~S[2] & ~S[1] & S[0])) Y = {6'b000000,D,1'b0};
		else if (E & (~S[2] & S[1] & ~S[0])) Y = {5'b00000,D,2'b00};
		else if (E & (~S[2] & S[1] & S[0])) Y = {4'b0000,D,3'b000};
		else if (E & (S[2] & ~S[1] & ~S[0])) Y = {3'b000,D,4'b0000};
		else if (E & (S[2] & ~S[1] & S[0])) Y = {2'b00,D,5'b00000};
		else if (E & (S[2] & S[1] & ~S[0])) Y = {1'b0,D,6'b000000};
		else if (E & (S[2] & S[1] & S[0])) Y =  {D,7'b0000000};
		else Y = 8'b00000000;
		
	end
endmodule	
	