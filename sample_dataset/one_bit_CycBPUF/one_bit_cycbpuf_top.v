(* dont_touch = "yes" *)
module one_bit_cycbpuf_top(
    input clk,
    input [size_of:0] Chal,
    output resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = 50;
    localparam num_cyc = 24;
    
    reg [num_cyc:0] cycle;
    wire [size_of:0] Q;
            
    always@(posedge clk) begin
       cycle[0] <= Chal[0] ^ Q[24];
       cycle[1] <= Chal[1] ^ Q[23];
       cycle[2] <= Chal[2] ^ Q[22];
       cycle[3] <= Chal[3] ^ Q[21];
       cycle[4] <= Chal[4] ^ Q[20];
       cycle[5] <= Chal[5] ^ Q[19];
       cycle[6] <= Chal[6] ^ Q[18];
       cycle[7] <= Chal[7] ^ Q[17];
       cycle[8] <= Chal[8] ^ Q[16];
       cycle[9] <= Chal[9] ^ Q[15];
       cycle[10] <= Chal[10] ^ Q[14];
       cycle[11] <= Chal[11] ^ Q[13];
       cycle[12] <= Chal[12] ^ Q[12];
       cycle[13] <= Chal[13] ^ Q[11];
       cycle[14] <= Chal[14] ^ Q[10];
       cycle[15] <= Chal[15] ^ Q[9];
       cycle[16] <= Chal[16] ^ Q[8];
       cycle[17] <= Chal[17] ^ Q[7];
       cycle[18] <= Chal[18] ^ Q[6];
       cycle[19] <= Chal[19] ^ Q[5];
       cycle[20] <= Chal[20] ^ Q[4];
       cycle[21] <= Chal[21] ^ Q[3];
       cycle[22] <= Chal[22] ^ Q[2];
       cycle[23] <= Chal[23] ^ Q[1];
       cycle[24] <= Chal[24] ^ Q[0];
    end
    
    genvar i;
    generate
        if (num_cyc == size_of)
            for (i = 0; i < (size_of + 1); i = i + 1) begin : bpuf1_inst
                BPUF PUF(.clk(clk), .excite(cycle[i]), .Q(Q[i]));
            end
        
        else begin
            for (i = size_of; i > num_cyc; i = i - 1) begin : bpuf_inst
                BPUF PUF(.clk(clk), .excite(Chal[i]), .Q(Q[i]));
            end
        end
    endgenerate
    
    generate
        for (i = num_cyc; i > 0; i = i - 1) begin : cycbpuf_inst
            BPUF cycPUF(.clk(clk), .excite(cycle[i]), .Q(Q[i]));
        end
    endgenerate
    
    assign resp = (^Q);
    
endmodule
