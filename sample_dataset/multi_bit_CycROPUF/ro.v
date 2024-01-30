(* dont_touch = "yes" *)
module ro1(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.301(p, en, out);
    and  #1.611(q, p, p);
    and  #0.073(r, q, q);
    and  #0.574(s, r, r);
    always @(posedge clk)
        #1.965 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro2(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.155(p, en, out);
    and  #0.571(q, p, p);
    and  #1.443(r, q, q);
    and  #0.221(s, r, r);
    always @(posedge clk)
        #0.604 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro3(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.182(p, en, out);
    and  #0.086(q, p, p);
    and  #1.087(r, q, q);
    and  #1.437(s, r, r);
    always @(posedge clk)
        #0.739 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro4(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.606(p, en, out);
    and  #1.205(q, p, p);
    and  #0.914(r, q, q);
    and  #0.842(s, r, r);
    always @(posedge clk)
        #0.794 out <= s & s;

endmodule

