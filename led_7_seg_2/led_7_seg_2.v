 module led_7_seg_2(
	input [3:0] SW,
	output reg [7:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
);
	
	parameter KO = 8'hC0;
	parameter MO = 8'hF9;
	parameter HA = 8'hA4;
	parameter BA = 8'hB0;
	parameter BO = 8'h99;
	parameter NA = 8'h92;
	parameter SA = 8'h82;
	parameter BY = 8'hF8;
	parameter TA = 8'h80;
	parameter CH = 8'h90;
	parameter VO = 8'hFF;

	always @ (*) begin
		HEX7 = VO;
		HEX6 = VO;
		HEX5 = VO;
		HEX4 = VO;
		HEX3 = VO;
		HEX2 = VO;
		
		case (SW)
			4'b0000: begin
				HEX1 = KO;
				HEX0 = KO;
			end
			4'b0001: begin
				HEX1 = KO;
				HEX0 = MO;
			end
			4'b0010: begin
				HEX1 = KO;
				HEX0 = HA;
			end
			4'b0011: begin
				HEX1 = KO;
				HEX0 = BA;
			end
			4'b0100: begin
				HEX1 = KO;
				HEX0 = BO;
			end
			4'b0101: begin
				HEX1 = KO;
				HEX0 = NA;
			end
			4'b0110: begin
				HEX1 = KO;
				HEX0 = SA;
			end
			4'b0111: begin
				HEX1 = KO;
				HEX0 = BY;
			end
			4'b1000: begin
				HEX1 = KO;
				HEX0 = TA;
			end
			4'b1001: begin
				HEX1 = KO;
				HEX0 = CH;
			end
			4'b1010: begin
				HEX1 = MO;
				HEX0 = KO;
			end
			4'b1011: begin
				HEX1 = MO;
				HEX0 = MO;
			end
			4'b1100: begin
				HEX1 = MO;
				HEX0 = HA;
			end
			4'b1101: begin
				HEX1 = MO;
				HEX0 = BA;
			end
			4'b1110: begin
				HEX1 = MO;
				HEX0 = BO;
			end
			4'b1111: begin
				HEX1 = MO;
				HEX0 = NA;
			end
		endcase
	end

endmodule
