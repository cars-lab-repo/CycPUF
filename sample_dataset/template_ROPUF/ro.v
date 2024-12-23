(* dont_touch = "yes" *)
module ro1(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.069(p, en, out);
    and  #1.039(q, p, p);
    and  #0.178(r, q, q);
    and  #0.637(s, r, r);
    always @(posedge clk)
        #1.106 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro2(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.458(p, en, out);
    and  #0.484(q, p, p);
    and  #0.584(r, q, q);
    and  #1.809(s, r, r);
    always @(posedge clk)
        #1.395 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro3(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.121(p, en, out);
    and  #0.682(q, p, p);
    and  #1.210(r, q, q);
    and  #1.455(s, r, r);
    always @(posedge clk)
        #1.008 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro4(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.458(p, en, out);
    and  #0.238(q, p, p);
    and  #0.945(r, q, q);
    and  #0.663(s, r, r);
    always @(posedge clk)
        #1.866 out <= s & s;

endmodule

