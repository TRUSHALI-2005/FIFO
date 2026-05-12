class Generator;

  mailbox #(Transaction) gen2drv;
  event next;
  bit [1:0] mode;

  function new(mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task send(Transaction t);
    gen2drv.put(t);
  endtask

  task seq_wr_rd(int num = 1);
    Transaction t;

    repeat(num) begin
      // WRITE
      t = new();
      if(t.randomize() with { wr_en == 1; rd_en == 0; })
        send(t);
      else
        $error("RANDOMIZATION FAILED");
      //     t.display("[GEN]");
      @(next);

      // READ
      t = new();
      if(t.randomize() with { wr_en == 0; rd_en == 1; })
        send(t);
      else
        $error("RANDOMIZATION FAILED");
      //     t.display("[GEN]");

      @(next);
    end

  endtask

  task mul_wr_rd(int num = 1);
    Transaction t;
    repeat(num) begin
      t = new();
      if(t.randomize() with { wr_en == 1; rd_en == 0; })
        send(t);
      else
        $error("RANDOMIZATION FAILED");
      //     t.display("[GEN]");
      @(next);
    end

    repeat(num) begin
      t = new();
      if(t.randomize() with { wr_en == 0; rd_en == 1; })
        send(t);
      else
        $error("RANDOMIZATION FAILED");
      //     t.display("[GEN]");
      @(next);
    end
  endtask

  task run(int num = 1);
    case(mode)
      2'b01: mul_wr_rd(num);
      2'b10: seq_wr_rd(num);
      default: begin
        mul_wr_rd(num);
        seq_wr_rd(num);
      end
    endcase
  endtask

endclass
