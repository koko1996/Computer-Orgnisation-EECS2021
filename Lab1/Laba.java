package rehersal;
import java.util.Scanner;

//Name: KOKO NANAH JI
//Lab: A
//Method main: <brief explanation here>
//Arguments:
//args: <what does it do, is there error checking, etc> 
public class Laba
{
	public static void main(String[] args){
		Scanner sc = new Scanner(System.in);
		int input = sc.nextInt();
		int last8 = input & 0b11111111;
		System.out.println(Integer.toBinaryString(input) + "     " +  input );
		System.out.println(Integer.toBinaryString(last8) + "     " +  last8 );
		int temp = input &  0b1111111111111111111111100000000;
		System.out.println(Integer.toBinaryString(temp) + "     " +  temp );
		int answer = Integer.reverse(last8 << 24 ) | temp;
		System.out.println(Integer.toBinaryString(answer) +"  " + answer);

	}
}
