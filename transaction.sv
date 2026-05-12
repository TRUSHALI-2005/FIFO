class Transaction;
  
  bit rst;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [`DATA_WIDTH-1:0] data_in;
  bit [`DATA_WIDTH-1:0] data_out;
  bit full;
  bit empty;
  
  function void display(string str);
    $display("-------------------------------");
    $display("%s | %0t",str,$time);
    $display("\t WR : %b  |  RD: %0b",wr_en,rd_en);
    $display("\t DATA IN: %0h  |  OUT: %0h",data_in,data_out);
    $display("\t Full: %b  |  EMPTY : %b",full,empty);
  endfunction : display
  
endclass : Transaction