module ff(Q, Qd, J, K, clk, reset);
  input J, K, clk, reset;
  output Q, Qd;
  reg Q;
  assign Qd = ~Q;
  always@(posedge clk)
  begin
    case({J,K})
      2'b00: Q=(reset==1'b1)?1'b0:Q;
      2'b01: Q=(reset==1'b1)?1'b0:1'b0;
      2'b10: Q=(reset==1'b1)?1'b0:1'b1;
      2'b11: Q =(reset==1'b1)?1'b0:Qd;
    endcase
  end
endmodule


module counter(in, s1, s0, reset);
  input in, reset;
  output s1, s0;
  wire qa, qb, qc;
  wire qda, qdb, qdc;
  reg clk;
  initial clk = 1'b0;
  always begin
   #25 clk = ~clk;
  end
  not(notin, in);
  
  
  
  assign qda = ~qa;
 
  assign qdb = ~qb;
 
  assign qdc = ~qc;
 

  ff a(.Q(qa), .Qd(qda), .J(andg43), .K(1'b0), .clk(clk), .reset(reset));
  ff b(.Q(qb), .Qd(qdb), .J(andg23), .K(org13), .clk(clk), .reset(reset));
  ff c(.Q(qc), .Qd(qdc), .J(andg63), .K(org23), .clk(clk), .reset(reset));
  or org2(org23, notin, qa);
  and andg6(andg63, qda, notin);
  and andg1(andg13, qda, qc);
  and andg2(andg23, andg13, notin);
  and andg3(andg33, qb, qc);
  and andg4(andg43, andg33, notin);
  and andg5(andg53, notin, qc);
  or org1(org13, andg53, qa);
  assign s1 = qb;
  assign s0 = qc;  
  not(notin, in);
  
endmodule

module test(in, s1, s0);
  input in;
  output s1, s0;
  reg reset;
  initial reset = 1'b1;
  
  counter cc(.in(in), .s1(s1), .s0(s0), .reseti(reset));
  
  
endmodule  