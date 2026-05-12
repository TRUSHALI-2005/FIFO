class Monitor;

virtual inf.MON vif;
mailbox #(Transaction) mon2scb;
Transaction trans;

function new(mailbox #(Transaction) mon2scb, virtual inf.MON vif);
  this.mon2scb = mon2scb;
  this.vif = vif;
endfunction

task main();
forever begin
  @(vif.cb_mon);  // clocking block sync
  trans = new();
//   trans.wr_en   = vif.cb.wr_en;
//   trans.rd_en   = vif.cb.rd_en;
//   trans.data_in = vif.cb.data_in;
  trans.wr_en   = vif.cb_mon.wr_en;
  trans.rd_en   = vif.cb_mon.rd_en;
  trans.data_in = vif.cb_mon.data_in;
  trans.data_out= vif.cb_mon.data_out;
  trans.full    = vif.cb_mon.full;
  trans.empty   = vif.cb_mon.empty;
  mon2scb.put(trans);
//   trans.display("[MON]");
end

endtask

endclass
