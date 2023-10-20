# PES_DUAL_PORT_DESIGN

+ Design Module
```
// Dual Port RAM module design

module pes_ram_design(
  input [7:0] data_a, data_b, //input data
  input [5:0] addr_a, addr_b, //Port A and Port B address
  input we_a, we_b, //write enable for Port A and Port B
  input clk, //clk
  output reg [7:0] q_a, q_b //output data at Port A and Port B
);
  
  reg [7:0] ram [63:0]; //8*64 bit ram

 
  always @ (posedge clk)
    begin
      if(we_a)
        ram[addr_a] <= data_a;
      else
        q_a <= ram[addr_a]; 
    end
  
  always @ (posedge clk)
    begin
      if(we_b)
        ram[addr_b] <= data_b;
      else
        q_b <= ram[addr_b]; 
    end
  
endmodule
```

+ Testbench 
```
// Dual Port RAM testbench

module dual_port_ram_tb;
  reg [7:0] data_a, data_b; //input data
  reg [5:0] addr_a, addr_b; //Port A and Port B address
  reg we_a, we_b; //write enable for Port A and Port B
  reg clk; //clk
  wire [7:0] q_a, q_b; //output data at Port A and Port B
  
  pes_ram_design dpr1(
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
  );
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1, dual_port_ram_tb);       
      
      clk=1'b1;
      forever #5 clk = ~clk;
    end
  
  initial
    begin
      data_a = 8'h33;
      addr_a = 6'h01;
      
      data_b = 8'h44;
      addr_b = 6'h02;
      
      we_a = 1'b1;
      we_b = 1'b1;
      
      #10;
      
      data_a = 8'h55;
      addr_a = 6'h03;
      
      addr_b = 6'h01;
      
      we_b = 1'b0;
      
      #10;          
            
      addr_a = 6'h02;
      
      addr_b = 6'h03;
      
      we_a = 1'b0;
      
      #10;
      
      addr_a = 6'h01;
      
      data_b = 8'h77;
      addr_b = 6'h02;
      
      we_b = 1'b1;
      
      #10;
    end
  
  initial	
    #40 $stop;
  
endmodule
```

## RTL Simulation
+ To simulate the HDL code before synthesis enter the following command
```
iverilog dual_port_design.v dual_port_tb.v
```
+ To generate the .vcd file type the following command
```
./a.out
```
+ To view the simulation waveform type the following command
```
gtkwave dump.vcd
```

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/1cd39e48-6ae6-45b8-96f7-c261f9410e8d)

+ Pre-Synthesis Waveform looks like this
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/3bafac69-209b-4d20-9c83-66956fb84486)


## Synthesis
+ Open yosys and read the .lib file. Then read the verilog file and synthesize the top module.
```
read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog dual_port_design.v
synth -top pes_ram_design
```

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/9a5b331d-217a-4d67-8b04-14d25db91b01)

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/0252b86b-be27-4661-9400-6a219429a0bd)

+ Perform the abc step by typing the following command
```
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
```
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/7c571612-0eda-483e-946d-8941aa8885b5)

+ To view the synthesized design type the following command
```
show
```

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/08685658-49dc-4bed-bf21-f3fc8a6221c8)

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/ef59bdcb-a54f-456b-a84d-bbc4fdcf42e2)

+ The following shows that the library files have been used.

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/91a2e1e6-0751-4e70-bfa8-055979667639)

## GLS
+ The following shows netlist simulation
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/cb28a100-e43e-4658-8c20-1d887dd3906c)

The netlist simulation has some delay compared to the pre-synthesis simulation. However the final write results are the same.
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/a14f7c53-62e4-4106-a2b2-5caef2e9ff1c)
