module flip_flop_2(
	input [1:0] KEY, // ck
	input [1:0] SW, // SW[0]: reset
	output reg [4:0] LEDR
);
	always @ (posedge KEY[1] or  negedge SW[0]) begin
		if (SW[0] == 0) LEDR[4:1] <= 4'b1100;
		else begin
			LEDR[4:1] <= LEDR[4:1] - 1;
			if (LEDR[4:1] == 4'b0000) LEDR[4:1] <= 4'b1100;
		end
	end
endmodule
