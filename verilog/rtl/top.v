`default_nettype none

//
// top level module
//

module rolfmobile99_top(
  input [7:0] io_in,
  output [7:0] io_out
);

  // note: these assigments should match inputs/outputs declared in info.yaml!
  wire clk = io_in[7];      // notused
  wire reset = io_in[6];    // notused
  wire xnor_a = io_in[5];
  wire nxor_b = io_in[4];
  wire [3:0] notused_in = io_in[3:0];

  assign io_out[7] = xnor_y;
  //assign io_out[6:0] = ... ; // notused


  // connect modules

  xnor1 xnor1(.a(xnor_a),
             .b(xnor_b),
             .y(xnor_y));

endmodule
