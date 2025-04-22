module fsm_5(
	input CLOCK_50,
	input [0:0] SW,
	output reg [17:0] LEDR,
	output reg [0:0] LEDG,
	output [7:0] HEX1, HEX0
);
	wire ck1s;
	
	div1s D1(CLOCK_50, ck1s);
	
	reg [4:0] current_state, next_state;

  always @ (*) begin
    if (current_state > 29) next_state = 0;
    else next_state = current_state + 1;
  end
	
	always @ (negedge ck1s) begin
    if (SW[0]) current_state <= 0;
    else current_state <= next_state;
	end
	
	always @ (*) begin
    LEDG = 1'b0;
    LEDR = 18'b000000000000000000;

    if (current_state <= 15) begin
      LEDG = 1'b1;
      LEDR = 18'b000000000000000000;
    end else if (current_state <= 20) begin
      LEDG = 1'b0;
      LEDR = 18'b100000000000000000;
    end else if (current_state <= 29) begin
      LEDG = 1'b0;
      LEDR = 18'b000000000000000001;
    end
	end

  reg [4:0] count;
  always @ (*) begin
    if (current_state <= 15) count = 15 - current_state;
    else if (current_state <= 20) count = 20 - current_state + 5;
    else count = 29 - current_state + 9;
  end

	
  wire [3:0] tens = count / 10, ones = count % 10;
	encode_bcd E0(tens, HEX1);
	encode_bcd E1(ones, HEX0);
endmodule

module div1s(
	input ck_in,
	output reg ck_out
);
	integer q;
	always @ (posedge ck_in) begin
		q = q + 1;
		
		if (q == 25000000) begin
			ck_out = ~ck_out;
			q = 0;
		end
	end
endmodule

module encode_bcd(
	input  [3:0] code,
	output reg [7:0] HEX
);
	always @ (*) begin
		case (code)
			4'b0000: HEX = 8'hC0;
			4'b0001: HEX = 8'hF9;
			4'b0010: HEX = 8'hA4;
			4'b0011: HEX = 8'hB0;
			4'b0100: HEX = 8'h99;
			4'b0101: HEX = 8'h92;
			4'b0110: HEX = 8'h82;
			4'b0111: HEX = 8'hF8;
			4'b1000: HEX = 8'h80;
			4'b1001: HEX = 8'h90;
			default: HEX = 8'hFF;
		endcase
	end
endmodule
