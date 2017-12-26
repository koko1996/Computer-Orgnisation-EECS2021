package rehersal;

import java.util.Scanner;

public class labA4 {
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int input1 = sc.nextInt();
		
		System.out.println( "x << 1 " + Integer.toBinaryString(input1) + "   " + (input1<<1) + "   " + Integer.toBinaryString(input1<<1 ));
		System.out.println( "x >>> 1 " + Integer.toBinaryString(input1) + "   " + (input1>>>1) +"   " + Integer.toBinaryString(input1>>>1 ));
		System.out.println( "x >> 1 " + Integer.toBinaryString(input1) + "   " + (input1>>1) + "   " + Integer.toBinaryString(input1>>1 ));
		
		System.out.println();
		System.out.println( "x << 2 " + Integer.toBinaryString(input1) + "   " + (input1<<2) + "   " + Integer.toBinaryString(input1<<2 ));
		System.out.println( "x >>> 2 " + Integer.toBinaryString(input1) + "   " + (input1>>>2) +"   " + Integer.toBinaryString(input1>>>2 ));
		System.out.println( "x >> 2 " + Integer.toBinaryString(input1) + "   " + (input1>>2) + "   " + Integer.toBinaryString(input1>>2 ));
	}
}
