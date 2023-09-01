module convolution (
  input wire clk,              // Clock signal
  input wire rst,              // Reset signal
  input wire [20:0] signal_a[20:0], // Input signal A (21-bit, 21 samples)
  input wire [20:0] signal_b[20:0], // Input signal B (21-bit, 21 samples)
  output wire [41:0] result[41:0]   // Convolution result (42-bit, 42 samples)
);

  // Define parameters
  localparam N = 21; // Number of samples

  // Internal registers for pipeline stages
  reg [20:0] a_reg[4:0];
  reg [20:0] b_reg[4:0];
  reg [41:0] partial_sums[4:0];

  // Register for maintaining state
  reg [4:0] state;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= 5'b0;
    end else begin
      // Implement a state machine for pipeline stages
      if (state < 5'b4) begin
        state <= state + 1;
      end else begin
        state <= 5'b0;
      end
    end
  end

  // Convolution operation with zero-padding
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      // Reset pipeline registers and partial sums
      for (i = 0; i < 5; i = i + 1) begin
        a_reg[i] <= 21'b0;
        b_reg[i] <= 21'b0;
        partial_sums[i] <= 42'b0;
      end
    end else begin
      // Load input samples into pipeline registers
      if (state < N) begin
        a_reg[state] <= signal_a[state];
        b_reg[state] <= signal_b[state];
      end

      // Calculate partial sums in parallel with boundary checks
      for (i = 0; i < 5; i = i + 1) begin
        for (j = 0; j < 5; j = j + 1) begin
          if (state >= i && state - i < N && state >= j && state - j < N) begin
            partial_sums[state] <= partial_sums[state] + (a_reg[i] * b_reg[j]);
          end
        end
      end
    end
  end

  // Output result
  always @(*) begin
    for (k = 0; k < 42; k = k + 1) begin
      result[k] = partial_sums[state];
    end
  end

endmodule