(* dont_touch = "yes" *)
module multi_bit_apuf_top(
    input [size_of:0] Chal,
    output [size_of:0] out_Q
    );

    localparam size_of = 120;

    wire [size_of:0] PUF_out;
                
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : apuf_inst
            APUF PUF (.X(Chal[1]), .Y(Chal[0]), 
            .Chal(Chal[size_of:0]), .out_Q(PUF_out[i]));                     
        end
    endgenerate

    assign out_Q = PUF_out;

endmodule
