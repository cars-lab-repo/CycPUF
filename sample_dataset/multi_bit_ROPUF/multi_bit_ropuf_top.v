(* dont_touch = "yes" *)
module multi_bit_ropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output [size_of:0] resp
    );

    localparam size_of = 21;

    wire [size_of:0] out;
                    
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 2) begin : ropuf_inst
            ropuf PUF(.clk(clk), .chal(chal[size_of - i:size_of - (i + 1)]),
            .enable(enable), .reset(reset), .response(out[size_of - i:size_of - (i + 1)]));                    
        end
    endgenerate

    assign resp = out; 

endmodule
