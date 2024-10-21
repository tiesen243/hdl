module fsm4(
	input ck, rs,
	output reg [5:0] q,
	output reg [3:0] seg0, seg1
);

always @ (posedge ck or posedge rs) begin
	if (rs) q <= 6'b111100;
	else begin
		q <= q - 1;
		if (q == 6'b000000) q <= 6'b111100;
	end
end

always @ (posedge ck or posedge rs) begin
	seg0 = q % 10;
	seg1 = q / 10;
end

endmodule