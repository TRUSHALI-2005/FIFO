interface inf;
  logic wr_en;
  logic rd_en;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic full;
  logic empty;
  logic clk;
  logic rst;
  
//   clocking cb @(posedge clk);
//     default input #1 output #0;
//     input data_out, full, empty;
//     output wr_en,rd_en,data_in;
//   endclocking
  
  clocking cb_drv @(posedge clk);
    default input #1 output #0;
//     output data_out, full, empty;
    output wr_en,rd_en,data_in;
    input rst;
  endclocking
  
  
  clocking cb_mon @(posedge clk);
    default input #0 output #0;
    input wr_en,rd_en,data_in,data_out, full, empty;
  endclocking
  
  modport DRV(clocking cb_drv);
  modport MON (clocking cb_mon);
    
endinterface
