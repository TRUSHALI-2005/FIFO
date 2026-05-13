class Scoreboard;
  mailbox #(Transaction) mon2scb;
  Transaction trans;
  int num;
  
  bit [DATA_WIDTH-1:0] queue[$:DEPTH];
  bit [DATA_WIDTH-1:0] exp_data_out;
  bit exp_full, exp_empty;
  
  function new(mailbox #(Transaction) mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  function void reference();
    if (trans.wr_en && !exp_full)
    queue.push_back(trans.data_in);
    
    if (trans.rd_en && !exp_empty)
      exp_data_out = queue.pop_front();
    
    exp_full  = (queue.size() == DEPTH-1);
    exp_empty = (queue.size() == 0);
  endfunction
  
  task main();
    forever begin
    mon2scb.get(trans);
    
      reference();
      num++;
      $display(num);
    
      if (exp_full  == trans.full &&
          exp_empty == trans.empty &&
          (!trans.rd_en || exp_data_out == trans.data_out)) begin
        $display("[SCO] PASS %0t Queue=%p", $time, queue);
//         trans.display("[SCO]");
      end
      else begin
        $error("[SCO] FAIL %0t", $time);
        trans.display("[ACT]");
        $display("[REF] : %0t",$time);
        $display("\t WR : %b  |  RD: %0b",trans.wr_en,trans.rd_en);
        $display("\t DATA IN: %0h  |  OUT: %0h",trans.data_in,exp_data_out);
        $display("\t Full: %b  |  EMPTY : %b",exp_full,exp_empty);
        $display("\t Queue: %p",queue);
      end
    end
  endtask
 
endclass
