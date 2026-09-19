module tb;

  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  wire [3:0] t_result;

  alu U1 (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  // Waveform dump
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  initial begin

    // Addition: 3 + 2 = 5
    t_a = 4'd3;
    t_b = 4'd2;
    t_op = 1'b0;
    #5;

    // Change ONLY op: should become 3 - 2 = 1
    t_op = 1'b1;
    #5;

    // Change b: 3 - 1 = 2
    t_b = 4'd1;
    #5;

    // Change a: 7 - 1 = 6
    t_a = 4'd7;
    #5;

    // Addition again: 7 + 1 = 8
    t_op = 1'b0;
    #5;

    // More subtraction tests
    t_a = 4'd5;
    t_b = 4'd3;
    t_op = 1'b1;
    #5;

    t_a = 4'd2;
    t_b = 4'd5;
    t_op = 1'b1;
    #5;

    $finish;
  end

  initial
    $monitor($time,
             " a=%d b=%d op=%b | result=%d",
             t_a, t_b, t_op, t_result);

endmodule