module labM; 
wire [31:0] memOut;
reg  [31:0] address, memIn;
reg	 clk, read, write;
mem data(memOut, address, memIn, clk, read, write); 

initial 
begin
	clk=0;
	write = 1;
	read = 0;
	address = 16; 
	memIn= 32'h12345678;
	clk=1;

	#1;
	clk=0;
	address = 20; 
	memIn= 32'h89abcdef;
	clk=1;
	
	#1;
	write = 0;
	read = 1;
	address = 16; 
repeat (3) 
begin 

   #1 $display("Address %d contains %h", address, memOut); 
   address = address + 4; 
end 

end
endmodule
