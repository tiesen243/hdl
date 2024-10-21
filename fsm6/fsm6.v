module fsm6(
	input ck, rs,
	output reg [4:0] q,
	output reg [7:0] seg0, seg1, seg2, seg3, seg4
);

parameter h = 8'h76;
parameter a = 8'h77;
parameter p = 8'h73;
parameter y = 8'h66;
parameter blank = 8'h00;

always @ (posedge ck or posedge rs) begin
	if (rs) q <= 4'b0000;
	else begin 
		q <= q + 1;
		if (q == 4'b1001) q <= 4'b0000;
	end
end

always @ (posedge ck or posedge rs) begin
	if (rs) begin
		seg0 = blank;
		seg1 = blank; 
		seg2 = blank;
		seg3 = blank;
		seg4 = blank;
	end else begin 
		case(q)
			4'b0000: begin
				seg0 = h;
				seg1 = a;
				seg2 = p;
				seg3 = p;
				seg4 = y;
			end
			4'b0001: begin
				seg0 = blank;
				seg1 = h;
				seg2 = a;
				seg3 = p;
				seg4 = p;
			end
			4'b0010: begin
				seg0 = blank;
				seg1 = blank;
				seg2 = h;
				seg3 = a;
				seg4 = p;
			end
			4'b0011: begin
				seg0 = blank;
				seg1 = blank;
				seg2 = blank;
				seg3 = h;
				seg4 = a;
			end
			4'b0100: begin
				seg0 = blank;
				seg1 = blank;
				seg2 = blank;
				seg3 = blank;
				seg4 = h;
			end
			4'b0101: begin
				seg0 = y;
				seg1 = blank;
				seg2 = blank;
				seg3 = blank;
				seg4 = blank;
			end
			4'b0110: begin
				seg0 = p;
				seg1 = y;
				seg2 = blank;
				seg3 = blank;
				seg4 = blank;
			end
			4'b0111: begin
				seg0 = p;
				seg1 = p;
				seg2 = y;
				seg3 = blank;
				seg4 = blank;
			end
			4'b1000: begin
				seg0 = a;
				seg1 = p;
				seg2 = p;
				seg3 = y;
				seg4 = blank;
			end
		endcase
	end
end

endmodule