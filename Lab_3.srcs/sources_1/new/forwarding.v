`timescale 1ns / 1ps

module forwarding(input [4:0] rs1,
                  input [4:0] rs2,
                  input [4:0] ex_mem_rd,
                  input [4:0] mem_wb_rd,
                  input ex_mem_regwrite,
                  input mem_wb_regwrite,
                  output reg [1:0] forwardA,forwardB);
                  

always@(*) begin
// daca registrul destinatie este acelasi cu registrul sursa se produce un hazard EX
   if(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1)) //EX hazard rs1
      forwardA = 2'b10;
    else if(mem_wb_regwrite && (mem_wb_rd != 5'b0) && 
                          !(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs1)) && 
                          (mem_wb_rd == rs1)) //MEM hazard rs1
      forwardA = 2'b01;
    else
      forwardA = 2'b00; //no hazard  
    // cazul pentru registru sursa 2
    if(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2)) //EX hazard rs2
      forwardB = 2'b10;
   
    else if(mem_wb_regwrite && (mem_wb_rd != 5'b0) && 
                          !(ex_mem_regwrite && (ex_mem_rd != 5'b0) && (ex_mem_rd == rs2)) &&
                          (mem_wb_rd == rs2)) //MEM hazard rs1
      forwardB = 2'b01;
    else
      forwardB = 2'b00; //no hazard
      
    end
endmodule
