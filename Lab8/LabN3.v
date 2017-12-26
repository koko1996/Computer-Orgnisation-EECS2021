module labM; 
wire [31:0] PCin; 
wire RegDst, RegWrite, ALUSrc, Mem2Reg, MemRead, MemWrite; 
wire [2:0] op; 
reg INT, clk;
reg [31:0] entryPoint;
wire rtype, lw, sw, jump, branch;
wire [5:0] opCode, fnCode;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb; 
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


initial
	begin
	//------------------------------------Entry point
	entryPoint = 128; INT = 1; #1;
	//------------------------------------Run program
		repeat (43)
			begin
	//--------------------------------- Fetch an ins
			clk = 1; #1; INT = 0;
	//---------------------------------Set control signals  do nothing!
	//-------------------------------- Execute the ins
			clk = 0; #1;
	//---------------------------------View resultsas before
	     $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d  ALUop=%b op=%b rtype=%b branch=%b fnCode=%b  RegDst=%b RegWrite=%b ALUSrc=%b Mem2Reg=%b MemRead=%b MemWrite=%b",ins, rd1, rd2, z, zero, wb, ALUop, opCode, rtype, branch, fnCode ,RegDst,RegWrite,ALUSrc,Mem2Reg,MemRead, MemWrite); 

	//--------------------------------- Prepare for the next ins do nothing!
			end
		$finish;
end

endmodule 


