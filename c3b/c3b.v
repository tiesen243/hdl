module c3b(
	input  [6:0] SW, // G = SW[6], a = SW[5:3], b = SW[2:0]
	output [3:0] LEDR // S, I, E
);

	wire [2:0] O1, O2, O3;

	c1b C1(SW[6], SW[5], SW[2], O1);
	c1b C2(O1[0], SW[4], SW[1], O2);
	c1b C3(O2[0], SW[3], SW[0], O3);
	
	or X1(LEDR[1], O1[2], O2[2], O3[2]);
	or X2(LEDR[2], O3[0]);
	or X3(LEDR[3], O1[1], O2[1], O3[1]);
endmodule

module c1b(
	input  G, a, b,
	output reg [2:0] O // S, I, E
);
	always @ (*) begin
		if (G == 1'b1) begin
			if (G && (a && ~b)) O = 3'b100;
			else if (G && (~a && b)) O = 3'b010;
			else if (G && (a ~^ b)) O = 3'b001;
		end
		else O = 3'b000;
	end
endmodule