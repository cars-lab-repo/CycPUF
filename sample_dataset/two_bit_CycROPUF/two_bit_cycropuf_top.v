(* dont_touch = "yes" *)
module two_bit_cycropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output resp
    );

    localparam size_of = 13;
    localparam num_cyc = 9;

    reg [num_cyc:0] cycle;
    wire [size_of:0] out;
    
    always@ (posedge clk) begin
       cycle[0] <= chal[0] ^ out[9];
       cycle[1] <= chal[1] ^ out[8];
       cycle[2] <= chal[2] ^ out[7];
       cycle[3] <= chal[3] ^ out[6];
       cycle[4] <= chal[4] ^ out[5];
       cycle[5] <= chal[5] ^ out[4];
       cycle[6] <= chal[6] ^ out[3];
       cycle[7] <= chal[7] ^ out[2];
       cycle[8] <= chal[8] ^ out[1];
       cycle[9] <= chal[9] ^ out[0];
    end
                
    genvar i;
    generate
        for (i = (num_cyc + 1); i < size_of; i = i + 2) begin : ropuf_inst
            cycropuf PUF(.clk(clk), .chal(chal[(i + 1):i]),
            .enable(enable), .reset(reset), .response(out[(i + 1):i]));
        end
    endgenerate

    generate
        for (i = 0; i < num_cyc; i = i + 2) begin : cycropuf_inst
            cycropuf cycPUF(.clk(clk), .chal(cycle[(i + 1):i]),
            .enable(enable), .reset(reset), .response(out[(i + 1):i]));
        end
    endgenerate

    assign resp = (^out); 

endmodule
