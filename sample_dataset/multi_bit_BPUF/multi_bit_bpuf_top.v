(* dont_touch = "yes" *)
module multi_bit_bpuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = 32;
    
    wire [size_of:0] Q;
            
    
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : bpuf_inst
            BPUF PUF(.clk(clk), .excite(Chal[i]), .Q(Q[i]));
        end
    endgenerate
    
    assign resp = Q;
    
endmodule
