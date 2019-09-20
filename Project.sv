module dff (clk, reset, a, valid_in, dff_out)
	input clk, reset, valid_in;
	input [7:0] a; 
	output logic [7:0] dff_out;

	always_ff @(posedge clk) begin
		if (reset == 1)
			dff_out <= 0;
		else if ((reset == 0) && (valid_in = 1))
			dff_out <= a;
		else if (valid == 0)
			dff_out <= 0;
		else
			dff_out <= 0;

module control (valid_in, valid_out, enable_a, enable_f)

module part2(clk, reset, a, valid_in, f,valid_out);
	input clk, reset, valid_in;
	input [7:0] a; 
	output logic [19:0] f;
	output logic valid_out;
