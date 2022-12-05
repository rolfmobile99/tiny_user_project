`default_nettype none

//
// top level module
//

module rolfmobile99_top(
  input [18:0] io_in,  // 19 inputs
  output [8:0] io_out  // 9 outputs
);

  // note: these assigments should match inputs/outputs declared in info.yaml!
  wire clk = io_in[0];
  wire reset = io_in[1];
  wire xnor_a = io_in[2];
  wire xnor_b = io_in[3];

  // regfile inputs
  wire en1 = io_in[4];
  wire en2 = io_in[5];
  wire wrEn = io_in[6];
  wire [3:0] rdAddr1 = io_in[10:7];
  wire [3:0] rdAddr2 = io_in[14:11];
  wire [3:0] dataIn = io_in[18:15];

  
  // XNOR output
  assign io_out[0] = xnor_y;
  
  // regfile outputs
  assign io_out[4:1] = dataBusA;
  assign io_out[8:5] = dataBusB;


  // io_out[6:0] = ... ; // notused

  wire xnor_y;

  // connect modules

  // first, just an XNOR gate
  xnor1 xnor1(.a(xnor_a),
             .b(xnor_b),
             .y(xnor_y));

  // second, a 16x4 bit register file (see below!)

  // needs the following:
  // inputs: (4+15)
  // - clk 1
  // - reset 1
  // - xnor_a 1
  // - xnor_b 1
  //
  // - en1 1
  // - en2 1
  // - wrEn 1
  // - rdAddr1 4
  // - rdAddr2 4
  // - wrAddr 4  (can combine with rdAddr1)
  // - dataIn 4
  //
  // outputs (1+8):
  // - xnor_y 1
  //
  // - dataBusA 4
  // - dataBusB 4

  wire [3:0] dataBusA;
  wire [3:0] dataBusB;

  wire [3:0] wrAddr;

  assign wrAddr[3:0] = rdAddr1[3:0];    // combine with rdAddr1 to save input pins


  regfile16x4_dual regfile(.rdAddr1(rdAddr1),
                  .rdOutEn1(en1),
                  .rdAddr2(rdAddr2),
                  .rdOutEn2(en2),
                  .wrAddr(wrAddr),
                  .clk(clk),
                  .wrEn(wrEn),
                  .dataIn(dataIn),
                  .dataOut1(dataBusA),
                  .dataOut2(dataBusB) );

endmodule
