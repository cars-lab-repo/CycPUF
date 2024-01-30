(* dont_touch = "yes" *)
module ropuf(
    input clk,
    input [1:0] chal,
    input enable,
    input reset,
    output [1:0] response
    );

    wire m0out, m1out, m2out, m3out;
    wire [1:0] din0, din1, din2, din3;
    wire [3:0] count0, count1, count2, count3;
    

    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro1 topRO(.en(enable), .clk(clk), .out(din0[0]));
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro2 topRO1(.en(enable), .clk(clk), .out(din0[1]));

    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro3 bottomRO(.en(enable), .clk(clk), .out(din1[0]));
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro4 bottomRO1(.en(enable), .clk(clk), .out(din1[1]));
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro1 topRO2(.en(enable), .clk(clk), .out(din2[0]));
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro3 topRO3(.en(enable), .clk(clk), .out(din2[1]));
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro2 bottomRO2(.en(enable), .clk(clk), .out(din3[0]));
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) ro4 bottomRO3(.en(enable), .clk(clk), .out(din3[1]));                       
            
    mux2_to_1 M0(.in0(din0[0]), .in1(din0[1]), .mux(m0out), .sel(chal[0]));
    mux2_to_1 M1(.in0(din1[0]), .in1(din1[1]), .mux(m1out), .sel(chal[1]));
    mux2_to_1 M2(.in0(din2[0]), .in1(din2[1]), .mux(m2out), .sel(chal[1]));
    mux2_to_1 M3(.in0(din3[0]), .in1(din3[1]), .mux(m3out), .sel(chal[0]));

    counters counter0(.clk1(m1out), .clk0(m0out), .reset(reset), .count0(count0), .count1(count1));
    counters counter1(.clk1(m3out), .clk0(m2out), .reset(reset), .count0(count2), .count1(count3));

    compare comp0(.clk(chal), .reset(reset), .count1(count1), .count0(count0), .comp(response[0]));
    compare comp1(.clk(chal), .reset(reset), .count1(count3), .count0(count2), .comp(response[1]));

endmodule
