module yMux1(z, a, b, c); 
output z; 
input a, b, c; 
wire notC, upper, lower; 
not my_not(notC, c); 
and upperAnd(upper, a, notC); 
and lowerAnd(lower, c, b); 
or my_or(z, upper, lower); 
endmodule 

module yMux(z, a, b, c); 
parameter SIZE = 2; 
output [SIZE-1:0] z; 
input [SIZE-1:0] a, b; 
input c; 
yMux1 mine[SIZE-1:0](z, a, b, c); 
endmodule 

module yMux4to1(z, a0,a1,a2,a3, c);
parameter SIZE = 2;
output [SIZE-1:0] z;
input [SIZE-1:0] a0, a1, a2, a3;
input [1:0] c;
wire [SIZE-1:0] zLo, zHi;

yMux #(SIZE) lo(zLo, a0 , a1, c[0]);
yMux #(SIZE) hi(zHi, a2 , a3, c[0]);
yMux #(SIZE) final(z, zLo, zHi, c[1]);

endmodule
module yAdder1(z, cout, a, b, cin); 
output z, cout; 
input a, b, cin; 
xor left_xor(tmp, a, b); 
xor right_xor(z, cin, tmp); 
and left_and(outL, a, b); 
and right_and(outR, tmp, cin); 
or my_or(cout, outR, outL); 
endmodule 

module yAdder(z, cout, a, b, cin); 
output [3:0] z; //4bit
output cout; 
input [3:0] a, b; //4bit
input cin; 
wire[3:0] in, out; //4bit

yAdder1 mine[3:0](z, out, a, b, in); 
assign in[0] = cin; 
assign in[3:1] = out[2:0];//4bit not sure
assign cout = out[3]; 
endmodule
module yArith(z, cout, a, b, ctrl);

output [3:0] z; //4bit
output cout;
input [3:0] a, b; //4bit
input ctrl;
wire [3:0] notB, tmp; //4bit
wire cin;

not not_b[3:0](notB,b);
yMux #(4) my_ctrl(tmp,b,notB,ctrl); 
yAdder adder(z,cout,a,tmp,ctrl);


//yAdder mine(z, out, a, notB, cin);
//assign cin = ctrl ? 1 : 0;
//assign notB = ctrl ? ~b : b;

endmodule

module yAlu(z,a,b,op);
input [3:0] a, b;
input [2:0] op;
output [3:0] z;

wire[3:0] arith_z,and_z, or_z, xnor_z;
wire cont;

yArith my_arith(arith_z,cout, a, b, op[2]);
and my_and[3:0](and_z,a,b);
or my_or[3:0] (or_z,a,b);
xor my_xor[3:0](xnor_z,a,b);


yMux4to1 #(4) my_mux(z,arith_z, and_z, or_z, xnor_z, op[1:0]);
endmodule
module t_ALU;

reg [3:0] a, b, expect;
reg [2:0] op;
reg flag;
wire [3:0] z;
wire ex;

yAlu my_alu(z,a,b,op);

initial
begin 
	repeat(10)
	begin
	a = $random;
	b = $random;
	flag = $value$plusargs("op=%b", op);
	if (op === 3'b000) //add
		expect = a + b;
	else if (op === 3'b001) //and
		expect = a & b;
	else if (op === 3'b010) //or
		expect = a | b;
	else if (op === 3'b100) //sub
		expect = a - b;
	else if (op === 3'b111) //111
		expect = (a == b);

	#1;
	if (expect != z)
		$display ("FAIL: a=%b b=%b op=%b z=%b expect=%b", a, b, op, z,expect);
	else 
		$display ("PASS: a=%b b=%b op=%b z=%b expect=%b", a, b, op, z,expect);

	end

end
endmodule
