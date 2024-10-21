module fsm9(
	input ck, rs,    
	output reg [3:0] counter,
	output reg [1:0] state,
	output reg [2:0] light
);

parameter GREEN	= 3'b001; // Đèn xanh 
parameter YELLOW	= 3'b010; // Đèn vàng 
parameter RED		= 3'b100; // Đèn dỏ 

parameter GREEN_TIME		= 8; 
parameter YELLOW_TIME	= 4;
parameter RED_TIME 		= 12;

parameter S_GREEN  = 2'b00;
parameter S_YELLOW = 2'b01;
parameter S_RED    = 2'b10;

   
always @(posedge ck or negedge rs) begin
	if (!rs) begin
		state <= S_GREEN;
		counter <= 4'b0000;
	end else begin
		counter <= counter + 1;
		case (state)
			S_GREEN: begin
				if (counter == GREEN_TIME - 1) begin
					state <= S_YELLOW;
					counter <= 4'b0000;
				end
			end
			S_YELLOW: begin
				if (counter == YELLOW_TIME - 1) begin
					state <= S_RED;
					counter <= 4'b0000;
				end
			end
			S_RED: begin
				if (counter == RED_TIME - 1) begin
					state <= S_GREEN;
					counter <= 4'b0000;
				end
			end
		endcase
	end
end

always @(posedge ck or negedge rs) begin
	if (!rs) light <= GREEN;
	else begin
		case (state)
			S_GREEN: light <= GREEN;
			S_YELLOW:light <= YELLOW;
			S_RED:	light <= RED;  
		endcase
	end
end
endmodule
