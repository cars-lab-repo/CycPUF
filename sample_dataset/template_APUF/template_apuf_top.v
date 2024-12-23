// Template Arbiter PUF (APUF)
// Generated Verilog Code
(* dont_touch = "yes" *)
module template_apuf(
    input clk,
    input [21:0] chal,
    input enable,
    input reset,
    input [1:0] user,
    output [21:0] resp
    );

    reg [17:0] cycle;
    wire [21:0] muxOut;
    // Cycle Logic
    always @(posedge clk) begin
        cycle[0] <= chal[0] ^ resp[17];
        cycle[1] <= chal[1] ^ resp[16];
        cycle[2] <= chal[2] ^ resp[15];
        cycle[3] <= chal[3] ^ resp[14];
        cycle[4] <= chal[4] ^ resp[13];
        cycle[5] <= chal[5] ^ resp[12];
        cycle[6] <= chal[6] ^ resp[11];
        cycle[7] <= chal[7] ^ resp[10];
        cycle[8] <= chal[8] ^ resp[9];
        cycle[9] <= chal[9] ^ resp[8];
        cycle[10] <= chal[10] ^ resp[7];
        cycle[11] <= chal[11] ^ resp[6];
        cycle[12] <= chal[12] ^ resp[5];
        cycle[13] <= chal[13] ^ resp[4];
        cycle[14] <= chal[14] ^ resp[3];
        cycle[15] <= chal[15] ^ resp[2];
        cycle[16] <= chal[16] ^ resp[1];
    end

    // Generate Cycles
    genvar i;
    generate
        for (i = 0; i < 22; i = i + 1) begin : cycle_inst
            wire xorOut, combOut, stateOut, arbOut;

            comb cyc0(.in0(resp[i]), .in1(chal[i]), .out(combOut));
            state cyc1(.in0(chal[i]), .in1(resp[i]), .out(stateOut));
            arb cyc2(.in0(chal[i]), .in1(resp[i]), .out(arbOut));
            assign xorOut = resp[i] ^ chal[i];
            mux4_to_1 cycMux(.in({xorOut, combOut, stateOut, arbOut}), .out(muxOut[i]), .sel(user));
        end
    endgenerate

    assign resp = cycle;

endmodule
