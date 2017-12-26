package rehersal;

import java.util.Scanner;

public class labA6 {
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int x = sc.nextInt(); 
		System.out.println(Integer.toBinaryString(x) + "   " +  x );

		 
		x = x & ~0b100000000000 ;
		x = x | 1024 ;
	
	
		System.out.println(Integer.toBinaryString(x) + "   x | 1024   " +  x );

	
	}
	
}
