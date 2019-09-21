module dff (clk, reset, a, enable_a, dff_out);
	input clk, reset, enable_a;
	input [7:0] a; 
	output logic [7:0] dff_out;

	always_ff @(posedge clk) begin
		if (reset == 1)
			dff_out <= 0;
		else if ((reset == 0) && (enable_a = 1))
			dff_out <= a;
		else if (enable_a == 0)
			dff_out <= 0;
		else
			dff_out <= 0;
	end
endmodule

module control (valid_in, valid_out, enable_a, enable_f);
	input valid_in;
	output logic valid_out, enable_a, enable_f;

	always_comb begin
		if (valid_in == 1)
			enable_a = 1;
			enable_f = 1;
			valid_out = 1;
		else
			enable_a = 0;
			enable_f = 0;
			valid_out = 0;
	end
endmodule

module op_dff (d_in, enable_f, clk, reset, f);
	input clk, reset, enable_f;
	input [19:0] d_in; 
	output logic [19:0] f;

	always_ff @(posedge clk) begin
		if (reset == 1)
			f <= 0;
		else if ((reset == 0) && (enable_f = 1))
			f <= d_in;
		else if (enable_f == 0)
			f <= 0;
		else
			f <= 0;
	end
endmodule

		
module part2(clk, reset, a, valid_in, f, valid_out);
	input clk, reset, valid_in;
	input [7:0] a; 
	output logic [19:0] f;
	output logic valid_out;
	wire logic [7:0] w_dff;
	wire logic w_en_a, w_en_f;
	wire logic [15:0] w_mult;
	wire logic [19:0] w_sum;

	control inst1 (.valid_in(valid_in), .valid_out(valid_out), .enable_a(w_en_a), .enable_f(w_en_f));
	dff inst1 (.clk(clk), .a(a), .reset(reset), .enable_a(w_en_a), .dff_out(w_dff));

	assign w_mult = w_dff * w_dff;
	assign w_sum = w_mult + f;

	op_dff inst1 (.d_in(w_sum), .enable_f(w_en_f), .clk(clk), .reset(reset), .f(f));
endmodule