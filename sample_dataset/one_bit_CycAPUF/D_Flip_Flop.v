(* dont_touch = "yes" *)
module D_Flip_Flop(
    input clk,
    input D,
    output reg Q
    );

    always@(posedge clk)
        Q <= D;

endmodule
