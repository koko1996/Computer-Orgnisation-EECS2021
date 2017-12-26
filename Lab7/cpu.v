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

yMux #(SIZE) lo(zLo, a0, a1, c[0]); 
yMux #(SIZE) hi(zHi, a2, a3, c[0]); 
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
output [31:0] z; 
output cout; 
input [31:0] a, b; 
input cin; 
wire[31:0] in, out; 

yAdder1 mine[31:0](z, out, a, b, in); 
assign in[0] = cin; 
assign in[31:1] = out[30:0]; 


endmodule


module yArith(z, cout, a, b, ctrl); 
// add if ctrl=0, subtract if ctrl=1
output [31:0] z; 
output cout; 
input [31:0] a, b; 
input ctrl; 
wire[31:0] notB, tmp; 
wire cin; 
// instantiate the components and connect them 
// Hint: about 4 lines of code 
xor nott[31:0](notB,ctrl,b);
assign cin =ctrl;
yAdder y(z, cout, a, notB, cin); 

endmodule


module yAlu(z, ex, a, b, op); 
// add if ctrl=0, subtract if ctrl=1
input [31:0] a, b; 
input [2:0] op; 
output [31:0] z; 
output ex; 
wire [31:0] add_sub,a_and_b,a_or_b,slt,temp;
wire condition;
assign slt[31:1] = 0;  // upper bits are always 0 

wire [15:0] z16;
wire [7:0] z8;
wire [3:0] z4;
wire [1:0] z2;
wire  z1;

// instantiate ex for zero 
or or16[15:0] (z16, z[15:0], z[31:16]); 
or or8[7:0]  (z8, z16[7:0], z16[15:8]); 
or or4[3:0]  (z4, z8[3:0], z8[7:4]); 
or or2[1:0]  (z2, z4[1:0], z4[3:2]); 
or or1[0:0]  (z1, z2[0] ,  z2[1]);
not (ex , z1);

// instantiate a circuit to set slt[0] 
xor  aywa(condition, a[31], b[31]); 
yArith  slt_arith(temp, cout, a, b, 1'b1); 
yMux  #(.SIZE(1)) slt_mux(slt[0], temp[31] , a[31], condition); 


yArith  as(add_sub, cout, a, b, op[2]); 
and  mm[31:0](a_and_b,a,b);
or   nn[31:0](a_or_b,a,b);
yMux4to1 #(.SIZE(32)) my_m(z, a_and_b, a_or_b, add_sub, slt, op[1:0]);

endmodule 


module yIF(ins, PCp4, PCin, clk); 
output [31:0] ins, PCp4; 
input [31:0] PCin; 
input clk; 
wire [31:0] z;
reg [31:0] memIn =0;
// build and connect the circuit 

register #(32) PCREG(z, PCin, clk, 1'b1); 
yAlu my_ALU(PCp4,ex,PCin,4,3'b010);
mem data(ins, PCin, memIn, clk, 1'b1, 1'b0); 
endmodule 


module yID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk); 
output [31:0] rd1, rd2, imm; 
output [25:0] jTarget; 
input [31:0] ins, wd; 
input RegDst, RegWrite, clk; 
wire [4:0] rn1, rn2, wn;
assign rn1 = ins[25:21]; 
assign rn2 = ins[20:16];
assign jTarget=ins[25:0];

yMux #(5) wn_mux(wn, rn2,ins[15:11],RegDst); 
rf myRF(rd1, rd2, rn1, rn2, wn, wd, clk, RegWrite);

assign imm[15:0] = ins[15:0]; 
yMux #(16) se(imm[31:16], 16'b0, 16'b1111111111111111, ins[15]); 

endmodule


module yEX(z, zero, rd1, rd2, imm, op, ALUSrc); 
output [31:0] z; 
output zero; 
input [31:0] rd1, rd2, imm; 
input [2:0] op; 
input ALUSrc; 
wire [31:0] b;
yMux #(32) wn_mux(b, rd2, imm, ALUSrc); 

yAlu my_ALU(z, zero, rd1, b , op); 
endmodule


module yDM(memOut, exeOut, rd2, clk, MemRead, MemWrite); 
output [31:0] memOut; 
input [31:0] exeOut, rd2; 
input clk, MemRead, MemWrite; 
// instantiate the circuit (only one line) 
// yDM(data memory): a data memory unit that reads from address 
//z or writes rd2 to that address based on two control signals and a clock
mem data(memOut, exeOut, rd2, clk, MemRead, MemWrite); 

endmodule 

//--------------------------------------------------------------- 
module yWB(wb, exeOut, memOut, Mem2Reg); 
output [31:0] wb; 
input [31:0] exeOut, memOut; 
input Mem2Reg; 
// instantiate the circuit (only one line) 
//yWB(write back): a 2-to-1 mux that selects either memOut or z based
// on whether the control signal Mem2Reg is 1 or 0, respectively.
yMux #(32) mux_2to1(wb, exeOut, memOut, Mem2Reg); 
endmodule 