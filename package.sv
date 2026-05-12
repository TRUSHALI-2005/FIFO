package fifo_pkg;
parameter DATA_WIDTH = 8;
parameter DEPTH = 16;
`include "define.svh"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
// `include "reference.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
endpackage
