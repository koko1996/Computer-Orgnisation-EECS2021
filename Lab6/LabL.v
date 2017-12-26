module yMux4to1(z, a0,a1,a2,a3, c); 
parameter SIZE = 2; 
output [SIZE-1:0] z; 
input [SIZE-1:0] a0, a1, a2, a3; 
input [1:0] c; 
wire [SIZE-1:0] zLo, zHi; 

yMux #(SIZE) lo(zLo, a0, a1, c[0]); 
yMux #(SIZE) hi(zHi, a2, a3, c[0]); 
yMux #(SIZE) final(z, zLo, zHi, c[1]); 

endmodule 


/////////////////////////////////////////////////////

module yMux1(z, a, b, c); 
output z; 
input a, b, c; 
wire notC, upper, lower; 

not my_not(notC, c); 
and upperAnd(upper, a, notC); 
and lowerAnd(lower, c, b); 
or my_or(z, upper, lower); 

endmodule 



///////////////////////////////////////////////////////

module yMux(z, a, b, c); 
parameter SIZE = 2; 
output [SIZE-1:0] z; 
input [SIZE-1:0] a, b; 
input c; 
yMux1 mine[SIZE-1:0](z, a, b, c); 
endmodule 

/////////////////////////////////////////////////
module xnorAdder(z, cout, a, b, cin); 
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input cin; 
wire[3:0] in, out,notBB;
 
not asd[3:0](notBB,b);
yAdder1 mine[3:0](z, out, a, notBB, in); 


endmodule

///////////////////////////////////////////////////
module yAdder(z, cout, a, b, cin); 
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input cin; 
wire[3:0] in, out; 

yAdder1 mine[3:0](z, out, a, b, in); 
assign in[0] = cin; 
assign in[3:1] = out[3:0]; 


endmodule


/////////////////////////////////////////////////

module yAdder1(z, cout, a, b, cin); 
output z, cout; 
input a, b, cin; 

xor left_xor(tmp, a, b); 
xor right_xor(z, cin, tmp); 
and left_and(outL, a, b); 
and right_and(outR, tmp, cin); 
or my_or(cout, outR, outL); 

endmodule 


////////////////////////////////////////////////////////////////////////
module yArith(z, cout, a, b, ctrl); 
// add if ctrl=0, subtract if ctrl=1
output [3:0] z; 
output cout; 
input [3:0] a, b; 
input ctrl; 
wire[3:0] notB, tmp; 
wire cin; 
// instantiate the components and connect them 
// Hint: about 4 lines of code 
xor nott[3:0](notB,ctrl,b);
assign cin =ctrl;
yAdder y(z, cout, a, notB, cin); 

endmodule 

///////////////////////////////////////////////////////////////////////////
module ALU4( Z, A, B, ctl);
output [3:0] Z;
input  [3:0] A, B;
input [2:0] ctl ;
wire cout,temp,zero;
// XNOR (exclussive NOR, in other words the complement of XOR) respectively.
wire [3:0] arith, andd, orr, xor_z, xnorr;
assign zero=0;
yArith my_arith(arith,cout,A,B,ctl[2]);	
and  my_and[3:0](andd, A, B);
or my_or[3:0](orr, A, B);
xnorAdder my_xor[3:0](xor_z,temp, A, B,zero);
yMux4to1 #(.SIZE(4)) my_mux(Z,arith,andd,orr,xnorr,ctl[1:0]);
endmodule

/////////////////////////////////////////////////////////////////////
module t_ALU;
reg [3:0] A, B, expect;
reg [2:0] ctl;
reg flag;
wire [3:0] Z;
integer i;
ALU4 my_alu(Z, A, B, ctl);

initial 
begin
	for(i=0;i<10;i=i+1)
	begin
	A=$random;
	B=$random;
	//flag = $value$plusargs("ctl=%b", ctl);
	
	
	ctl =3'b000; //add
		expect = A + B;
	#5	if (expect != Z)
		$display ("FAIL: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
		else 
		$display ("PASS: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	
	ctl = 3'b001; //and
		expect = A & B;
	#5	if (expect != Z)
		$display ("FAIL: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	else 
		$display ("PASS: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
		
	ctl = 3'b010; //or
		expect = A | B;
	#5	if (expect != Z)
		$display ("FAIL: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	else 
		$display ("PASS: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	
	ctl = 3'b100; //sub
		expect = A - B;
	#5	if (expect != Z)
		$display ("FAIL: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	else 
		$display ("PASS: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
		
	ctl = 3'b111; //111
		expect = ~(A^B);
	#5	if (expect != Z)
		$display ("FAIL: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);
	else 
		$display ("PASS: TIME=%5d A=%b B=%b Z=%b ctL=%b", $time, A, B, Z, ctl);

	$display ("");
	end



end
endmodule
//////////////////////////////////////////////////////////////////////////////