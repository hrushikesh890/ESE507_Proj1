module dff (clk, reset, a, enable_a, dff_out);
	input clk, reset, enable_a;
	input [7:0] a; 
	output logic [7:0] dff_out;

	always_ff @(posedge clk) begin
	  if (reset == 1)
		 dff_out <= 0;
	  else if ((reset == 0) && (enable_a == 1))
		 dff_out <= a;
	  /*else if (enable_a == 0)
		 dff_out <= 0;
	  else
		 dff_out <= 0;*/
	end
endmodule

module control (clk,valid_in, valid_out, enable_a, enable_f, reset);
	input clk, valid_in, reset;
	output logic valid_out, enable_a, enable_f;

	always_comb begin
			enable_a = valid_in;
	end

	always_ff@(posedge clk) begin
		if (reset == 1) begin
			enable_a <= 0;
			enable_f <= 0;
			valid_out <= 0;
		end
		else begin	 
			enable_f <= enable_a;
			valid_out <= enable_f;
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
	  /*else if (enable_f == 0)
		 f <= 0;
	  else
		 f <= 0;*/
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

	control i0 ( .clk(clk),.valid_in(valid_in), .valid_out(valid_out), .enable_a(w_en_a), .enable_f(w_en_f), .reset(reset));
	dff i1 (.clk(clk), .a(a), .reset(reset), .enable_a(w_en_a), .dff_out(w_dff));

	assign w_mult = w_dff * w_dff;
	assign w_sum = w_mult + f;

	op_dff i3 (.d_in(w_sum), .enable_f(w_en_f), .clk(clk), .reset(reset), .f(f));
endmodule






// This is a very small testbench for you to check that you have the right
// idea for the input/output timing.

// This should not be your only test -- it's simply a basic way to make
// sure you have the right idea.



module tb_part2();

	logic clk, reset, valid_in, valid_out, overflow;
	logic [7:0] a;
	logic [19:0] f;

	part2 dut(.clk(clk), .reset(reset), .a(a), .valid_in(valid_in), .f(f), .valid_out(valid_out));

	initial clk = 0;
	always #5 clk = ~clk;

	initial begin

	  // Before first clock edge, initialize
	  reset = 1;
	  a = 0;
	  valid_in = 0;

	  @(posedge clk);
	  #1; // After 1 posedge
	  reset = 0; a = 10; valid_in = 0;
	  @(posedge clk);
	  #1; // After 2 posedges
	  a = 21; valid_in = 1;
	  @(posedge clk);
	  #1; // After 3 posedges
	  a = 36; valid_in = 1;
	  @(posedge clk);
	  #1; // After 4 posedges
	  a = 40; valid_in = 0;
	  @(posedge clk);
	  #1; // After 5 posedges
	  a = 50; valid_in = 0;
	  @(posedge clk);
	  #1; // After 6 posedges
	  a = 64;  valid_in = 1;
	  @(posedge clk);
	  #1; // After 7 posedges
	  a = 0;  valid_in = 1;
	  @(posedge clk);
	  #1; // After 8 posedges
	  a = 255;  valid_in = 1;

	end // initial begin

	initial begin
	  @(posedge clk);
	  #1; // After 1 posedge
	  $display("valid_out = %b. Expected value is 0.", valid_out);
	  $display("f = %d. Expected value is 0.", f);

	  @(posedge clk);
	  #1; // After 2 posedges
	  $display("valid_out = %b. Expected value is 0.", valid_out);
	  $display("f = %d. Expected value is 0.", f);

	  @(posedge clk);
	  #1; // After 3 posedges
	  $display("valid_out = %b. Expected value is 0.", valid_out);
	  $display("f = %d. Expected value is 0.", f);

	  @(posedge clk);
	  #1; // After 4 posedges
	  $display("valid_out = %b. Expected value is 1.", valid_out);
	  $display("f = %d. Expected value is 441.", f);

	  @(posedge clk);
	  #1; // After 5 posedges
	  $display("valid_out = %b. Expected value is 1.", valid_out);
	  $display("f = %d. Expected value is 1737.", f);

	  @(posedge clk);
	  #1; // After 6 posedges
	  $display("valid_out = %b. Expected value is 0.", valid_out);
	  $display("f = %d. Expected value is don't care (probably will be 1737 in your design).", f);

	  @(posedge clk);
	  #1; // After 7 posedges
	  $display("valid_out = %b. Expected value is 0.", valid_out);
	  $display("f = %d. Expected value is is don't care (probably will be 1737 in your design).", f);

	  @(posedge clk);
	  #1; // After 8 posedges
	  $display("valid_out = %b. Expected value is 1.", valid_out);
	  $display("f = %d. Expected value is 5833.", f);

	  @(posedge clk);
	  #1; // After 9 posedges
	  $display("valid_out = %b. Expected value is 1.", valid_out);
	  $display("f = %d. Expected value is 5833.", f);

	  @(posedge clk);
	  #1; // After 10 posedges
	  $display("valid_out = %b. Expected value is 1.", valid_out);
	  $display("f = %d. Expected value is 56458.", f);

	  #20;
	  $finish;
	end

endmodule // tb_part2_mac
