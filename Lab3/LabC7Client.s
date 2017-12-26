		.text
main:	
		addi	$sp, $sp, -4
		sw		$ra, 0($sp)

		lw      $a0, MAX($0)
		addi 	$v0, $0, 1
		syscall
		
		jal 	printLn
		
		addi	$t0, $0,  4
		lb		$a0, MAX($t0)
#		addi    $v0, $0, 1
		syscall 	
		
		jal 	printLn
        addi     $v0, $0, 5        # v0 = readInt 
        syscall         
        add      $a0, $0, $v0		
		
		jal     isPrime
		add		$a0, $0, $v0
		addi 	$v0, $0, 1
		syscall		

		
		lw		$ra, 0($sp)
		addi	$sp, $sp, 4
		jr		$ra
		