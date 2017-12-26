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
yAlu my_ALU(PCp4,ex,z,4,3'b010);
mem data(ins, z, memIn, clk, 1'b1, 1'b0); 
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

module yPC(PCin, PCp4,INT,entryPoint,imm,jTarget,zero,branch,jump);
output [31:0] PCin;
input [31:0] PCp4, entryPoint, imm;
input [25:0] jTarget;
input INT, zero, branch, jump;

wire [31:0] immX4, bTarget, choiceA, choiceB, PCTarget;
wire doBranch, zf;
assign immX4[31:2] = imm[29:0];
assign immX4[1:0] = 2'b00;
yAlu myALU(bTarget, zf, PCp4, immX4, 3'b010);
and (doBranch, branch, zero);
yMux #(32) mux1(choiceA, PCp4, bTarget, doBranch);

assign PCTarget[27:2] = jTarget[25:0];
assign PCTarget[1:0] = 2'b00;
assign PCTarget[31:28] = PCp4[31:28];

yMux #(32) mux2(choiceB, choiceA, PCTarget, jump);
yMux #(32) mux3(PCin, choiceB, entryPoint, INT);

endmodule




module yC1(rtype, lw, sw, jump, branch, opCode);
output rtype, lw, sw, jump, branch;
input [5:0] opCode;

// 100011
wire not4, not3, not2;
not (not4, opCode[4]);
not (not3, opCode[3]);
not (not2, opCode[2]);
and (lw, opCode[5], not4, not3, not2, opCode[1], opCode[0]);

// 101011
wire not_sw4, not_sw2;
not (not_sw4, opCode[4]);
not (not_sw2, opCode[2]);
and (sw, opCode[5], not_sw4, opCode[3], not_sw2, opCode[1], opCode[0]);

// 000100 
wire not_br2;
not (not_br2, opCode[2]);
nor (branch, opCode[5], opCode[4], opCode[3], not_br2, opCode[1], opCode[0]);

// 000010
wire not_j1;
not (not_j1, opCode[1]);
nor (jump, opCode[5], opCode[4], opCode[3], opCode[2], not_j1, opCode[0]);

// 000000
nor my_Rtype(rtype, opCode[2], opCode[5], opCode[4], opCode[3], opCode[1], opCode[0]);
endmodule


module yC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, branch);
output RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite;
input rtype, lw, sw, branch;

assign RegDst = rtype;
nor (ALUSrc, rtype, branch); 
nor	(RegWrite, branch, sw);
assign Mem2Reg=lw;
assign MemRead = lw;
assign MemWrite = sw;

endmodule


module yC3(ALUop, rtype, branch);
output [1:0] ALUop;
input rtype, branch;
// build the circuit
// Hint: you can do it in only 2 lines
assign ALUop[0] = branch;
assign ALUop[1] = rtype;
endmodule

module yC4(op, ALUop, fnCode);
output [2:0] op;
input [5:0] fnCode;
input [1:0] ALUop;
// instantiate and connect
and ALUop1_F1(ALUop1F1,ALUop[1],fnCode[1]);
or  ALUop1F1_AlUop0(op[2],ALUop1F1,ALUop[0]);
not (NOTfnCode2,fnCode[2]);
not (  NOTALUop1,ALUop[1]);
or ALUop1_F2(op[1], NOTALUop1, NOTfnCode2);
or 	F0_F3(F0F3,fnCode[0],fnCode[3]);
and F0F3_ALUop1(op[0], F0F3,ALUop[1]);

endmodule


module yChip(rs, rt, rd, rsd, rtd,rdd, PC,  ins, rd2, wb, entryPoint, INT, clk);
output [4:0] rs,rt,rd;
output [31:0] rsd, rtd, rdd, PC;
output [31:0] ins, rd2, wb;
input [31:0] entryPoint;
input INT, clk;

wire [31:0] PCin; 
wire RegDst, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite; 
wire [2:0] op; 
wire rtype, lw, sw, jump, branch;
wire [5:0] opCode, fnCode;
wire [31:0] wd, rd1, imm, PCp4, z, memOut; 
wire [25:0] jTarget; 
wire zero; 
wire [1:0] ALUop;

yIF myIF(ins, PCp4, PCin, clk);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk);
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc);
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite);
yWB myWB(wb, z, memOut, Mem2Reg);
assign wd = wb;
yPC myPC(PCin, PCp4,INT,entryPoint,imm,jTarget,zero,branch,jump);
assign opCode = ins[31:26];
yC1 myC1(rtype, lw, sw, jump, branch, opCode);
yC2 myC2(RegDst, ALUSrc, RegWrite, Mem2Reg, MemRead, MemWrite, rtype, lw, sw, branch);
assign fnCode = ins[5:0];
yC3 myC3(ALUop, rtype, branch);
yC4 myC4(op, ALUop, fnCode);

assign PC = PCin-4;
assign rs=ins[25:21];
assign rt =ins[20:16];
assign rd =ins[15:11];
assign rsd = rd1;
assign rtd =rd2;
assign rdd = z;

endmodule
