module flip_flop_1(
	input [1:0] KEY, // ck
	input [1:0] SW, // SW[0]: reset
	output reg [5:0] LEDR
);
	always @ (negedge KEY[1]) begin
		if (SW[0]) LEDR[5:1] <= 5'b00000;
		else begin
			LEDR[5:1] <= LEDR[5:1] + 1;
			if (LEDR[5:1] == 5'b10100) LEDR[5:1] <= 5'b00000;
		end
	end
endmodule
