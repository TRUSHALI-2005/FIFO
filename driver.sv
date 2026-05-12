class Driver;

virtual inf.DRV vif;
Transaction trans;
mailbox #(Transaction) gen2drv;
event next;

function new(mailbox #(Transaction) gen2drv, virtual inf.DRV vif);
  this.gen2drv = gen2drv;
  this.vif = vif;
endfunction

task main();
forever begin
  gen2drv.get(trans);
  @(vif.cb_drv);  // clocking block sync
  if(vif.cb_drv.rst)
  begin
    vif.cb_drv.wr_en   <= trans.wr_en;
    vif.cb_drv.rd_en   <= trans.rd_en;
    vif.cb_drv.data_in <= trans.data_in;
  end
  else
  begin
    vif.cb_drv.wr_en   <= 0;
    vif.cb_drv.rd_en   <= 0;
    vif.cb_drv.data_in <= 0;
  end

//   trans.display("[DRIVER]");
  -> next;
end

endtask

endclass
