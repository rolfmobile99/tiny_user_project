//
// regfile16x4.sv - 16 x 4-bit register file, single and dual port
//
// note: see below for dual read port version
//
// rev history:
//	12/4/2022 - based on LM3000 regfile.v
//
// inputs:
//	rdAddr - read address
//	rdOutEn - enable read register to appear on 'data' lines
//	wrAddr - write address
//	wrEn - write 'data' lines to selected (write) register
//	clk - this actually does the write
//	dataIn - data in (for register write)
//
// outputs:
//	dataOut - data out for register read (tristate)
//
module regfile(rdAddr, rdOutEn, wrAddr, wrEn, clk, dataIn, dataOut);

  input [3:0] rdAddr;   // 4-bit addressing
  input rdOutEn;
  input [3:0] wrAddr;
  input wrEn;
  input clk;
  input tri [3:0] dataIn;	// tristate
  output tri [3:0] dataOut;	// tristate
  
  reg [3:0] memory[0:15];	// we define 16 4-bit registers

  assign dataOut = (rdOutEn)? memory[rdAddr]: 4'bzzzz;

  always @(posedge clk) begin
    if (wrEn) begin
      // this writes to location wrAddr
      memory[wrAddr] <= dataIn;
    end
  end

endmodule


//
// regfile16x4_dual.sv - 16 x 4-bit register file
//
// rev history:
//	12/4/2022 - based on LM3000 regfile.v
//
// inputs:
//	rdAddr - read address
//	rdOutEn - enable read register to appear on 'data' lines
//	wrAddr - write address
//	wrEn - write 'data' lines to selected (write) register
//	clk - this actually does the write
//	dataIn - data in (for register write)
//
// outputs:
//	dataOut - data out for register read (tristate)
//

module regfile16x4_dual(rdAddr1, rdOutEn1, rdAddr2, rdOutEn2, wrAddr, wrEn, clk, dataIn, dataOut1, dataOut2);

  input [3:0] rdAddr1;   // 4-bit addressing
  input rdOutEn1;
  input [3:0] rdAddr2;
  input rdOutEn2;
  input [3:0] wrAddr;
  input wrEn;
  input clk;
  input [3:0] dataIn;
  output tri [3:0] dataOut1;	// tristate
  output tri [3:0] dataOut2;	// tristate
  
  reg [3:0] memory[0:15];	// we define 16 4-bit registers

  // note: these are dual read ports - does this synthesize??
  assign dataOut1 = (rdOutEn1)? memory[rdAddr1]: 4'bzzzz;

  assign dataOut2 = (rdOutEn2)? memory[rdAddr2]: 4'bzzzz;

  always @(posedge clk) begin
    if (wrEn) begin
      // this writes to location wrAddr
      //$display("** %g regfile: writing [%b] = %b (0x%0x)", $time, wrAddr, dataIn, dataIn);
      memory[wrAddr] <= dataIn;
    end
  end

  
endmodule
