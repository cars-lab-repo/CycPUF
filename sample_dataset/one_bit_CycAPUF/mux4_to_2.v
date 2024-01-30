(* dont_touch = "yes" *)
module mux4_to_2(
    input x,
    input y,
    input sel,
    output out0,
    output out1
    );
    
    mux2_to_1 mux1 (.in0(x), .in1(y), .sel(sel), .mux(out1));
    
    mux2_to_1 mux0 (.in0(y), .in1(x), .sel(sel), .mux(out0));
    
endmodule
