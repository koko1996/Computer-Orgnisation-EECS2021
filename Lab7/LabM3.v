module labM; 
reg [4:0]  rn1, rn2, wn; 
reg [31:0]  wd; 
reg clk, w, enable, flag, prv; 
wire [31:0] rd1, rd2; 
integer i;
rf myRF(rd1, rd2, rn1, rn2, wn, wd, clk, w);

initial 
begin
flag = $value$plusargs("w=%b", w); 
for (i = 0; i < 32; i = i + 1) 
begin 
   clk = 0; 
   wd = i * i; 
   wn = i; 
   clk = 1; 
   #1;   
end 
  repeat(10)
  begin
	rn1=$random;
	rn2=$random;
     #1 $display("%5d: rd1=%d rd2=%d rn1=%d rn2=%d wn=%d wd=%d clk=%d w=%d", $time,rd1,rd2,rn1,rn2,wn,wd,clk,w); 
   end 
   rn1=31;
	rn2=31;
     #1 $display("%5d: rd1=%d rd2=%d rn1=%d rn2=%d wn=%d wd=%d clk=%d w=%d", $time,rd1,rd2,rn1,rn2,wn,wd,clk,w); 


end 
endmodule
