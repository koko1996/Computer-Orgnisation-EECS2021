				.text         
		
main:		addi    $sp, $sp, -4 
		sw      $ra, 0($sp)    
	        addi    $s1, $0, 0	
	        addi    $s3, $0, 1 	# s3==1 	

	        addi     $v0, $0, 5        # v0 = readInt 
	        syscall         
	        add      $s0, $0, $v0	   # n = s0

	        addi     $v0, $0, 0        # v0 = 0  address 

loop:		beq      $s0,$s1 ,endOf   # i == n

	        addi     $s1, $s1, 1	  # i++

	        add      $a1, $0, $v0      # a1  address argument




	        addi     $v0, $0, 5        # v0 = readInt 
	        syscall         
	        add      $a0, $0, $v0	   # a0 integer argument
	
					
		jal 	 newc
		bne      $s1,$s3 ,NotFirst   # address of the first one
		addi	 $s4,$v0,0	      # address of the first one SAVE IN S4
NotFirst:
		j loop
		

endOf:
		#add     $a0,$0, '\n'
		#addi    $v0, $0, 11
		#syscall 	
		bne	 $s0,$0,ISNOTZERO
		addi     $a0,$0, 0
		addi     $v0, $0, 1
		syscall		
		j Final
				
ISNOTZERO:	addi	$a0, $s4, 0
		jal     sumint
	
		add     $a0,$0, $v0
		addi    $v0, $0, 1
		syscall
#--------------------------------------------		
			
Final:		lw      $ra, 0($sp)         
		addi    $sp, $sp, 4
		jr      $ra
		
