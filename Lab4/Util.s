		.globl  println
		.globl  printFraction
#-----------------------------
		
		.text
println:#-------------------
		add     $a0,$0, '\n'
		addi    $v0, $0, 11
		syscall 	
		
		jr $ra
		
printFraction:#--------------
		
		addi    $v0, $0, 1
		syscall
		
		add     $a0,$0, '/'
		addi    $v0, $0, 11
		syscall		
		
		add     $a0,$0, $a1
		addi    $v0, $0, 1
		syscall
		
		jr $ra