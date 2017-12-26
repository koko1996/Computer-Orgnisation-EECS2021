module labM; 
wire [31:0] PCin; 
reg RegDst, RegWrite, clk, ALUSrc, Mem2Reg, MemRead, MemWrite; 
reg [2:0] op; 
reg INT, branch, jump;
reg [31:0] entryPoint;
wire [31:0] wd, rd1, rd2, imm, ins, PCp4, z, memOut, wb; 
wire [25:0] jTarget; 
wire zero; 
yIF myIF(ins, PCp4, PCin, clk); 
yPC myPC(PCin, PCp4,INT,entryPoint,imm,jTarget,zero,branch,jump);
yID myID(rd1, rd2, imm, jTarget, ins, wd, RegDst, RegWrite, clk); 
yEX myEx(z, zero, rd1, rd2, imm, op, ALUSrc); 
yDM myDM(memOut, z, rd2, clk, MemRead, MemWrite); 
yWB myWB(wb, z, memOut, Mem2Reg); 
assign wd = wb; 

 
initial
	begin
//------------------------------------Entry point
	entryPoint = 128; INT = 1; #1;
//------------------------------------Run program

	repeat (43)
	begin
	//---------------------------------Fetch an ins
	clk = 1; #1; INT = 0;
     RegDst = 0; RegWrite = 0; ALUSrc = 1; op = 3'b010; 
  	Mem2Reg= 0; MemRead= 0; MemWrite=0;branch=0;jump=0;
	//---------------------------------Set control signals as before but add branch and jump
	if (ins[31:26] == 0) 
	begin   
	  RegDst = 1; RegWrite = 1; ALUSrc = 0;  Mem2Reg= 0; MemRead= 0; MemWrite=0;branch=0;jump=0;
	  // add
	  if (ins[5:0] == 'h20)
	  op = 3'b010;
	  // or
	  else if (ins[5:0] == 'h25)
	  op = 3'b001;
	end 
	
	 else if (ins[31:26] == 2) // Jump
	begin   
		RegDst = 0; RegWrite = 0; ALUSrc = 1; Mem2Reg=0 ; MemRead=0 ; MemWrite=0;branch=0;jump=1;
	end 
  
	// lw
	else if (ins[31:26] == 'h23)
	begin
	RegDst = 0;	RegWrite = 1;	ALUSrc = 1;	MemRead = 1;	MemWrite = 0;	Mem2Reg = 1;branch=0;jump=0;
	end

    // beq
	else if (ins[31:26] == 'h4)
	begin
	RegDst = 0;	RegWrite = 0;	ALUSrc = 0;	MemRead = 0;	MemWrite = 0;	Mem2Reg = 0;branch=1;jump=0;
	end
	
	// addi
	else if (ins[31:26] == 'h8)
	begin
	RegDst = 0;	RegWrite = 1;	ALUSrc = 1;	MemRead = 0;	MemWrite = 0;	Mem2Reg = 0;branch=0;jump=0;
	end

	// sw
	else if (ins[31:26] == 'h2b)
	begin
	RegDst=0;	RegWrite=0;	ALUSrc = 1;	MemRead = 0;	MemWrite = 1;   Mem2Reg=0;	branch=0;	jump=0;
	end
	
	//---------------------------------Execute the ins
	clk = 0; #1;
	//---------------------------------View results as before
     $display("%h: rd1=%2d rd2=%2d z=%3d zero=%b wb=%2d",ins, rd1, rd2, z, zero, wb); 

	//---------------------------------Prepare for the next ins do nothing
	
	 end
	#1 $finish;   
end

	

endmodule 


