//base class Generator
class Generator;
  mailbox #(Transaction) gen2drv;
  event next, sco_next;
  bit [1:0] mode;
  int count; 

  function new(mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction : new

  extern task send(Transaction trans);
  extern task seq_wr_rd(int num);
  extern task mul_wr_rd(int num);
  extern task full();
  extern task empty();
  extern task run();
  extern task write();
  extern task read();

endclass : Generator

//-------------------RUN--------------------------
task Generator::run();
  int num;
  if($value$plusargs ("NUM=%0d",num))
    $display("Num is %d",num);
  if($value$plusargs ("MODE=%0d",mode))
    $display("Mode %d is selected",mode);
  case(mode)
    'd0: mul_wr_rd(num);
    'd1: seq_wr_rd(num);
    'd2: full();
    'd3: empty();
    default: $display("MODE NOT IN RANGE");
  endcase
endtask :  run

//---------------------SEND-----------------------
task Generator::send(Transaction trans);
  gen2drv.put(trans);
endtask : send

//------------------WRITE------------------------
task Generator::write();
  Transaction trans;
    trans = new();
    if(trans.randomize() with { wr_en == 1; rd_en == 0; })
      send(trans);
    else
      $error("RANDOMIZATION FAILED");
    //     trans.display("[GEN]");
endtask : write

//-------------------READ-----------------------
task Generator::read();
  Transaction trans;
    trans = new();
    if(trans.randomize() with { wr_en == 0; rd_en == 1; })
      send(trans);
    else
      $error("RANDOMIZATION FAILED");
    //     trans.display("[GEN]");
endtask : read

//---------------SEQ WR RD---------------------
task Generator::seq_wr_rd(int num);
  repeat(num)
  begin
    write();
    read();
    count++;
    @(next);
  end
endtask : seq_wr_rd

//---------------MUL WR RD---------------------
task Generator::mul_wr_rd(int num);
  repeat(num)
  begin
    write();
    count++;
    @(next);
  end
  repeat(num)
  begin
    read();
    count++;
    @(next);
  end
endtask : mul_wr_rd

//--------------FULL---------------------------
task Generator::full();
  repeat(DEPTH) 
  begin
    write();
    count++;
    @(next);
  end
endtask : full

//--------------EMPTY-------------------------
task Generator::empty();
  repeat(DEPTH) 
  begin
    read();
    count++;
    @(next);
  end
endtask : empty

