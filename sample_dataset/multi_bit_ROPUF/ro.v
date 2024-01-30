(* dont_touch = "yes" *)
module ro1(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.848(p, en, out);
    and  #1.929(q, p, p);
    and  #1.709(r, q, q);
    and  #1.592(s, r, r);
    always @(posedge clk)
        #1.833 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro2(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.639(p, en, out);
    and  #1.082(q, p, p);
    and  #1.466(r, q, q);
    and  #1.028(s, r, r);
    always @(posedge clk)
        #1.080 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro3(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #1.956(p, en, out);
    and  #0.539(q, p, p);
    and  #0.378(r, q, q);
    and  #1.879(s, r, r);
    always @(posedge clk)
        #0.159 out <= s & s;

endmodule

(* dont_touch = "yes" *)
module ro4(
    input en,
    input clk,
    output reg out
    );
	 
    (* S= "TRUE"*)(* ALLOW_COMBINATORIAL_LOOPS = "true", KEEP = "true" *) 
    wire p, q, r, s;
        
    nand #0.433(p, en, out);
    and  #1.489(q, p, p);
    and  #0.725(r, q, q);
    and  #0.842(s, r, r);
    always @(posedge clk)
        #1.126 out <= s & s;

endmodule

