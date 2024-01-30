module D_Latch_Extended(
    input clk,
    input D,
    input RST,
    input SET,
    output reg Q
    );

    always@(posedge clk) begin
        if(RST)
            Q <= 1'b0;
        else if(SET)
            Q <= 1'b1;
        else
            Q <= D;

    end

endmodule
