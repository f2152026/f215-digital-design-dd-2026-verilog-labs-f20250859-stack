// tb.v
// Testbench for the LUT

module tb;

  // Inputs and outputs
  reg  [1:0] t_sel;
  wire [7:0] t_dout;

  // Instantiate DUT
  lut U1 (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, U1);
    end
  end

  initial begin
    // Apply all 4 possible values of sel
    t_sel = 2'b00;
    #5;

    t_sel = 2'b01;
    #5;

    t_sel = 2'b10;
    #5;

    t_sel = 2'b11;
    #5;

    $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%d", t_sel, t_dout);

endmodule