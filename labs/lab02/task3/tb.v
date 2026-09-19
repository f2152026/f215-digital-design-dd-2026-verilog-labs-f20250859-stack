module tb;

  reg [1:0] t_A;
  reg [1:0] t_B;

  wire t_GT;
  wire t_LT;
  wire t_EQ;

  // Instantiate comparator
  comp2 U1 (
    .A(t_A),
    .B(t_B),
    .GT(t_GT),
    .LT(t_LT),
    .EQ(t_EQ)
  );

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  integer i;
  integer j;

  // Self-checking test
  initial begin

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin

        t_A = i;
        t_B = j;

        #1;

        if (t_GT !== (t_A > t_B) ||
            t_LT !== (t_A < t_B) ||
            t_EQ !== (t_A == t_B)) begin

          $display("FAIL: A=%b B=%b | GT=%b LT=%b EQ=%b",
                   t_A, t_B, t_GT, t_LT, t_EQ);

        end
        else begin

          $display("PASS: A=%b B=%b | GT=%b LT=%b EQ=%b",
                   t_A, t_B, t_GT, t_LT, t_EQ);

        end

      end
    end

    $finish;
  end

endmodule