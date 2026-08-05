`timescale 1ns / 1ps
`include "Parameter.v"
`include "Processor.v"
// fpga4student.com 
// FPGA projects, VHDL projects, Verilog projects 
// Verilog code for RISC Processor 
// Verilog testbench code to test the processor
module test_Risc_16_bit;

 // Inputs
 reg clk;
 reg reset;

 // Instantiate the Unit Under Test (UUT)
 Risc_16_bit uut (
  .clk(clk),
  .reset(reset)
 );

 initial 
  begin
    $dumpfile("RISC_16_bit.vcd");
    $dumpvars(0, uut);
   clk <=0;
   reset<=0;
   #20 // 2 clk cycles   
   reset<=1;
   `simulation_time;
   $finish;
   $display("Test complete!");
  end

 always 
  begin
   #5 clk = ~clk;
  end

endmodule

