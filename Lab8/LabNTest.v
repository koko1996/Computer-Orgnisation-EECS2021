module labN;
reg [31:0] entryPoint;
reg clk, INT;
wire [31:0] ins, rd2, wb;
wire [4:0] rs,rt,rd;
wire [31:0] rsd, rtd, rdd, PC;
yChip myChip(rs, rt, rd, rsd, rtd,rdd, PC, ins, rd2, wb, entryPoint, INT, clk);

initial
begin
//------------------------------------Entry point
entryPoint = 128; INT = 1; #1;
//------------------------------------Run program
	repeat (43)
	begin
//---------------------------------Fetch an ins
		clk = 1; #1; INT = 0;
//---------------------------------Execute the ins
        clk = 0; #1;
//---------------------------------View results
	$display("%h: rs=%h rt=%h rd=%h rd1=%h rd2=%h z=%h", PC, rs, rt, rd, rsd, rtd, rdd);
	end
$finish;
end
endmodule
