// Template Ring Oscillator PUF (ROPUF)
// Generated Verilog Code
(* dont_touch = "yes" *)
module template_ropuf(
    input clk,
    input [119:0] chal,
    input enable,
    input reset,
    input [1:0] user,
    output [119:0] resp
    );

    reg [79:0] cycle;
    wire [119:0] muxOut;
    // Cycle Logic
    always @(posedge clk) begin
        cycle[0] <= chal[0] ^ resp[79];
        cycle[1] <= chal[1] ^ resp[78];
        cycle[2] <= chal[2] ^ resp[77];
        cycle[3] <= chal[3] ^ resp[76];
        cycle[4] <= chal[4] ^ resp[75];
        cycle[5] <= chal[5] ^ resp[74];
        cycle[6] <= chal[6] ^ resp[73];
        cycle[7] <= chal[7] ^ resp[72];
        cycle[8] <= chal[8] ^ resp[71];
        cycle[9] <= chal[9] ^ resp[70];
        cycle[10] <= chal[10] ^ resp[69];
        cycle[11] <= chal[11] ^ resp[68];
        cycle[12] <= chal[12] ^ resp[67];
        cycle[13] <= chal[13] ^ resp[66];
        cycle[14] <= chal[14] ^ resp[65];
        cycle[15] <= chal[15] ^ resp[64];
        cycle[16] <= chal[16] ^ resp[63];
        cycle[17] <= chal[17] ^ resp[62];
        cycle[18] <= chal[18] ^ resp[61];
        cycle[19] <= chal[19] ^ resp[60];
        cycle[20] <= chal[20] ^ resp[59];
        cycle[21] <= chal[21] ^ resp[58];
        cycle[22] <= chal[22] ^ resp[57];
        cycle[23] <= chal[23] ^ resp[56];
        cycle[24] <= chal[24] ^ resp[55];
        cycle[25] <= chal[25] ^ resp[54];
        cycle[26] <= chal[26] ^ resp[53];
        cycle[27] <= chal[27] ^ resp[52];
        cycle[28] <= chal[28] ^ resp[51];
        cycle[29] <= chal[29] ^ resp[50];
        cycle[30] <= chal[30] ^ resp[49];
        cycle[31] <= chal[31] ^ resp[48];
        cycle[32] <= chal[32] ^ resp[47];
        cycle[33] <= chal[33] ^ resp[46];
        cycle[34] <= chal[34] ^ resp[45];
        cycle[35] <= chal[35] ^ resp[44];
        cycle[36] <= chal[36] ^ resp[43];
        cycle[37] <= chal[37] ^ resp[42];
        cycle[38] <= chal[38] ^ resp[41];
        cycle[39] <= chal[39] ^ resp[40];
        cycle[40] <= chal[40] ^ resp[39];
        cycle[41] <= chal[41] ^ resp[38];
        cycle[42] <= chal[42] ^ resp[37];
        cycle[43] <= chal[43] ^ resp[36];
        cycle[44] <= chal[44] ^ resp[35];
        cycle[45] <= chal[45] ^ resp[34];
        cycle[46] <= chal[46] ^ resp[33];
        cycle[47] <= chal[47] ^ resp[32];
        cycle[48] <= chal[48] ^ resp[31];
        cycle[49] <= chal[49] ^ resp[30];
        cycle[50] <= chal[50] ^ resp[29];
        cycle[51] <= chal[51] ^ resp[28];
        cycle[52] <= chal[52] ^ resp[27];
        cycle[53] <= chal[53] ^ resp[26];
        cycle[54] <= chal[54] ^ resp[25];
        cycle[55] <= chal[55] ^ resp[24];
        cycle[56] <= chal[56] ^ resp[23];
        cycle[57] <= chal[57] ^ resp[22];
        cycle[58] <= chal[58] ^ resp[21];
        cycle[59] <= chal[59] ^ resp[20];
        cycle[60] <= chal[60] ^ resp[19];
        cycle[61] <= chal[61] ^ resp[18];
        cycle[62] <= chal[62] ^ resp[17];
        cycle[63] <= chal[63] ^ resp[16];
        cycle[64] <= chal[64] ^ resp[15];
        cycle[65] <= chal[65] ^ resp[14];
        cycle[66] <= chal[66] ^ resp[13];
        cycle[67] <= chal[67] ^ resp[12];
        cycle[68] <= chal[68] ^ resp[11];
        cycle[69] <= chal[69] ^ resp[10];
        cycle[70] <= chal[70] ^ resp[9];
        cycle[71] <= chal[71] ^ resp[8];
        cycle[72] <= chal[72] ^ resp[7];
        cycle[73] <= chal[73] ^ resp[6];
        cycle[74] <= chal[74] ^ resp[5];
        cycle[75] <= chal[75] ^ resp[4];
        cycle[76] <= chal[76] ^ resp[3];
        cycle[77] <= chal[77] ^ resp[2];
        cycle[78] <= chal[78] ^ resp[1];
    end

    // Generate Cycles
    genvar i;
    generate
        for (i = 0; i < 120; i = i + 1) begin : cycle_inst
            wire xorOut, combOut, stateOut, oscOut;

            comb cyc0(.in0(resp[i]), .in1(chal[i]), .out(combOut));
            state cyc1(.in0(chal[i]), .in1(resp[i]), .out(stateOut));
            osc cyc2(.in0(chal[i]), .in1(resp[i]), .out(oscOut));
            assign xorOut = resp[i] ^ chal[i];
            mux4_to_1 cycMux(.in({xorOut, combOut, stateOut, oscOut}), .out(muxOut[i]), .sel(user));
        end
    endgenerate

    assign resp = cycle;

endmodule
