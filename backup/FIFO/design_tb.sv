`include "package.sv"
`include "interface.sv"
import fifo_pkg::*;

module testbench;
  
  inf inff();
  
  test t1;
  
  syn_FIFO #( .DEPTH(DEPTH),
                 .DATA_WIDTH(DATA_WIDTH) )
           DUT
           ( .wr_en(inff.wr_en),
            .rd_en(inff.rd_en),
            .data_in(inff.data_in),
            .data_out(inff.data_out),
            .full(inff.full),
            .empty(inff.empty),
            .clk(inff.clk),
            .rst(inff.rst) ); 
  
  initial begin
    t1 = new(inff);
    inff.clk = 1'b0;
    t1.run();
  end
  
  always #10 inff.clk = ~inff.clk;
  
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0,testbench);
    end
  
endmodule
