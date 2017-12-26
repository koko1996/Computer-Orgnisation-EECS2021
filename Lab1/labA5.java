package rehersal;

import java.util.Scanner;

public class labA5 {

	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int x = sc.nextInt();
		int z = x << 21;    // make bit #10 the MSb 
		System.out.println(Integer.toBinaryString(x) + "   " +  x );
		System.out.println(Integer.toBinaryString(z) + "   <<21   " +  z );
		z = z >>> 31;       // make bit #10 the LSb 
		System.out.println(Integer.toBinaryString(z) + "   >>>31  " +  z );
		int mask = 1024; 
		int y = x & mask; 
		System.out.println(Integer.toBinaryString(mask) + "     " +  mask );
		System.out.println(Integer.toBinaryString(y) + "  x& mask    " +  y );
		y = y >> 10; 
		System.out.println(Integer.toBinaryString(y) + "  y>>10  " +  y );
		
	
	}

}
