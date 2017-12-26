		.globl  MAX
		.globl  SIZE
		.globl  getCount
		.globl  setCount
		.globl  printLn
		.globl  signum
		.globl  isPrime
		
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
		
isPrime:#-------------------
		addi	$sp, $sp, -20
		sw		$ra, 0($sp)
		sw		$s1, 4($sp)
		sw		$s5, 8($sp)
		sw		$a0, 12($sp)
		sw		$a1, 16($sp)
		
		addi    $s5, $0 , 1    # s5 equal to 1 
		
		addi    $a1, $0 , 2 	# a1 = i = 2  // candidate
		addi    $s1, $0 , 1     # t1 = result 
	Loop: 
		bne   	$s1, $s5, exit
		slt     $t2, $a1 ,$a0 
		beq   	$t2, $0, exit
		
		jal      isFactor
		beq     $v0, $0 , negate
		addi 	$s1, $0 , 0
		j  		endOfLoop
		
negate: addi 	$s1, $0 , 1
		
		
endOfLoop: 
		addi    $a1, $a1 ,1
		j Loop
		
	exit:
		addi    $v0, $s1, 0 
		lw		$ra, 0($sp)
		lw		$s1, 4($sp)
		lw		$s5, 8($sp)
		lw		$a0, 12($sp)
		lw		$a1, 16($sp)
		addi	$sp, $sp, 20

		jr 	$ra
		#-------------------
		
		
isFactor: #-------------------
		   addi $v0, $0 , 0
		   rem  $t0, $a0, $a1;
		   bne  $t0, $0, returning
		   addi $v0, $0 , 1
		   
		   
returning: jr 	$ra
		  
		   #-------------------
		   
		   

			

