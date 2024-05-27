`timescale 1ns / 1ps

module hazard_detection(input [4:0] rd,
                        input [4:0] rs1,
                        input [4:0] rs2,
                        input MemRead,
                        output reg PCwrite,
                        output reg IF_IDwrite,
                        output reg control_sel);
                        
always@(*) begin
    if(MemRead && ((rd==rs1) || (rd==rs2))) begin
    // verifica operatia curenta este o citire din memorie MemRead
    //si verifica daca resgistrul destinatie al operatiei din memorie este acelasi 
    // cu oricare dintre registrele sursa
        PCwrite = 1'b0; // nu se actualizeaza program counter ul si se reseteaza
        IF_IDwrite = 1'b0; // nu se accepta o noua instructiune, ingheata starea pipeline-ului
        control_sel = 1'b1; // semnalul de control trebuie modificat sau anulat pt a gestionaq hazardul
    end
    else begin
        PCwrite = 1'b1; // preia o noua instructiune
        IF_IDwrite = 1'b1;
        control_sel = 1'b0;
    end
end

endmodule
