package rehersal;

import java.util.Scanner;

public class labA8 {

	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int x = sc.nextInt();
		int z = 1 + ~x; 
		System.out.println(Integer.toBinaryString(x)+"   " + x );
		System.out.println(Integer.toBinaryString(~x)+"   " + ~x );
		System.out.println(Integer.toBinaryString(z)+"   " + z );
	}
}
