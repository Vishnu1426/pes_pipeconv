# pes_pipeconv

Design

Testbench


iverilog dual_port_design.v dual_port_tb.v
./a.out
gtkwave dump.vcd

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/1cd39e48-6ae6-45b8-96f7-c261f9410e8d)

Pre-Synthesis Waveform
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/3bafac69-209b-4d20-9c83-66956fb84486)



read_liberty -lib sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog dual_port_design.v
synth -top pes_ram_design

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/9a5b331d-217a-4d67-8b04-14d25db91b01)

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/0252b86b-be27-4661-9400-6a219429a0bd)

abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/7c571612-0eda-483e-946d-8941aa8885b5)

show
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/08685658-49dc-4bed-bf21-f3fc8a6221c8)

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/ef59bdcb-a54f-456b-a84d-bbc4fdcf42e2)

The following shows that the library files have been used.

![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/91a2e1e6-0751-4e70-bfa8-055979667639)

The following shows netlist simulation
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/cb28a100-e43e-4658-8c20-1d887dd3906c)

The netlist simulation has some delay compared to the pre-synthesis simulation. However the final write results are the same.
![image](https://github.com/Vishnu1426/pes_ram_design/assets/79538653/a14f7c53-62e4-4106-a2b2-5caef2e9ff1c)
