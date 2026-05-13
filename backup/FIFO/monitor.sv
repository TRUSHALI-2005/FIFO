class Monitor;
  
  Transaction trans;
  virtual inf vif;
  mailbox #(Transaction) mon2scb;
  
  function new(mailbox #(Transaction) mon2scb, virtual inf vif);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction : new
  
  task main();
    trans = new();
    forever 
      begin
//         @(posedge vif.clk);
//         
        @(posedge vif.clk);
        @(vif.wr_en or vif.rd_en or vif.data_in or vif.data_out or vif.full or vif.empty);
        trans.wr_en = vif.wr_en;
        trans.rd_en = vif.rd_en;
        trans.data_in = vif.data_in;
        trans.data_out = vif.data_out;
        trans.full = vif.full;
        trans.empty = vif.empty;
        mon2scb.put(trans);
//         trans.display("[MON]");
      end
  endtask : main
  
endclass : Monitor