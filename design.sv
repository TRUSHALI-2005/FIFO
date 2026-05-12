//Using extra bit for the ptr
module syn_FIFO
  #(parameter DEPTH = 16,
    parameter DATA_WIDTH = 8)
  ( input wr_en,rd_en,
   input [DATA_WIDTH-1:0] data_in, 
   output reg [DATA_WIDTH-1:0] data_out,
   output full,empty,
   input clk,rst);
  
  reg [DATA_WIDTH-1:0] mem [DEPTH];
  reg [$clog2(DEPTH)-1:0] wr_ptr;
  reg [$clog2(DEPTH)-1:0] rd_ptr;
  reg [$clog2(DEPTH)-1:0] counter;
  
  integer i;
  
  always@(posedge clk)
    begin
      if(!rst)
        begin
          for( i=0 ; i < DEPTH ; i = i+1 )
              mem[i] <= 0;
          data_out <= 0;
          wr_ptr <= 1'b0;
          rd_ptr <= 1'b0;
          counter <= 1'b0;
        end
    end
  
  always@(posedge clk) begin
    if( !full & wr_en )
        begin
          wr_ptr <= wr_ptr+1;
          mem[wr_ptr] <= data_in;
          counter <= counter + 1;
        end
  end
  
  always @(posedge clk) begin
    if (!empty & rd_en)
      begin
        rd_ptr <= rd_ptr+1;
        data_out <= mem[rd_ptr];
        counter <= counter -1 ;
      end
  end
  
  assign full =  counter == DEPTH;
  assign empty = counter == 0;
  
endmodule