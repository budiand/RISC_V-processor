`timescale 1ns / 1ps

module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data);

reg [31:0] DataMemory [0:1023];
wire [31:0] address_small = address>>2;
// address_small este calculat prin deplasarea la dreapta cu 2 biti a adresei de intrare
             
integer i;
initial begin
    for (i = 0; i < 1024; i = i + 1) begin
        DataMemory[i] = 32'b0;// fiecare locatie din memorie initializata cu 0
    end
end
  
always@(posedge clk) begin
    if(mem_write)
        DataMemory[address_small[9:0]] <= write_data;
        // datele din write_data sunt scrise in locatia de memorie sepcificata de address
end

always@(*) begin
   if (mem_read==1'b1) begin 
    read_data = DataMemory[address_small[9:0]];
    //datele din locatia de memorie specificata de address sunt plasate  in read_data
    end else 
    read_data = read_data; // daca nu e activ ramane neschimbata 
    
end 

endmodule
