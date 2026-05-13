class Environment;

  Generator gen;
  Driver dri;
  Monitor mon;
  Scoreboard sco;
  
  mailbox #(Transaction) gen2drv;
  mailbox #(Transaction) mon2scb;
  
  event next;
  
  function new(virtual inf vif);
    gen2drv = new();
    mon2scb = new();
    
    gen = new(gen2drv);
    dri = new(gen2drv, vif);
    mon = new(mon2scb, vif);
    sco = new(mon2scb);
    
    gen.next = next;
    dri.next = next;
  endfunction
  
  task run();
    fork
      gen.run();
      dri.main();
      mon.main();
      sco.main();
    join_any
  endtask
  
endclass
