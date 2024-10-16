module mux2(
	input [1:0] sel,
	input a, b, c, d,
	output q
	);
	wire t1, t2;
	
	mux2to1 m0(t1, sel[0], a, b);
	mux2to1 m1(t2, sel[0], c, d);
	mux2to1 m2(q, sel[1], t1, t2);
endmodule

module mux2to1(
	input sel, a, b,
	output q
	);
	wire selbar, a1, a2;
	
	not(selbar, sel);
	and(a1, selbar, a);
	and(a2, sel, b);
	or(q, a1, a2);
endmodule
