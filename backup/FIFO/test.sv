class test;

  Environment env;
  virtual inf vif;
  int count;
  
  function new(virtual inf vif);
    this.vif = vif;
    env = new(vif);
  endfunction
  
  task run();
    reset();
    env.run();
    wait(env.gen.count == env.sco.num);
    reset();
    $finish;
  endtask

  task reset();
    $display("RESET CALLED %0t",$time);
    vif.rst = 1'b0;
    @(posedge vif.clk);
    @(posedge vif.clk);
    vif.rst = 1'b1;
    $display("RESET END %0t",$time);
  endtask

endclass
