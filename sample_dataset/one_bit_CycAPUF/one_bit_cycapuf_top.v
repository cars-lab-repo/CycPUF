(* dont_touch = "yes" *)
module one_bit_cycapuf_top(
    input clk,
    input [size_of:0] Chal,
    output out_Q
    );

    localparam size_of = 36;
    localparam num_cyc = 24;

    reg [num_cyc:0] Ch;
    reg [num_cyc:0] cycle;
    wire [size_of:0] PUF_out;

    always@(posedge clk) begin
       Ch <= Chal;
       cycle[0] <= Ch[0] ^ PUF_out[24];
       cycle[1] <= Ch[1] ^ PUF_out[23];
       cycle[2] <= Ch[2] ^ PUF_out[22];
       cycle[3] <= Ch[3] ^ PUF_out[21];
       cycle[4] <= Ch[4] ^ PUF_out[20];
       cycle[5] <= Ch[5] ^ PUF_out[19];
       cycle[6] <= Ch[6] ^ PUF_out[18];
       cycle[7] <= Ch[7] ^ PUF_out[17];
       cycle[8] <= Ch[8] ^ PUF_out[16];
       cycle[9] <= Ch[9] ^ PUF_out[15];
       cycle[10] <= Ch[10] ^ PUF_out[14];
       cycle[11] <= Ch[11] ^ PUF_out[13];
       cycle[12] <= Ch[12] ^ PUF_out[12];
       cycle[13] <= Ch[13] ^ PUF_out[11];
       cycle[14] <= Ch[14] ^ PUF_out[10];
       cycle[15] <= Ch[15] ^ PUF_out[9];
       cycle[16] <= Ch[16] ^ PUF_out[8];
       cycle[17] <= Ch[17] ^ PUF_out[7];
       cycle[18] <= Ch[18] ^ PUF_out[6];
       cycle[19] <= Ch[19] ^ PUF_out[5];
       cycle[20] <= Ch[20] ^ PUF_out[4];
       cycle[21] <= Ch[21] ^ PUF_out[3];
       cycle[22] <= Ch[22] ^ PUF_out[2];
       cycle[23] <= Ch[23] ^ PUF_out[1];
       cycle[24] <= Ch[24] ^ PUF_out[0];
    end
                
    genvar i;
    generate
        for (i = 0; i < (size_of + 1); i = i + 1) begin : apuf_inst
            if (num_cyc == size_of)
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal(Chal), .out_Q(PUF_out[i]));   
            else
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal({Chal[size_of:(num_cyc + 1)], cycle}), .out_Q(PUF_out[i]));   
        end
    endgenerate

    assign out_Q = (^PUF_out);

endmodule
