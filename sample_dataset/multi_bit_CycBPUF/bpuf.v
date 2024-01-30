(* dont_touch = "yes" *)
module BPUF(
    input clk,
    input excite,
    output Q
    );

    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    wire a, Q0, Q1;
    
    assign a = 1'b0;
    
    D_Latch_Extended DFF0 (.clk(clk), .D(Q1), .RST(excite), .SET(a), .Q(Q0));
    D_Latch_Extended DFF1 (.clk(clk), .D(Q0), .RST(a), .SET(excite), .Q(Q1));
    
    assign Q = Q0;

endmodule
