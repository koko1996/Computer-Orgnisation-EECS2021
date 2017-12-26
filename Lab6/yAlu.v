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
yArith  slt_arith(temp, cout, a, b, 1); 
yMux  #(.SIZE(1)) slt_mux(slt[0], temp[31] , a[31], condition); 


yArith  as(add_sub, cout, a, b, op[2]); 
and  mm[31:0](a_and_b,a,b);
or   nn[31:0](a_or_b,a,b);
yMux4to1 #(.SIZE(32)) my_m(z, a_and_b, a_or_b, add_sub, slt, op[1:0]);

endmodule 