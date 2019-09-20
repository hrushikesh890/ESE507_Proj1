module dff (clk, reset, a, enable_a, dff_out)
	input clk, reset, enable_a;
	input [7:0] a; 
	output logic [7:0] dff_out;

	always_ff @(posedge clk) begin
		if (reset == 1)
			dff_out <= 0;
		else if ((reset == 0) && (enable_a = 1))
			dff_out <= a;
		else if (valid == 0)
			dff_out <= 0;
		else
			dff_out <= 0;
	end
end

module control (valid_in, valid_out, enable_a, enable_f)
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
end
		


module part2(clk, reset, a, valid_in, f, valid_out);
	input clk, reset, valid_in;
	input [7:0] a; 
	output logic [19:0] f;
	output logic valid_out;
