module tb_convolution;

  // Define parameters
  localparam N = 21; // Number of samples
  localparam CLK_PERIOD = 10; // Clock period in time units

  // Signals
  reg clk;
  reg rst;
  reg [20:0] signal_a[20:0];
  reg [20:0] signal_b[20:0];
  wire [41:0] result[41:0];

  // Instantiate the convolution module
  convolution uut (
    .clk(clk),
    .rst(rst),
    .signal_a(signal_a),
    .signal_b(signal_b),
    .result(result)
  );

  // Clock generation
  always begin
    #CLK_PERIOD / 2 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Stimulus generation
  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    for (i = 0; i < N; i = i + 1) begin
      signal_a[i] = $random;
      signal_b[i] = $random;
    end

    // Apply reset and wait for some time
    rst = 1;
    #100;
    rst = 0;

    // Wait for convolution to complete (adjust delay as needed)
    #1000;

    // Verify the convolution result
    $display("Convolution Result:");
    for (i = 0; i < 42; i = i + 1) begin
      $display("result[%d] = %d", i, result[i]);
    end

    // Terminate simulation
    $finish;
  end

endmodule