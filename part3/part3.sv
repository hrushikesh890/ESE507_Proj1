module dff (clk, reset, a, enable_a, dff_out);
	input clk, reset, enable_a;
	input [7:0] a; 
	output logic [7:0] dff_out;

	always_ff @(posedge clk) begin
	  if (reset == 1)
		 dff_out <= 0;
	  else if ((reset == 0) && (enable_a == 1))
		 dff_out <= a;
	end
endmodule

module control (clk,valid_in, valid_out, enable_a, enable_f, enable_g, reset);
	input clk, valid_in, reset;
	output logic valid_out, enable_a, enable_f, enable_g;

	always_comb begin
			enable_a = valid_in;
	end

	always_ff@(posedge clk) begin
		if (reset == 1) begin
			enable_f <= 0;
			valid_out <= 0;
			enable_g <= 0;
		end
		else begin	 
			enable_f <= enable_a;
			enable_g <= enable_f;
			valid_out <= enable_g;
		end
	end
endmodule

module op_dff (d_in, enable_f, clk, reset, f);
	input clk, reset, enable_f;
	input [19:0] d_in; 
	output logic [19:0] f;

	always_ff @(posedge clk) begin
	  if (reset == 1)
		 f <= 0;
	  else if ((reset == 0) && (enable_f == 1))
		 f <= d_in;
	end
endmodule

	  
module part3(clk, reset, a, valid_in, f, valid_out);
	input clk, reset, valid_in;
	input [7:0] a; 
	output logic [19:0] f;
	output logic valid_out;
	logic [7:0] w_dff;
	logic w_en_a, w_en_f, w_en_g;
	logic [15:0] w_mult;
	logic [19:0] w_sum;

	control i0 (.clk(clk), .valid_in(valid_in), .valid_out(valid_out), .enable_a(w_en_a), .enable_f(w_en_f), .enable_g(w_en_g), .reset(reset));
	dff i1 (.clk(clk), .a(a), .reset(reset), .enable_a(w_en_a), .dff_out(w_dff));

	assign w_mult = w_dff * w_dff;
	assign w_sum = w_mult + f;

	op_dff i3 (.d_in(w_sum), .enable_f(w_en_f), .clk(clk), .reset(reset), .f(f));
endmodule



// This is a very small testbench for you to check that you have the right
// idea for the input/output timing.

// This should not be your only test -- it's simply a basic way to make
// sure you have the right idea.



