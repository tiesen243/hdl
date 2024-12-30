module fsm5(
	input ck, rs,
	output reg [7:0] seg0, seg1, seg2, seg3, seg4
);

always @ (posedge ck or posedge rs) begin
	if (rs) begin
		seg0 = 8'h00;
		seg1 = 8'h00;
		seg2 = 8'h00;
		seg3 = 8'h00;
		seg4 = 8'h00;
	end else begin
		seg0 = 8'h76; // H
		seg1 = 8'h79; // E
		seg2 = 8'h38; // L
		seg3 = 8'h38; // L
		seg4 = 8'h3f; // O
	end
end

endmodule