// This is a very small testbench for you to check that you have the right
// idea for the input/output timing.

// This should not be your only test -- it's simply a basic way to make
// sure you have the right idea.

module tb_part3();

   logic clk, reset, valid_in, valid_out, overflow;
   logic [7:0] a;
   logic [9:0] g;

   part3 dut(.clk(clk), .reset(reset), .a(a), .valid_in(valid_in), .g(g), .valid_out(valid_out));

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
   end // initial begin

   initial begin
      @(posedge clk);
      #1; // After 1 posedge
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is 0.", g);

      @(posedge clk);
      #1; // After 2 posedges
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is 0.", g);

      @(posedge clk);
      #1; // After 3 posedges
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is 0.", g);

      @(posedge clk);
      #1; // After 4 posedges
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is 0.", g);

      @(posedge clk);
      #1; // After 5 posedges
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("g = %d. Expected value is 21.", g);

      @(posedge clk);
      #1; // After 6 posedges
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("g = %d. Expected value is 41.", g);

      @(posedge clk);
      #1; // After 7 posedges
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is don't care (probably will be 41 in your design).", g);

      @(posedge clk);
      #1; // After 8 posedges
      $display("valid_out = %b. Expected value is 0.", valid_out);
      $display("g = %d. Expected value is is don't care (probably will be 41 in your design).", g);

      @(posedge clk);
      #1; // After 9 posedges
      $display("valid_out = %b. Expected value is 1.", valid_out);
      $display("g = %d. Expected value is 76.", g);

      #20;
      $finish;
   end

endmodule // tb_part2_mac