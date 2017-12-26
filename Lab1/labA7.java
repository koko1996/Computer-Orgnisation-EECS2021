package rehersal;

import java.util.Scanner;

public class labA7 {
	
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int i= sc.nextInt();
	 int temp1 = (i & 0b10000000000) << 10; //extract lowest bit #1 and place at pos# 4
	 int temp2 = (i & 0b100000000000000000000) >> 10; //extract bit #4 and place at pos #1
	 System.out.println(Integer.toBinaryString(i) + "   x | 1024   " +  i );

	 if(temp1 != temp2){
		 if(temp1 == 0){
		i = i | 0b10000000000;
		i = i & ~0b100000000000000000000;
	}
		 if(temp1 == 1){
				i = i & ~0b10000000000;
				i = i | 0b100000000000000000000;
			}
		 
	 }
	 System.out.println(Integer.toBinaryString(i) + "   x | 1024   " +  i );
	 
	}
}
