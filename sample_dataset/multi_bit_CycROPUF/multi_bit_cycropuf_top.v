(* dont_touch = "yes" *)
module multi_bit_cycropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output [size_of:0] resp
    );

    localparam size_of = 5;
    localparam num_cyc = 5;

    reg [num_cyc:0] cycle;
    wire [size_of:0] out;
    
    always@ (posedge clk) begin
       cycle[0] <= chal[0] ^ out[5];
       cycle[1] <= chal[1] ^ out[4];
       cycle[2] <= chal[2] ^ out[3];
       cycle[3] <= chal[3] ^ out[2];
       cycle[4] <= chal[4] ^ out[1];
       cycle[5] <= chal[5] ^ out[0];
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

    assign resp = out; 

endmodule
