(* dont_touch = "yes" *)
module ro1(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.150(p, en, out);
    and  #1.987(q, p, p);
    and  #0.503(r, q, q);
    and  #1.863(s, r, r);
    always @(posedge clk)
        #0.756 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro2(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.155(p, en, out);
    and  #0.143(q, p, p);
    and  #0.454(r, q, q);
    and  #0.955(s, r, r);
    always @(posedge clk)
        #0.012 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro3(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.480(p, en, out);
    and  #1.208(q, p, p);
    and  #1.852(r, q, q);
    and  #0.550(s, r, r);
    always @(posedge clk)
        #1.480 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro4(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.432(p, en, out);
    and  #0.394(q, p, p);
    and  #0.753(r, q, q);
    and  #0.423(s, r, r);
    always @(posedge clk)
        #0.753 out <= s & s;

endmodule

