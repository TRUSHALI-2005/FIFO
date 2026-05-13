class Driver;

virtual inf vif;
Transaction trans;
mailbox #(Transaction) gen2drv;
event next;

function new(mailbox #(Transaction) gen2drv, virtual inf vif);
  this.gen2drv = gen2drv;
  this.vif = vif;
endfunction

task main();
forever begin
  gen2drv.get(trans);
  @(posedge vif.clk);  // clocking block sync
  if(vif.rst)
  begin
    vif.wr_en <= trans.wr_en;
    vif.rd_en <= trans.rd_en;
    vif.data_in <= trans.data_in;
  end
  else
  begin
    vif.wr_en   <= 0;
    vif.rd_en   <= 0;
    vif.data_in <= 0;
  end

//   trans.display("[DRIVER]");
  -> next;
end

endtask

endclass
