# -*- coding: utf-8 -*-
"""
@author: Michael Dominguez
"""

import random

def compareModule():
    compare = f"""\
module compare(
    input [1:0] clk,
    input reset,
    input [3:0] count0,
    input [3:0] count1,
    output reg comp
    );

    always@(posedge clk, posedge reset) begin
        if(reset)
            comp <= 1'b0;
            
        else begin
            if(count0 > count1)
                comp <= 1'b1;
                
            else
                comp <= 1'b0;
        end
    end

endmodule
"""

    with open("compare.v", "w") as compare_file:
        compare_file.write(compare)

def cycCompareModule():
    compare = f"""\
module cyc_compare(
    input clk,
    input reset,
    input [3:0] count0,
    input [3:0] count1,
    output reg comp
    );

    always@(posedge clk, posedge reset) begin
        if(reset)
            comp <= 1'b0;
            
        else begin
            if(count0 > count1)
                comp <= 1'b1;
                
            else
                comp <= 1'b0;
        end
    end

endmodule
"""

    with open("cyc_compare.v", "w") as compare_file:
        compare_file.write(compare)

def countersModule():
    counters = f"""\
module counters(
    input clk0,
    input clk1,
    input reset,
    output reg [3:0] count0,
    output reg [3:0] count1
    );
    
    always@(posedge clk0, posedge reset) begin
        if(reset || (&count0))
			count0 <= 4'b0000;

		else
            count0 <= count0 + 1'b1;
    end

    always@(posedge clk1, posedge reset) begin
		if(reset || (&count1))
			count1 <= 4'b0000;	

		else
			count1 <= count1 + 1'b1;
    end

endmodule
"""

    with open("counters.v", "w") as counter_file:
        counter_file.write(counters)

def mux4_to_2Module():
    mux4_2 = f"""\
(* dont_touch = "yes" *)
module mux4_to_2(
    input x,
    input y,
    input sel,
    output out0,
    output out1
    );
    
    mux2_to_1 mux1 (.in0(x), .in1(y), .sel(sel), .mux(out1));
    
    mux2_to_1 mux0 (.in0(y), .in1(x), .sel(sel), .mux(out0));
    
endmodule
"""

    with open("mux4_to_2.v", "w") as mux4_2_file:
        mux4_2_file.write(mux4_2)

def mux2_to_1Module():
    mux2_1 = f"""\
(* dont_touch = "yes" *)
module mux2_to_1(
    input in0,
    input in1,
    input sel,
    output reg mux
    );
       
    always@(in0, in1, sel) begin
        if(sel)
             mux = in1;
            
        else 
             mux = in0;
    end
    
endmodule
"""

    with open("mux2_to_1.v", "w") as mux2_1_file:
        mux2_1_file.write(mux2_1)

def roModule():
    with open("ro.v", "w") as ro_file:
        for i in range(1, 5):
            ro = f"""\
(* dont_touch = "yes" *)
module ro{i}(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #{'%.3f'%(random.SystemRandom().uniform(0.001, 2.001))}(p, en, out);
    and  #{'%.3f'%(random.SystemRandom().uniform(0.001, 2.001))}(q, p, p);
    and  #{'%.3f'%(random.SystemRandom().uniform(0.001, 2.001))}(r, q, q);
    and  #{'%.3f'%(random.SystemRandom().uniform(0.001, 2.001))}(s, r, r);
    always @(posedge clk)
        #{'%.3f'%(random.SystemRandom().uniform(0.001, 2.001))} out <= s & s;

endmodule

"""
            ro_file.write(ro)

def ropufModule(size_of):
    ropuf = """\
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
"""

    with open("ropuf.v", "w") as ropuf_file:
        ropuf_file.write(ropuf)
    roModule()
    mux2_to_1Module()
    countersModule()
    compareModule()

def cycRopufModule(size_of):
    ropuf = """\
(* dont_touch = "yes" *)
module cycropuf(
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

    cyc_compare comp0(.clk(clk), .reset(reset), .count1(count1), .count0(count0), .comp(response[0]));
    cyc_compare comp1(.clk(clk), .reset(reset), .count1(count3), .count0(count2), .comp(response[1]));

endmodule
"""

    with open("cycropuf.v", "w") as ropuf_file:
        ropuf_file.write(ropuf)
    roModule()
    mux2_to_1Module()
    countersModule()
    cycCompareModule()

def multibitCycRopufTopModule(size_of, num_cyc):
    preamble = f"""\
(* dont_touch = "yes" *)
module multi_bit_cycropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output [size_of:0] resp
    );

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};

    reg [num_cyc:0] cycle;
    wire [size_of:0] out;
    
    always@ (posedge clk) begin
"""
    
    with open("multi_bit_cycropuf_top.v", "w") as cycropuf:
        cycropuf.write(preamble)
        
        for i in range(num_cyc + 1):
            cycropuf.write(f"       cycle[{i}] <= chal[{i}] ^ out[{num_cyc - i}];\n")
        cycropuf.write("    end\n")
        
        closure = """\
                
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
"""
        cycropuf.write(closure)
    cycRopufModule(size_of)

def twobitCycRopufTopModule(size_of, num_cyc):
    preamble = f"""\
(* dont_touch = "yes" *)
module two_bit_cycropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output resp
    );

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};

    reg [num_cyc:0] cycle;
    wire [size_of:0] out;
    
    always@ (posedge clk) begin
"""
    
    with open("two_bit_cycropuf_top.v", "w") as cycropuf:
        cycropuf.write(preamble)
        
        for i in range(num_cyc + 1):
            cycropuf.write(f"       cycle[{i}] <= chal[{i}] ^ out[{num_cyc - i}];\n")
        cycropuf.write("    end\n")
        
        closure = """\
                
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
"""
        cycropuf.write(closure)
    cycRopufModule(size_of)

def multibitRopufTopModule(size_of):
    multi_bit_ropuf_code = f"""\
(* dont_touch = "yes" *)
module multi_bit_ropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output [size_of:0] resp
    );

    localparam size_of = {size_of};

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
"""
    
    with open("multi_bit_ropuf_top.v", "w") as multi_bit_ropuf:
        multi_bit_ropuf.write(multi_bit_ropuf_code)
    ropufModule(size_of)

def twobitRopufTopModule(size_of):
    two_bit_ropuf_code = f"""\
(* dont_touch = "yes" *)
module one_bit_ropuf_top(
    input clk,
    input [size_of:0] chal,
    input enable,
    input reset,
    output resp
    );

    localparam size_of = {size_of};

    wire [size_of:0] out;
                    
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 2) begin : ropuf_inst
            ropuf PUF(.clk(clk), .chal(chal[size_of - i:size_of - (i + 1)]),
            .enable(enable), .reset(reset), .response(out[size_of - i:size_of - (i + 1)]));                    
        end
    endgenerate

    assign resp = (^out); 

endmodule
"""
    
    with open("two_bit_ropuf_top.v", "w") as two_bit_ropuf:
        two_bit_ropuf.write(two_bit_ropuf_code)
    ropufModule(size_of)

def dLatchModule():
    dLatch = """\
module D_Latch_Extended(
    input clk,
    input D,
    input RST,
    input SET,
    output reg Q
    );

    always@(posedge clk) begin
        if(RST)
            Q <= 1'b0;
        else if(SET)
            Q <= 1'b1;
        else
            Q <= D;

    end

endmodule
"""

    with open("dLatch.v", "w") as dLatch_file:
        dLatch_file.write(dLatch)

def bpufModule():
    bpuf = """\
(* dont_touch = "yes" *)
module BPUF(
    input clk,
    input excite,
    output Q
    );

    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    wire a, Q0, Q1;
    
    assign a = 1'b0;
    
    D_Latch_Extended DFF0 (.clk(clk), .D(Q1), .RST(a), .SET(excite), .Q(Q0));
    D_Latch_Extended DFF1 (.clk(clk), .D(Q0), .RST(excite), .SET(a), .Q(Q1));
    
    assign Q = Q0;

endmodule
"""

    with open("bpuf.v", "w") as bpuf_file:
        bpuf_file.write(bpuf)

def multibitCycBpufTopModule(size_of, num_cyc):
    preamble = f"""\
(* dont_touch = "yes" *)
module multi_bit_cycbpuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};
    
    reg [num_cyc:0] cycle;
    wire [size_of:0] Q;
            
    always@(posedge clk) begin
"""

    with open("multi_bit_cycbpuf_top.v", "w") as cycbpuf:
        cycbpuf.write(preamble)
        for i in range(num_cyc + 1):
            cycbpuf.write(f"       cycle[{i}] <= Chal[{i}] ^ Q[{num_cyc - i}];\n")
        cycbpuf.write("    end\n")
        closure = """\
    
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
"""
        cycbpuf.write(closure)
    bpufModule()
    dLatchModule()

def onebitCycBpufTopModule(size_of, num_cyc):

    preamble = f"""\
(* dont_touch = "yes" *)
module one_bit_cycbpuf_top(
    input clk,
    input [size_of:0] Chal,
    output resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};
    
    reg [num_cyc:0] cycle;
    wire [size_of:0] Q;
            
    always@(posedge clk) begin
"""
    with open("one_bit_cycbpuf_top.v", "w") as cycbpuf:
        cycbpuf.write(preamble)
        for i in range(num_cyc + 1):
            cycbpuf.write(f"       cycle[{i}] <= Chal[{i}] ^ Q[{num_cyc - i}];\n")
        cycbpuf.write("    end\n")
        closure = """\
    
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
"""
        cycbpuf.write(closure)
    bpufModule()
    dLatchModule()

def multibitBpufTopModule(size_of):

    preamble = f"""\
(* dont_touch = "yes" *)
module multi_bit_bpuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = {size_of};
    
    wire [size_of:0] Q;
            
"""

    with open("multi_bit_bpuf_top.v", "w") as bpuf:
        bpuf.write(preamble)
        closure = """\
    
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : bpuf_inst
            BPUF PUF(.clk(clk), .excite(Chal[i]), .Q(Q[i]));
        end
    endgenerate
    
    assign resp = Q;
    
endmodule
"""
        bpuf.write(closure)
    bpufModule()
    dLatchModule()

def onebitBpufTopModule(size_of):

    preamble = f"""\
(* dont_touch = "yes" *)
module one_bit_bpuf_top(
    input clk,
    input [size_of:0] Chal,
    output resp
    );
    
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *)

    localparam size_of = {size_of};
    
    wire [size_of:0] Q;
            
"""

    with open("one_bit_bpuf_top.v", "w") as bpuf:
        bpuf.write(preamble)
        closure = """\
    
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : bpuf_inst
            BPUF PUF(.clk(clk), .excite(Chal[i]), .Q(Q[i]));
        end
    endgenerate
    
    assign resp = (^Q);
    
endmodule
"""
        bpuf.write(closure)
    bpufModule()
    dLatchModule()

def dffModule():
    dff = f"""\
(* dont_touch = "yes" *)
module D_Flip_Flop(
    input clk,
    input D,
    output reg Q
    );

    always@(posedge clk)
        Q <= D;

endmodule
"""

    with open("D_Flip_Flop.v", "w") as dff_file:
        dff_file.write(dff)

def apufModule(size_of):
    apuf_code = f"""\
(* dont_touch = "yes" *)
module APUF(
    input X,
    input Y,
    input [size_of:0] Chal,
    output out_Q
    );

    localparam size_of = {size_of};

    wire [size_of:0] A;
    wire [size_of:0] B;

    mux4_to_2 switch (.x(X), .y(Y), .sel(Chal[0]), .out0(A[0]), .out1(B[0]));
    
    genvar i;
    generate
        for (i = 1; i < size_of + 1; i = i + 1)
        begin : loop
            mux4_to_2 switch (.x(A[i - 1]), .y(B[i - 1]), .sel(Chal[i]), .out0(A[i]), .out1(B[i]));
        end
    endgenerate
    
    D_Flip_Flop DFF (.D(A[size_of]), .clk(B[size_of]), .Q(out_Q));

endmodule
"""

    with open("apuf.v", "w") as apuf_file:
        apuf_file.write(apuf_code)

def multibitCycApufTopModule(size_of, num_cyc):
    preamble = f"""\
(* dont_touch = "yes" *)
module multi_bit_cycapuf_top(
    input clk,
    input [size_of:0] Chal,
    output [size_of:0] out_Q
    );

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};

    reg [num_cyc:0] Ch;
    reg [num_cyc:0] cycle;
    wire [size_of:0] PUF_out;

    always@(posedge clk) begin
       Ch <= Chal;
"""

    with open("multi_bit_cycapuf_top.v", "w") as cycapuf:
        cycapuf.write(preamble)
        for i in range(num_cyc + 1):
            cycapuf.write(f"       cycle[{i}] <= Ch[{i}] ^ PUF_out[{num_cyc - i}];\n")
        cycapuf.write("    end\n")
        
        closure = f"""\
                
    genvar i;
    generate
        for (i = 0; i < (size_of + 1); i = i + 1) begin : apuf_inst
            if (num_cyc == size_of)
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal(Chal), .out_Q(PUF_out[i]));   
            else
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal({{Chal[size_of:(num_cyc + 1)], cycle}}), .out_Q(PUF_out[i]));   
        end
    endgenerate

    assign out_Q = PUF_out;

endmodule
"""
        cycapuf.write(closure)
    
    apufModule(size_of)
    mux4_to_2Module()
    mux2_to_1Module()
    dffModule()

def onebitCycApufTopModule(size_of, num_cyc):
    preamble = f"""\
(* dont_touch = "yes" *)
module one_bit_cycapuf_top(
    input clk,
    input [size_of:0] Chal,
    output out_Q
    );

    localparam size_of = {size_of};
    localparam num_cyc = {num_cyc};

    reg [num_cyc:0] Ch;
    reg [num_cyc:0] cycle;
    wire [size_of:0] PUF_out;

    always@(posedge clk) begin
       Ch <= Chal;
"""

    with open("one_bit_cycapuf_top.v", "w") as cycapuf:
        cycapuf.write(preamble)
        for i in range(num_cyc + 1):
            cycapuf.write(f"       cycle[{i}] <= Ch[{i}] ^ PUF_out[{num_cyc - i}];\n")
        cycapuf.write("    end\n")
        
        closure = f"""\
                
    genvar i;
    generate
        for (i = 0; i < (size_of + 1); i = i + 1) begin : apuf_inst
            if (num_cyc == size_of)
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal(Chal), .out_Q(PUF_out[i]));   
            else
                APUF PUF (.X(cycle[i % (num_cyc + 1)]), .Y(Ch[0]), 
                .Chal({{Chal[size_of:(num_cyc + 1)], cycle}}), .out_Q(PUF_out[i]));   
        end
    endgenerate

    assign out_Q = (^PUF_out);

endmodule
"""
        cycapuf.write(closure)
        
    apufModule(size_of)
    mux4_to_2Module()
    mux2_to_1Module()
    dffModule()

def multibitApufTopModule(size_of):
    multi_bit_apuf_top = f"""\
(* dont_touch = "yes" *)
module multi_bit_apuf_top(
    input [size_of:0] Chal,
    output [size_of:0] out_Q
    );

    localparam size_of = {size_of};

    wire [size_of:0] PUF_out;
                
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : apuf_inst
            APUF PUF (.X(Chal[1]), .Y(Chal[0]), 
            .Chal(Chal[size_of:0]), .out_Q(PUF_out[i]));                     
        end
    endgenerate

    assign out_Q = PUF_out;

endmodule
"""

    with open("multi_bit_apuf_top.v", "w") as multi_bit_apuf:
        multi_bit_apuf.write(multi_bit_apuf_top)
    
    apufModule(size_of)
    mux4_to_2Module()
    mux2_to_1Module()
    dffModule()

def onebitApufTopModule(size_of):
    one_bit_apuf_top = f"""\
(* dont_touch = "yes" *)
module one_bit_apuf_top(
    input [size_of:0] Chal,
    output out_Q
    );

    localparam size_of = {size_of};

    wire [size_of:0] PUF_out;
                
    genvar i;
    generate
        for (i = 0; i < size_of + 1; i = i + 1) begin : apuf_inst
            APUF PUF (.X(Chal[1]), .Y(Chal[0]), 
            .Chal(Chal[size_of:0]), .out_Q(PUF_out[i]));                     
        end
    endgenerate

    assign out_Q = (^PUF_out);

endmodule
"""

    with open("one_bit_apuf_top.v", "w") as one_bit_apuf:
        one_bit_apuf.write(one_bit_apuf_top)
    
    apufModule(size_of)
    mux4_to_2Module()
    mux2_to_1Module()
    dffModule()