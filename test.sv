class test;

  Environment env;
  virtual inf vif;
  int count;
  
  function new(virtual inf vif);
    this.vif = vif;
    env = new(vif);
  endfunction
  
  task run();
    env.gen.mode = 1;
    count = 5;
    if($value$plusargs ("NUM=%d",count))
      env.run(4);
    else
      env.run(count);
    wait(count == env.sco.num);
    $finish;
  endtask

endclass
