// Template Butterfly PUF (BPUF)
// Generated Verilog Code
(* dont_touch = "yes" *)
module template_bpuf(
    input clk,
    input [18:0] chal,
    input enable,
    input reset,
    input [1:0] user,
    output [18:0] resp
    );

    reg [10:0] cycle;
    wire [18:0] muxOut;
    // Cycle Logic
    always @(posedge clk) begin
        cycle[0] <= chal[0] ^ resp[10];
        cycle[1] <= chal[1] ^ resp[9];
        cycle[2] <= chal[2] ^ resp[8];
        cycle[3] <= chal[3] ^ resp[7];
        cycle[4] <= chal[4] ^ resp[6];
        cycle[5] <= chal[5] ^ resp[5];
        cycle[6] <= chal[6] ^ resp[4];
        cycle[7] <= chal[7] ^ resp[3];
        cycle[8] <= chal[8] ^ resp[2];
        cycle[9] <= chal[9] ^ resp[1];
    end

    // Generate Cycles
    genvar i;
    generate
        for (i = 0; i < 19; i = i + 1) begin : cycle_inst
            wire xorOut, combOut, stateOut, bpufOut;

            comb cyc0(.in0(resp[i]), .in1(chal[i]), .out(combOut));
            state cyc1(.in0(chal[i]), .in1(resp[i]), .out(stateOut));
            bpuf cyc2(.in0(chal[i]), .in1(resp[i]), .out(bpufOut));
            assign xorOut = resp[i] ^ chal[i];
            mux4_to_1 cycMux(.in({xorOut, combOut, stateOut, bpufOut}), .out(muxOut[i]), .sel(user));
        end
    endgenerate

    assign resp = cycle;

endmodule
