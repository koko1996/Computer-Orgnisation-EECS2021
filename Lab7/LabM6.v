module labM; 
reg clk, read, write; 
reg [31:0] address, memIn; 
wire [31:0] memOut; 
mem data(memOut, address, memIn, clk, read, write); 
initial 
begin        
   address = 128; write = 0; read = 1; 
   repeat   (11)   
   begin 
   #1;
	if(memOut[31:26] == 0) // R Type
		$display("%0d %0d %0d %0d %0d", memOut[31:26], memOut[25:21], memOut[20:16], memOut[15:11], memOut[10:6], memOut[5:0] ); 
	else if(memOut[31:26] == 2) // J Type
		$display("%0d %0d", memOut[31:26], memOut[25:0]); 
    else  // I Type
		$display("%0d %0d %0d %0d", memOut[31:26], memOut[25:21], memOut[20:16], memOut[15:0]);
    address = address + 4; 
	end 
end 
endmodule 