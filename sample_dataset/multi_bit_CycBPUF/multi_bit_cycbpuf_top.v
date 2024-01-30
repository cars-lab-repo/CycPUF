(* dont_touch = "yes" *)
module multi_bit_cycbpuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = 14;
    localparam num_cyc = 2;
    
    reg [num_cyc:0] cycle;
    wire [size_of:0] Q;
            
    always@(posedge clk) begin
       cycle[0] <= Chal[0] ^ Q[2];
       cycle[1] <= Chal[1] ^ Q[1];
       cycle[2] <= Chal[2] ^ Q[0];
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
    
    assign resp = Q;
    
endmodule
