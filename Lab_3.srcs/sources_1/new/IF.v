module IF(input clk, reset, 
          input PCSrc, PC_write,
          input [31:0] PC_Branch,
          output [31:0] PC_IF,INSTRUCTION_IF);

  wire [9:0] instruction_address = PC_IF[11:2];
  wire [31:0] PC_MUX;
  wire [31:0] PC_4_IF;
  
  PC PC_MODULE(clk,reset,PC_write,PC_MUX,PC_IF); 
  
  instruction_memory INSTRUCTION_MEMORY_MODULE(instruction_address,INSTRUCTION_IF);
  
  adder ADDER_PC_4_IF(PC_IF,32'b0100,PC_4_IF);  
  
  mux2_1 MUX_PC(PC_4_IF,            
                PC_Branch,          
                PCSrc,              
                PC_MUX); 


endmodule