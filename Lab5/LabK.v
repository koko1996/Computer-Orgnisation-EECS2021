module  cfulladder(S,Cout,A,B,Cin);
output S; // a 1-bit register
output Cout; // a 1-bit register
input A; // a 1-bit register
input B; // a 1-bit register
input Cin; // a 1-bit register
wire AandB, AxorB, AxorB_xorC, AxorB_andC , Bb,Cout;
assign Bb = ~B;
and A_and_B(AandB, A, Bb);
xor  A_xor_B(AxorB,A,Bb);
xor A_xor_B_xor_c(AxorB_xorC,AxorB,Cin);
and A_xor_B_and_c(AxorB_andC,AxorB,Cin);
assign S = AxorB_xorC;
or C_out(Cout,AandB,AxorB_andC);

endmodule

module  sub4(S,Cout,A,B,Cin);
output [3:0] S; // a 4-bit register
output Cout; // a 1-bit register
input [3:0] A; // a 4-bit register
input [3:0] B; // a 4-bit register
input Cin; // a 1-bit register

cfulladder f0(S[0], Cout, A[0], B[0], Cin);// Least significant bit.
cfulladder f1(S[1], Cout, A[1], B[1], Cout);
cfulladder f2(S[2], Cout, A[2], B[2], Cout);
cfulladder f3(S[3], Cout, A[3], B[3], Cout);// Most significant bit.
endmodule




module  t_sub;
reg [3:0] A;
reg [3:0] B;
wire [3:0] S;
wire Cout;
reg Cin;


		sub4 myadder(S,Cout,A,B,Cin);
		
initial
begin
		A=1;B=0;Cin=0;
		repeat(7) begin
		A=A+1;B=B+1;Cin=0;
        #1 $display("A=%4b B=%4b S=%4b Cout=%1d",  A, B, S, Cin);
		end 

        $finish;
end
endmodule
