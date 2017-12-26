		.globl  MAX
		.globl  SIZE
		.globl  getCount
		.globl  setCount
		.globl  printLn
		.globl  signum
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
		
signum:#-------------------
		slt  $t0, $a0, 0
		beq  $t0, $0, elseif
		add  $v0, $0, -1
		j theEnd
elseif: bne  $0, $a0, finalesle		
        addi $v0, $0 , 0
		j theEnd
finalesle: 
		addi $v0, $0 , 1 
		
		
theEnd: lw	 $t0, count($0)
		addi $t0, $t0, 1 
		sw   $t0, count($0)
	
		jr  $ra
		#-------------------