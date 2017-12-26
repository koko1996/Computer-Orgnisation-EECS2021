package rehersal;

import java.util.Scanner;

public class labA3 {

	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int input1 = sc.nextInt();
		int input2 = sc.nextInt();
		
		System.out.println( "x & y " + Integer.toBinaryString(input1) + "   " + Integer.toBinaryString(input2) + "   " + Integer.toBinaryString(input1 & input2));
		System.out.println( "x | y " + Integer.toBinaryString(input1) + "   " + Integer.toBinaryString(input2) + "   " + Integer.toBinaryString(input1 | input2));
		System.out.println( "x ^ y " + Integer.toBinaryString(input1) + "   " + Integer.toBinaryString(input2) + "   " + Integer.toBinaryString(input1 ^ input2));
		System.out.println( "~x " + Integer.toBinaryString(input1) + "   "  + Integer.toBinaryString(~input1));

	}
}








