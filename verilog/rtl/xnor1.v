// Code your design here


// 1-bit XNOR gate
module xnor1(a, b, y);

  input a, b;
  output y;

  assign y = ~(a ^ b);	// xnor

endmodule
