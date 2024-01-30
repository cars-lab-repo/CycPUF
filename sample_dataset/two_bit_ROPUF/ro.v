(* dont_touch = "yes" *)
module ro1(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.682(p, en, out);
    and  #0.175(q, p, p);
    and  #0.782(r, q, q);
    and  #0.701(s, r, r);
    always @(posedge clk)
        #0.186 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro2(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.940(p, en, out);
    and  #0.332(q, p, p);
    and  #1.705(r, q, q);
    and  #0.303(s, r, r);
    always @(posedge clk)
        #1.821 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro3(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.701(p, en, out);
    and  #1.864(q, p, p);
    and  #1.098(r, q, q);
    and  #0.805(s, r, r);
    always @(posedge clk)
        #0.492 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro4(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.873(p, en, out);
    and  #0.458(q, p, p);
    and  #0.357(r, q, q);
    and  #0.178(s, r, r);
    always @(posedge clk)
        #1.480 out <= s & s;

endmodule

