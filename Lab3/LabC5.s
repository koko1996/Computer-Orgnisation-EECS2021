		.globl  MAX
		.globl  SIZE
		.globl  getCount
		.globl  setCount
		.globl  printLn
#-----------------------------
		.data
MAX:	.word 2147483647;
SIZE: 	.byte -32;
count: 	.word 0;
#-----------------------------
		.text
#-----------------------------
getCount: #-------------------
		lw	 $v0, count($0)
		jr 	 $ra
		
setCount: #-------------------
		sw   $a0, count($0);
		
		jr $ra
		
printLn:#-------------------
		addi	$sp, $sp, -8
		sw		$a0, 0($sp)
		sw		$v0, 4($sp)
		
		add     $a0,$0, '\n'
		addi    $v0, $0, 11
		syscall 	
		
		lw		$a0, 0($sp)
		lw		$v0, 4($sp)
		addi	$sp, $sp, 8
		
		jr $ra
		
