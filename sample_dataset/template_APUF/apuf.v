(* dont_touch = "yes" *)
module APUF(
    input X,
    input Y,
    input [size_of:0] Chal,
    output out_Q
    );

    localparam size_of = 21;

    wire [size_of:0] A;
    wire [size_of:0] B;

    mux4_to_2 switch (.x(X), .y(Y), .sel(Chal[0]), .out0(A[0]), .out1(B[0]));
    
    genvar i;
    generate
        for (i = 1; i < size_of + 1; i = i + 1)
        begin : loop
            mux4_to_2 switch (.x(A[i - 1]), .y(B[i - 1]), .sel(Chal[i]), .out0(A[i]), .out1(B[i]));
        end
    endgenerate
    
    D_Flip_Flop DFF (.D(A[size_of]), .clk(B[size_of]), .Q(out_Q));

endmodule
