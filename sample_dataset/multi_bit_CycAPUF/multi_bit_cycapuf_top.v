(* dont_touch = "yes" *)
module multi_bit_cycapuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] out_Q
    );

    localparam size_of = 44;
    localparam num_cyc = 43;

    reg [num_cyc:0] Ch;
    reg [num_cyc:0] cycle;
    wire [size_of:0] PUF_out;

    always@(posedge clk) begin
       Ch <= Chal;
       cycle[0] <= Ch[0] ^ PUF_out[43];
       cycle[1] <= Ch[1] ^ PUF_out[42];
       cycle[2] <= Ch[2] ^ PUF_out[41];
       cycle[3] <= Ch[3] ^ PUF_out[40];
       cycle[4] <= Ch[4] ^ PUF_out[39];
       cycle[5] <= Ch[5] ^ PUF_out[38];
       cycle[6] <= Ch[6] ^ PUF_out[37];
       cycle[7] <= Ch[7] ^ PUF_out[36];
       cycle[8] <= Ch[8] ^ PUF_out[35];
       cycle[9] <= Ch[9] ^ PUF_out[34];
       cycle[10] <= Ch[10] ^ PUF_out[33];
       cycle[11] <= Ch[11] ^ PUF_out[32];
       cycle[12] <= Ch[12] ^ PUF_out[31];
       cycle[13] <= Ch[13] ^ PUF_out[30];
       cycle[14] <= Ch[14] ^ PUF_out[29];
       cycle[15] <= Ch[15] ^ PUF_out[28];
       cycle[16] <= Ch[16] ^ PUF_out[27];
       cycle[17] <= Ch[17] ^ PUF_out[26];
       cycle[18] <= Ch[18] ^ PUF_out[25];
       cycle[19] <= Ch[19] ^ PUF_out[24];
       cycle[20] <= Ch[20] ^ PUF_out[23];
       cycle[21] <= Ch[21] ^ PUF_out[22];
       cycle[22] <= Ch[22] ^ PUF_out[21];
       cycle[23] <= Ch[23] ^ PUF_out[20];
       cycle[24] <= Ch[24] ^ PUF_out[19];
       cycle[25] <= Ch[25] ^ PUF_out[18];
       cycle[26] <= Ch[26] ^ PUF_out[17];
       cycle[27] <= Ch[27] ^ PUF_out[16];
       cycle[28] <= Ch[28] ^ PUF_out[15];
       cycle[29] <= Ch[29] ^ PUF_out[14];
       cycle[30] <= Ch[30] ^ PUF_out[13];
       cycle[31] <= Ch[31] ^ PUF_out[12];
       cycle[32] <= Ch[32] ^ PUF_out[11];
       cycle[33] <= Ch[33] ^ PUF_out[10];
       cycle[34] <= Ch[34] ^ PUF_out[9];
       cycle[35] <= Ch[35] ^ PUF_out[8];
       cycle[36] <= Ch[36] ^ PUF_out[7];
       cycle[37] <= Ch[37] ^ PUF_out[6];
       cycle[38] <= Ch[38] ^ PUF_out[5];
       cycle[39] <= Ch[39] ^ PUF_out[4];
       cycle[40] <= Ch[40] ^ PUF_out[3];
       cycle[41] <= Ch[41] ^ PUF_out[2];
       cycle[42] <= Ch[42] ^ PUF_out[1];
       cycle[43] <= Ch[43] ^ PUF_out[0];
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

    assign out_Q = PUF_out;

endmodule
